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

pwd = os.path.dirname(__file__)
root = f'{pwd}/../assets'
# bold pettern
bold_pattern = re.compile(r"[\(（](.*?)[\)）]")
id_counter = 1
valid_counter = 0

def txt2json(lesson_id, readlines):
    global id_counter
    # テキストデータの読み込み
    lesson_to_id = {}
    label = ""
    eng_or_jap = "en"
    value_list = []
    phrase_eng = ""
    phrase_jap = ""
    content_data = []
    content_line = {
        '@type': 'Message',
        'text': {},
        'assets': {},
    }

    for line in readlines:
        if label == "contents" and line != "\n":
            if eng_or_jap == 'en':
                content_line['text'][eng_or_jap] = line
                eng_or_jap = 'ja'
                bold = re.search(bold_pattern,line) # 強調文字を取得
                if bold is not None:
                    phrase_eng = bold.group(1)
            elif eng_or_jap == 'ja':
                content_line['text'][eng_or_jap] = line
                eng_or_jap = 'en'
                bold = re.search(bold_pattern,line) # 強調文字を取得
                if bold is not None:
                    phrase_jap = bold.group(1)
                
                content_line['assets'] = {
                    'voice': { 
                        code: voice_path(lesson_id, code) for code in ['en-us', 'en-au', 'en-uk']
                    }
                }
                value_list.append(copy.deepcopy(content_line)) # 値渡しすることに注意

        elif label == "contents" and line == "\n":
            label = "advice"

        elif line != "\n":
            if re.search("_",line): # lessonの区切りを検出
                label = "lesson"
                # print('-> lesson')
            elif label == "lesson":
                lesson_title = line.strip("\n")
                if not lesson_title in lesson_to_id:
                    zfill_id = str(len(lesson_to_id)+1).zfill(4)
                    lesson_to_id[lesson_title] = zfill_id
                # lesson_id = lesson_to_id[lesson_title]
                # label = "section"
                label = 'contents'
                # print('-> contents')
            elif label == "section":
                section_id = line.strip().strip(".").zfill(4)
                label = "contents"
                # print('-> contents')
            elif label == "advice":
                advice = line
                label = "section"
                # このタイミングで作成
                data = {}
                data["id"] = str(id_counter).zfill(4)
                data["title"] = {
                    "ja": phrase_jap,
                    "en": phrase_eng
                }
                data["meta"] = {
                    "lessonId": lesson_id,
                }
                data["advice"] = {
                    'ja': advice
                }
                data["example"] = {
                    "@type": "Conversation",
                    "value": value_list
                }
                content_data.append(copy.deepcopy(data)) # 値渡しすることに注意
                id_counter += 1
                value_list = []
                label = "section"

    return content_data


def strip_brs(txt):
    """
    """
    lines = txt.split('\n')
    lines = [l for l in lines if l != '\n']
    return '\n'.join(lines).strip()


def phrase_txt2json(phrase_txt, lesson_id, start):
    def create_meta():
        return {
            'lessonId': lesson_id,
        }


    def create_examples(jas, ens):
        example_value = []
        for ja, en in zip(jas, ens):
            example_value.append({
                '@type': 'Message',
                'value': {
                    'en': en,
                    'ja': ja,
                },
            })

        return {
            '@type': 'Conversation',
            'value': example_value,
        }

    def create_assets(jas, ens):
        """
        lesson_id: e.g. Shcool
        code: e.g. en-us
        """
        return {
            'voice': { 
                # todo
                code: f'voice_sample.mp3' for code in ['en-us', 'en-au', 'en-uk']
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
            print(f'[Warn] {lesson_id} {id_counter - start} title(ja) is empty')
            title_ja = jas[1]


        for en in ens:
            bold = re.search(bold_pattern, en)
            if bold is not None:
                title_en = bold.group(1)
                break
        else:
            print(f'[Warn] {lesson_id} {id_counter - start} title(en) is empty')
            title_en = ens[1]

        return {
            'en': title_en,
            'ja': title_ja,
        }


    def create_advice(advice):
        if advice == '':
            print(f'[Warn] {lesson_id} {id_counter - start} advice is empty')

        return {
            'ja': advice.strip()
        }


    """
    """
    global id_counter
    content = strip_brs(phrase_txt)
    
    try:
        en1, ja1, en2, ja2, en3, ja3, *advice = content.split('\n')
        jas = [ja1, ja2, ja3]
        ens = [en1, en2, en3]
        advice = strip_brs('\n'.join(advice))

        phrase_json = {
            'id': str(id_counter).zfill(4),
            'title': create_title(jas, ens),
            'meta': create_meta(),
            'assets': create_assets(jas, ens),
            'advice': create_advice(advice),
            'example': create_examples(jas, ens),
        }

        return phrase_json
    except:
        print(f'[Warn] {lesson_id} {id_counter - start} invalid')
        return None
    finally:
        id_counter += 1

def lessons_splitter(lessons_txt):
    """
    returns lesson: Lesson, phrases: Phrase[]
    """
    sep = '________________'
    # lessons[0]: legends
    # lessons[1..]: lessons contents
    _, *lessons = lessons_txt.split(sep)
    return list(map(strip_brs, lessons))


def lesson2json(lesson_txt):
    """
    """
    # phrases[0]: title
    # phrases[1..]: phrases contents
    header, *phrases_txt = re.split(r'^\d+\.$', lesson_txt, flags=re.MULTILINE)
    title = strip_brs(header)
    _id = title.split(' ')[0].strip(string.punctuation)
    # print(f'title: {title}, id: {_id}')

    lesson_json = {
        'id': _id,
        'title': {
            'en': title,
            'ja': title,
        },
        'assets': {
            'img': {
                'thumbnail': 'thumbnails/school.png'
            }
        }
    }

    phrases_json = []
    global id_counter, valid_counter
    start = id_counter
    for phrase_txt in phrases_txt:
        phrase_json = phrase_txt2json(phrase_txt, _id, start)
        if phrase_json is not None:
            phrases_json.append(phrase_json)
            valid_counter += 1

    return lesson_json, phrases_json


def generate(preview=False):
    lessons_txt_path = f'{root}/phrases.txt'
    lessons_json_path = f'{root}/lessons.json'
    phrases_json_dir = f'{root}/lessons'

    with open(lessons_txt_path) as f:
        lessons_txt = f.read()

    lessons_json = []
    phrases_json_list = []
    lessons = lessons_splitter(lessons_txt)
    for lesson in lessons:
        lesson_json, phrases_json = lesson2json(lesson)
        lessons_json.append(lesson_json)
        phrases_json_list.append(phrases_json)

    global id_counter, valid_counter
    print(f'{valid_counter} / {id_counter} phrases successfully dumped.') 

    if preview:
        # print(json.dumps(lessons_json, indent=2, ensure_ascii=False))
        # print(json.dumps(phrases_json_list, indent=2, ensure_ascii=False))
        return

    with open(lessons_json_path, 'w') as f:
        if not preview:
            print(json.dumps(lessons_json, ensure_ascii=False, indent=2), file=f)
        print(f'[Generated] {lessons_json_path}')

    if not preview and not os.path.exists(phrases_json_dir):
        os.makedirs(phrases_json_dir)

    for lesson_json, phrases_json in zip(lessons_json, phrases_json_list):
        phrase_json_path = f'{phrases_json_dir}/{lesson_json["id"]}.json'
        with open(phrase_json_path, 'w') as f:
            if not preview:
                print(json.dumps(phrases_json, ensure_ascii=False, indent=2), file=f)

        print(f'[Generated] {phrase_json_path}')


if __name__ == '__main__':
    generate()