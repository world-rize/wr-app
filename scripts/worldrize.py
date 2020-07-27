"""
WorldRIZe CLI
"""
import os
import json
from pathlib import Path
import chalk
from tqdm import tqdm
import shutil
import requests
import fire
from dotenv import load_dotenv
import urllib.parse

pwd = Path(__file__).resolve().parent
env = pwd.parent / '.env/.env'
load_dotenv(env)
root = pwd.parent / 'assets'
voices_path = pwd / 'voices'
green, red = chalk.Chalk('green'), chalk.Chalk('red')

def success(*args):
    print(f'{green("✔")} ', *args)

def error(*args):
    print(f'{red("✗")} ', *args)

def generate_phrase_voices(phrase: object):
    # kp, 1, 2, 3
    base_id = f'{phrase["meta"]["lessonId"]}_{phrase["meta"]["phraseId"]}'
    voices = []
    for language in ['en-us', 'en-au', 'en-uk']:
        path = voices_path / f'{base_id}_kp_{language}.mp3'
        voices.append({
            'path': path,
            'gender_voice': 'male',
            'language': language,
            'text': phrase['title']['en'],
        })
    for i, example in enumerate(phrase['example']['value'], start=1):
        for language in ['en-us', 'en-au', 'en-uk']:
            path = voices_path / f'{base_id}_{i}_{language}.mp3'
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
    text = text.replace(' ', ' ').replace('’', '\'')

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
        raise Exception(res.text)

    res = res.json()
    if res['error']:
        raise Exception(res['error'])

    audio_src = res['audio_src']

    res = requests.get(audio_src, stream=True)

    if res.status_code == 200:
        with open(out_path, 'wb') as f:
            shutil.copyfileobj(res.raw, f)

class Cli(object):
    def phrases(self):
        """ Generate Phrases """
        pass

    def voices(self):
        """ Generate voices"""
        # read phrases.json
        phrases_json_path = root / 'phrases.json'
        if not phrases_json_path.exists():
            error('Lessons JSON File')
            exit()
        
        with open(phrases_json_path, 'r') as j:
            phrases = json.load(j)
        
        start, stop = 0, 1
        for phrase in phrases[start:stop]:
            generate_phrase_voices(phrase)

    def info(self, verbose=False):
        """ Show infomation """
        lessons_txt_path = root / 'phrases/v1.md'
        (success if lessons_txt_path.exists() else error)('Phrases Markdown File')

        lessons_json_path = root / 'lessons.json'
        (success if lessons_json_path.exists() else error)('Lessons JSON File')
        
        phrases_json_path  = root / 'phrases.json'
        (success if phrases_json_path.exists() else error)('Phrases JSON File')

if __name__ == '__main__':
    fire.Fire(Cli)