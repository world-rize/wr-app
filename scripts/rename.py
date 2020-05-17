"""
naturalreaders からダウンロードしたzipファイルをリネームする
"""
from glob import glob
import os
import re
from os.path import expanduser
from zipfile import ZipFile

# 1-100
filenames_raw = "Weather25豪KP,Weather25豪,Weather25英KP,Weather25英,Weather25米KP,Weather25米,House32豪KP,House32豪,House32英KP,House32英,House32米KP,House32米,House30豪KP,House30豪,House30英KP,House30英,House30米KP,House30米,School39豪,School39英KP,School39英,School39米KP,School39米,School36豪KP,School36豪,School36英KP,School36英,School36米KP,School36米,House29豪,House29英,House29米,Emotion43豪KP,Emotion43豪,Emotion43英KP,Emotion43英,Emotion43米KP,Emotion43米,Greeting41豪KP,Greeting41豪,Greeting英KP,greeting41英,Greeting41米KP,Greeting41米,Acting as a guide10豪,Acting as a guide10英,Acting as a guide10米,Emotion24豪,Emotion24英,Emotion24米,Business English25豪,Business English25英,Business English25米,Business English22豪KP,Business English22豪,Business English22英KP,Business English22英,Business English22米KP,Business English22米,Relationship22豪,Relationship22英,Relationship22米,Relationship15豪,Relationship15英,Relationship15米,Relationship3米,Relationship3豪,Relationship3英,Business English17豪,Business English17英,Business English17米,School47豪KP,School47英KP,School47米KP,Greeting32豪KP,Greeting32豪,Greeting32英KP,Greeting32英,Greeting32米KP,Greeting32米,Acting as a guide37豪KP,Acting as a guide37豪,Acting as a guide37英KP,Acting as a guide37英,Acting as a guide37米KP,Acting as a guide37米,Weather37英KP,Weather37米KP,Weather37豪KP,Cafe39豪,Cafe39英,Cafe39米,Weather16豪KP,Weather16豪,Weather16英KP,Weather16英,Weather16米KP,Weather16米,Weather2豪KP,Weather2英KP"

pwd = os.path.dirname(os.path.abspath(__file__))

extractor = re.compile(r"([a-zA-Z\-]+)(\d+)([英米豪])((?:KP)?)")
def name_to_meta(name):
  # Weather25[英米豪](KP)?
  try:
    match = re.search(extractor, name)
    id_upper, phrase_id, locale_ja, kp = match.groups()
    locale = { '英': 'en-uk', '豪': 'en-au', '米': 'en-us' }[locale_ja]
    if not locale:
      raise Exception()
    return id_upper.lower(), phrase_id, locale, kp.lower()
  except:
    return None


if __name__ == '__main__':
  filenames = filenames_raw.split(',')
  zip_path = f'{pwd}/../assets/raw/*.zip'
  dir_name = os.path.dirname(zip_path)
  dst_dir = f'{dir_name}/voice'
  if not os.path.exists(dst_dir):
    os.makedirs(dst_dir)

  zips = glob(zip_path)
  zips.sort(key=os.path.getmtime, reverse=False)

  if len(zips) != len(filenames):
    print(f'need 100 zips')
    exit()

  # rename
  for name, zip_path in zip(filenames, zips):
    meta = name_to_meta(name)
    if not meta:
      print(f'{name} is invalid name')
      continue

    lesson_id, phrase_id, locale, kp = meta

    extract_file_name = zip_path.split('.')[0]
    extract_path = f'{dir_name}/{extract_file_name}'

    # 解凍
    print(f'extract {os.path.basename(zip_path)} -> {name}')
    with ZipFile(zip_path) as f:
      f.extractall(extract_path)

    # rename mp3 path
    mp3s = glob(f'{extract_path}/*.mp3')
    if len(mp3s) == 0:
      print(f'warn {os.path.basename(extract_path)} is empty')
      continue

    for mp3path in mp3s:
      # {dir_name}/Weather25豪KP/Weather2_2_.mp3
      index = os.path.basename(mp3path).split('_')[1]
      if kp != '':
        index = kp
      filename = f'{lesson_id}_{phrase_id}_{index}_{locale}.mp3'
      dst_path = f'{dst_dir}/{filename}'

      print(f'\t{os.path.basename(mp3path)} -> {os.path.basename(dst_path)}')
      os.rename(mp3path, dst_path)
