"""
Phrase to Json Convertor

@author yoshiki301
"""
import json
import re
import copy
import sys
import os
import glob

bold_pattern = re.compile(r"[\(（](.*?)[\)）]") # 強調文字のマッチング
id_counter = 1 # 通しフレーズのid開始番号

def voice_path(lesson_id, code):
    """
    lesson_id: e.g. Shcool
    code: e.g. en-us
    """
    # asset_path = "phrases/" + lesson_id
    # dummy
    # /assets prefix-ed
    return f'voice_sample.mp3'

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

if __name__ == '__main__':
    preview = False
    RAW_TARGET = '../assets/raw/*.txt'
    DST_DIR = '../assets/lessons'

    for raw_data_path in glob.glob(RAW_TARGET):
        base = os.path.splitext(os.path.basename(raw_data_path))[0]

        with open(raw_data_path) as rf:
            readlines = rf.readlines()

        content_data = txt2json(base, readlines)

        if preview:
            print(json.dumps(content_data[0], indent = 2, ensure_ascii=False))
            sys.exit(0)

        # jsonデータへ変換
        json_data_path = f'{DST_DIR}/{base}.json'

        print(f'{base}: {len(content_data)}({id_counter}) phrases')

        print(f'{raw_data_path} -> {json_data_path}')

        with open(json_data_path,"w") as jf:
            json.dump(content_data,jf,ensure_ascii=False,indent=4)
            print("json file generated.")
