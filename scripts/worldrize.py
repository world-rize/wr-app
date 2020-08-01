"""
WorldRIZe CLI
"""
import os, re, json, shutil, requests, string
import fire, chalk
from pathlib import Path
from dotenv import load_dotenv

pwd = Path(__file__).resolve().parent
env = pwd.parent / '.env/.env'
load_dotenv(env)
green, red = chalk.Chalk('green'), chalk.Chalk('red')

def success(*args):
    print(f'{green("✔")} ', *args)

def info(*args):
    print(f'🔖 ', *args)

def error(*args):
    print(f'{red("✗")} ', *args)

def strip_brs(txt: str):
    lines = txt.split('\n')
    lines = [l for l in lines if l != '\n']
    return '\n'.join(lines).strip()

def generate_phrase_voices(phrase: object, out_dir: Path):
    # kp, 1, 2, 3
    base_id = f'{phrase["meta"]["lessonId"]}_{phrase["meta"]["phraseId"]}'
    voices = []
    for language in ['en-us', 'en-au', 'en-uk']:
        path = out_dir / f'{base_id}_kp_{language}.mp3'
        voices.append({
            'path': path,
            'gender_voice': 'male',
            'language': language,
            'text': phrase['title']['en'],
        })
    for i, example in enumerate(phrase['example']['value'], start=1):
        for language in ['en-us', 'en-au', 'en-uk']:
            path = out_dir / f'{base_id}_{i}_{language}.mp3'
            voices.append({
                'path': path,
                'gender_voice': 'male' if i % 2 == 0 else 'female',
                'language': language,
                'text': example['text']['en'],
            })

    for voice in voices:
        if not voice['path'].exists():
            call_api(os.environ['WOORD_ACCESS_KEY'], text=voice['text'], gender_voice=voice['gender_voice'], language=voice['language'], out_path=voice['path'])
            success(f'Generated {voice["path"]}')
        else:
            success(f'Skipped {voice["path"]}')

def call_api(access_key: str, text: str, gender_voice: str, language: str, out_path: Path):
    """
    gender_voice: 'male' | 'female'
    language: 'en-us' | 'en-uk' | 'en-au' -> 'en_US' | 'en_GB' | 'en_AU'
    """
    language_map = {
        'en-us': 'en_US',
        'en-uk': 'en_GB',
        'en-au': 'en_AU',
    }
    language = language_map[language]
    if language is None:
        raise Exception('invalid language')
    if gender_voice not in ['male', 'female']:
        raise Exception('invalid gender_type')
    # ' ' -> '+'
    text = text \
        .replace(' ', ' ') \
        .replace('’', '\'') \
        .replace('（', '') \
        .replace('）', '')

    data = {
        'text': text,
        'gender_voice': gender_voice,
        'language': language,
    }
    headers = {
        'Accept': 'application/json',
        'Authorization': f'Bearer {access_key}'
    }
    # res: {"message":"Your audio has been created!","audio_src":"https:\/\/getwoord.s3.amazonaws.com\/4273352455515882618255eaaf3c1cbdbe0.55443890.mp3","error":false}
    res = requests.post('https://www.getwoord.com/api/convert', headers=headers, data=data)
    if res.status_code != 200:
        error(f'{data}')
        error(f'{res.status_code} {res.json()["message"]}')
        raise Exception()

    res = res.json()
    if res['error']:
        error(f'Error {res["error"]}')
        raise Exception()

    audio_src = res['audio_src']

    res = requests.get(audio_src, stream=True)

    if res.status_code == 200:
        with open(out_path, 'wb') as f:
            shutil.copyfileobj(res.raw, f)

