"""
Phrase to Json Convertor

@author yoshiki301, kmt
"""
import json
import re
import copy
import sys
import os
import glob
import string
import chalk
from tqdm import tqdm

pwd = os.path.dirname(os.path.abspath(__file__))
root = f'{pwd}/../assets'
# bold pettern
bold_pattern = re.compile(r"[\(（](.*?)[\)）]")
verbose = False
white, yellow = chalk.Chalk('white'), chalk.Chalk('yellow')

# exported from google drive
lessons_txt_path = f'{root}/phrases/v1.md'
lessons_json_path = f'{root}/lessons.json'
phrases_json_path  = f'{root}/phrases.json'

def strip_brs(txt):
    """
    """
    lines = txt.split('\n')
    lines = [l for l in lines if l != '\n']
    return '\n'.join(lines).strip()


def phrase_txt2json(phrase_txt, lesson_id, phrase_id):
    global verbose
    
    def create_meta():
        return {
            'lessonId': lesson_id,
            'phraseId': str(phrase_id),
        }


    def create_examples(jas, ens):
        example_value = []
        for i, (ja, en) in enumerate(zip(jas, ens), start=1):
            example_value.append({
                # '@type': 'Message',
                'text': {
                    'en': en,
                    'ja': ja,
                },
                'assets': create_assets(i),
            })

        return {
            # '@type': 'Conversation',
            'value': example_value,
        }

    def voice_path(index, locale):
        # 'assets/' prefixed
        return f'voice/{lesson_id}_{phrase_id}_{index}_{locale}.mp3'

    def create_assets(index):
        """
        lesson_id: e.g. Shcool
        code: e.g. en-us
        """
        return {
            'voice': { 
                # todo
                locale: voice_path(index, locale) for locale in ['en-us', 'en-au', 'en-uk']
            }
        }


    def create_title(jas, ens):
        global verbose
        title_ja, title_en = '', ''
        for ja in jas:
            bold = re.search(bold_pattern, ja)
            if bold is not None:
                title_ja = bold.group(1)
                break
        else:
            global verbose
            if verbose:
                print(f'[Warning] {lesson_id} {phrase_id} title(ja) is empty')
            title_ja = jas[1]


        for en in ens:
            bold = re.search(bold_pattern, en)
            if bold is not None:
                title_en = bold.group(1)
                break
        else:
            if verbose:
                print(f'[Warning] {lesson_id} {phrase_id} title(en) is empty')
            title_en = ens[1]

        return {
            'en': title_en,
            'ja': title_ja,
        }


    def create_advice(advice):
        if advice == '':
            global verbose
            if verbose:
                print(f'[Warn] {lesson_id} {phrase_id} advice is empty')

        return {
            'ja': advice.strip()
        }


    """
    """
    content = strip_brs(phrase_txt)
    
    try:
        en1, ja1, en2, ja2, en3, ja3, *advice = content.split('\n')
        jas = [ja1, ja2, ja3]
        ens = [en1, en2, en3]
        advice = strip_brs('\n'.join(advice))

        phrase_json = {
            'id': str(phrase_id).zfill(4),
            'title': create_title(jas, ens),
            'meta': create_meta(),
            # key phrase
            'assets': {
                'voice': {
                    locale: voice_path('kp', locale) for locale in ['en-us', 'en-au', 'en-uk']
                },
            },
            'advice': create_advice(advice),
            'example': create_examples(jas, ens),
        }

        # check voice
        kp_path = phrase_json['assets']['voice']['en-us']
        exist_voice = os.path.exists(f'{root}/{kp_path}')

        
        # if exist_voice:
        #     print(f'[Info] {lesson_id} {phrase_id} voice found')

        return phrase_json
    except Exception as e:
        print(f'[Warning] {lesson_id} {phrase_id} invalid')
        if verbose:
            print(e)
        return None

def parse_txt(text):
    """
    """
    # split lessons
    sep = '#'
    # lessons[0]: legends
    # lessons[1..]: lessons contents
    _, *lessons = text.split(sep)
    lessons = list(map(strip_brs, lessons))

    assert(len(lessons) == 15)

    phrases_txt_list = []
    lessons_json = []

    print(f'{white("📚 Overview", bold=True)}')

    # parse lessons
    for lesson in lessons:
        # phrases[0]: title
        # phrases[1..]: phrases contents
        header, *phrases = re.split(r'^\d+\.', lesson, flags=re.MULTILINE)
        phrases_txt_list.append(phrases)
        title = strip_brs(header)
        # ex: 'Social Media' -> 'social'
        lesson_id = title.split(' ')[0].strip(string.punctuation).lower()

        print(f'  - {white(title, bold=True)}({lesson_id}) {yellow(len(phrases))} Phrases')
    
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

        lessons_json.append(lesson_json)

    phrases_json = []
    pbar = tqdm(leave=True, total=sum(map(len, phrases_txt_list)))
    for lesson_json, phrases in zip(lessons_json, phrases_txt_list):
        for phrase_id, phrase in enumerate(phrases, start=1):
            phrase_json = phrase_txt2json(phrase, lesson_id=lesson_json['id'], phrase_id=phrase_id)

            if phrase_json is not None:
                phrases_json.append(phrase_json)

            pbar.update(1)

    print(f'{len(phrases_json)} / {sum(map(len, phrases_txt_list))} phrases successfully dumped.') 

    return lessons_json, phrases_json


def generate(preview=False):
    global verbose, lessons_txt_path, lessons_json_path, phrases_json_path
    force = '-f' in sys.argv
    verbose = '-v' in sys.argv

    print(f'{white("Phrase Convertor", bold=True)}')

    with open(lessons_txt_path) as f:
        text = f.read()

    lessons_json, phrases_json = parse_txt(text)

    if preview:
        return

    if not force and os.path.exists(lessons_json_path):
        print(f'[Warning] {lessons_json_path} is already exists')
        return

    with open(lessons_json_path, 'w') as f:
        print(json.dumps(lessons_json, ensure_ascii=False, indent=2), file=f)
        print(f'✔  {yellow("Dump")} {lessons_json_path}')

    with open(phrases_json_path, 'w') as f:
        print(json.dumps(phrases_json, ensure_ascii=False, indent=2), file=f)
        print(f'✔  {yellow("Dump")} {phrases_json_path}')


if __name__ == '__main__':
    generate()