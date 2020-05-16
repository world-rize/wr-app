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

pwd = os.path.dirname(os.path.abspath(__file__))
root = f'{pwd}/../assets'
# bold pettern
bold_pattern = re.compile(r"[\(（](.*?)[\)）]")


def strip_brs(txt):
    """
    """
    lines = txt.split('\n')
    lines = [l for l in lines if l != '\n']
    return '\n'.join(lines).strip()


def phrase_txt2json(phrase_txt, lesson_id, phrase_id):
    def create_meta():
        return {
            'lessonId': lesson_id,
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
        # voice/<lesson_id>-<phrase-id>-<1-3>_<locale>.mp3
        # return f'voice/{phrase_id}-{index}_{locale}.mp3'
        return f'voice/{lesson_id}-{phrase_id}-{index}_{locale}.mp3'

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
        title_ja, title_en = '', ''
        for ja in jas:
            bold = re.search(bold_pattern, ja)
            if bold is not None:
                title_ja = bold.group(1)
                break
        else:
            print(f'[Warn] {lesson_id} {phrase_id} title(ja) is empty')
            title_ja = jas[1]


        for en in ens:
            bold = re.search(bold_pattern, en)
            if bold is not None:
                title_en = bold.group(1)
                break
        else:
            print(f'[Warn] {lesson_id} {phrase_id} title(en) is empty')
            title_en = ens[1]

        return {
            'en': title_en,
            'ja': title_ja,
        }


    def create_advice(advice):
        if advice == '':
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
            'assets': {
                'voice': { 
                    locale: voice_path('kp', locale) for locale in ['en-us', 'en-au', 'en-uk']
                },
            },
            'advice': create_advice(advice),
            'example': create_examples(jas, ens),
        }

        return phrase_json
    except Exception as e:
        print(f'[Warn] {lesson_id} {phrase_id} invalid')
        print(e)
        return None

def parse_txt(text):
    """
    """
    # split lessons
    sep = '________________'
    # lessons[0]: legends
    # lessons[1..]: lessons contents
    _, *lessons = text.split(sep)
    lessons = list(map(strip_brs, lessons))

    phrases_txt_list = []
    lessons_json = []
    # parse lessons
    for lesson in lessons:
        # phrases[0]: title
        # phrases[1..]: phrases contents
        header, *phrases = re.split(r'^\d+\.', lesson, flags=re.MULTILINE)
        phrases_txt_list.append(phrases)
        title = strip_brs(header)
        lesson_id = title.split(' ')[0].strip(string.punctuation).lower()
        print(f'title: {title}, id: {lesson_id}')
    
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
    for lesson_json, phrases in zip(lessons_json, phrases_txt_list):
        for phrase_id, phrase in enumerate(phrases, start=1):
            phrase_json = phrase_txt2json(phrase, lesson_id=lesson_json['id'], phrase_id=phrase_id)
            if phrase_json is not None:
                phrases_json.append(phrase_json)

    print(f'{len(phrases_json)} / {sum(map(len, phrases_txt_list))} phrases successfully dumped.') 

    return lessons_json, phrases_json


def generate(preview=False):
    # exported from google drive
    lessons_txt_path = f'{root}/World RIZe Main Part Phrases.txt'
    lessons_json_path = f'{root}/lessons.json'
    phrases_json_path  = f'{root}/phrases.json'
    force = '-f' in sys.argv

    if force:
        print('-f')

    with open(lessons_txt_path) as f:
        text = f.read()

    lessons_json, phrases_json = parse_txt(text)

    if preview:
        return

    if not force and os.path.exists(lessons_json_path):
        print(f'[Warn] {lessons_json_path} is already exists')
        return

    with open(lessons_json_path, 'w') as f:
        print(json.dumps(lessons_json, ensure_ascii=False, indent=2), file=f)
        print(f'[Generated] {lessons_json_path}')

    with open(phrases_json_path, 'w') as f:
        print(json.dumps(phrases_json, ensure_ascii=False, indent=2), file=f)
        print(f'[Generated] {phrases_json_path}')


if __name__ == '__main__':
    generate()