class PhrasesParser(object):
    def __init__(self, verbose=False):
        self.verbose = verbose
        self.lessons = []
        self.phrases = []
        self.phrase_id = 0

    def _parse_phrase(self, phrase_txt: str, lesson_id: str, phrase_id: str):
        # unique phrase id
        master_id = f'{lesson_id}_{phrase_id}'

        def create_assets(index: str):
            return {
                'voice': { 
                    locale: f'voices/{master_id}_{index}_{locale}.mp3' for locale in ['en-us', 'en-au', 'en-uk']
                }
            }

        bold_pattern = re.compile(r"[\(（](.*?)[\)）]")
        content = strip_brs(phrase_txt)
        
        try:
            en1, ja1, en2, ja2, en3, ja3, *advice = content.split('\n')
            jas = [ja1, ja2, ja3]
            ens = [en1, en2, en3]
            advice = strip_brs('\n'.join(advice))
            example_value = []
            for i, (ja, en) in enumerate(zip(jas, ens), start=1):
                example_value.append({
                    'text': {
                        'en': en,
                        'ja': ja,
                    },
                    'assets': create_assets(i),
                })

            title_ja, title_en = '', ''
            for ja in jas:
                bold = re.search(bold_pattern, ja)
                if bold is not None:
                    title_ja = bold.group(1)
                    break
            else:
                if self.verbose: error(f'Warning {master_id} title(ja) is empty')
                title_ja = jas[1]

            for en in ens:
                bold = re.search(bold_pattern, en)
                if bold is not None:
                    title_en = bold.group(1)
                    break
            else:
                if self.verbose: error(f'Warning {master_id} title(en) is empty')
                title_en = ens[1]

            phrase_json = {
                'id': master_id,
                'title': {
                    'en': title_en,
                    'ja': title_ja,
                },
                'meta': {
                    'lessonId': lesson_id,
                    'phraseId': phrase_id,
                },
                # key phrase
                'assets': {
                    'voice': {
                        locale: f'voices/{master_id}_kp_{locale}.mp3' for locale in ['en-us', 'en-au', 'en-uk']
                    },
                },
                'advice': {
                    'ja': advice.strip()
                },
                'example': {
                    'value': example_value,
                }
            }

            self.phrases.append(phrase_json)
        except Exception as e:
            error(f'Warning {master_id} invalid')
            error('\t', e)

    def _parse_lesson(self, lesson_txt: str):
        lesson_txt = strip_brs(lesson_txt)
        # phrases[0]: title
        # phrases[1..]: phrases contents
        header, *phrases = re.split(r'^\d+\.', lesson_txt, flags=re.MULTILINE)
        title = strip_brs(header)
        # ex: 'Social Media' -> 'social'
        lesson_id = title.split(' ')[0].strip(string.punctuation).lower()

        for phrase_id, phrase_txt in enumerate(phrases, start=1):
            self._parse_phrase(phrase_txt, lesson_id=lesson_id, phrase_id=str(phrase_id))

        lesson_json = {
            'id': lesson_id,
            'title': {
                'en': title,
                'ja': title,
            },
            'assets': {
                'img': {
                    'thumbnail': f'assets/thumbnails/{lesson_id}.png'
                }
            }
        }
        self.lessons.append(lesson_json)

    def parse(self, src: str):
        # lessons[0]: legends
        # lessons[1..]: lessons contents
        _, *lessons = src.split('#')
        for lesson in lessons:
            self._parse_lesson(lesson)

        lessons_count = len(self.lessons)
        phrases_count = len(self.phrases)
        success(f'Parsed {lessons_count} Lessons, {phrases_count} Phrases.') 
        return self.lessons, self.phrases

class Cli(object):
    def __init__(self):
        self.root = pwd.parent / 'assets'
        self.voices_path = self.root / 'voices'
        self.lessons_txt_path = self.root / 'contents/phrases.md'
        self.lessons_json_path = self.root / 'lessons.json'
        self.phrases_json_path  = self.root / 'phrases.json'

    def resources(self):
        """ Download thumbnails from Google Drive """
        # TODO
        pass

    def phrases(self, verbose=False, dry_run=False):
        """ Generate Phrases """
        src = self.lessons_txt_path.read_text()

        parser = PhrasesParser(verbose=verbose)
        lessons_json, phrases_json = parser.parse(src)

        if self.lessons_json_path.exists():
            info(f'{self.lessons_json_path} is already exists')

        lessons = json.dumps(lessons_json, ensure_ascii=False, indent=2)
        phrases = json.dumps(phrases_json, ensure_ascii=False, indent=2)
        if not dry_run:
            self.lessons_json_path.write_text(lessons)
            self.phrases_json_path.write_text(phrases)
        else:
            info('Dry Run Mode')

        success(f'Generated {self.lessons_json_path}')
        success(f'Generated {self.phrases_json_path}')

    def voices(self):
        """ Generate voices"""
        # read phrases.json
        if not self.phrases_json_path.exists():
            error('Lessons JSON File')
            exit()
        
        with self.phrases_json_path.open('r') as j:
            phrases = json.load(j)
        
        for i, phrase in enumerate(phrases):
            print(i, end=' ')
            generate_phrase_voices(phrase, out_dir=self.voices_path)

    def info(self, verbose=True):
        """ Show infomation """
        if self.lessons_txt_path.exists():
            success('Phrases Markdown File')
        else:
            error('Not Found Phrases Markdown File')

        if self.lessons_json_path.exists():
            success(f'Lessons JSON {self.lessons_json_path}')
            if verbose:
                with self.lessons_json_path.open('r') as j:
                    lessons = json.load(j)
                    info(f'{len(lessons)} Lessons found')
                    for lesson in lessons:
                        info(f'\t{lesson["id"]}')
        else:
            error(f'Lessons JSON Not Found {self.lessons_json_path}')

        if self.phrases_json_path.exists():
            success(f'Phrases JSON Found {self.phrases_json_path}')
            if verbose:
                with self.phrases_json_path.open('r') as j:
                    phrases = json.load(j)
                    info(f'{len(phrases)} Phrases found')
                    for phrase in phrases:
                        info(f'{phrase["id"].ljust(15)} {phrase["title"]["ja"]}')
        else:
            error(f'Phrases JSON Not Found {self.phrases_json_path}')
 
        if self.voices_path.exists():
            success(f'Voices Dir {self.voices_path}')
            if verbose:
                voices_count = len(list(self.voices_path.iterdir()))
                success(f'{voices_count} Voices Found')
        else:
            error(f'Voices Dir Not Found {self.voices_path}')

if __name__ == '__main__':
    fire.Fire(Cli)