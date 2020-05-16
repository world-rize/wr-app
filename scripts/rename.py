"""
naturalreaders からダウンロードしたzipファイルをリネームする
"""
from glob import glob
import os
import re
from os.path import expanduser
from zipfile import ZipFile

filenames_raw = "Weather25豪KP,Weather25豪,Weather25英KP,Weather25英,Weather25米KP,Weather25米,House32豪KP,House32豪,House32英KP,House32英,House32米KP,House32米,House30豪KP,House30豪,House30英KP,House30英,House30米KP,House30米,School39豪,School39英KP,School39英,School39米KP,School39米,School36豪KP,School36豪,School36英KP,School36英,School36米KP,School36米,House29豪,House29英,House29米,Emotion43豪KP,Emotion43豪,Emotion43英KP,Emotion43英,Emotion43米KP,Emotion43米,Greeting41豪KP,Greeting41豪,Greeting英KP,greeting41英,Greeting41米KP,Greeting41米,Acting as a guide10豪,Acting as a guide10英,Acting as a guide10米,Emotion24豪,Emotion24英,Emotion24米,Business English25豪,Business English25英,Business English25米,Business English22豪KP,Business English22豪,Business English22英KP,Business English22英,Business English22米KP,Business English22米,Relationship22豪,Relationship22英,Relationship22米,Relationship15豪,Relationship15英,Relationship15米,Relationship3米,Relationship3豪,Relationship3英,Business English17豪,Business English17英,Business English17米,School47豪KP,School47英KP,School47米KP,Greeting32豪KP,Greeting32豪,Greeting32英KP,Greeting32英,Greeting32米KP,Greeting32米,Acting as a guide37豪KP,Acting as a guide37豪,Acting as a guide37英KP,Acting as a guide37英,Acting as a guide37米KP,Acting as a guide37米,Weather37英KP,Weather37米KP,Weather37豪KP,Cafe39豪,Cafe39英,Cafe39米,Weather16豪KP,Weather16豪,Weather16英KP,Weather16英,Weather16米KP,Weather16米,Weather2豪KP,Weather2英KP"

pwd = os.path.dirname(__file__)
zip_path = f'{pwd}/*.zip'

extractor = re.compile(r"([a-zA-Z\-]+)(\d+)([英米豪])((?:KP)?)")
def name_to_meta(name):
  # Weather25[英米豪](KP)?
  try:
    match = re.search(extractor, name)
    id_upper, phrase_id, locale_ja, kp = match.groups()
    locale = { '英': 'en-uk', '豪': 'en-au', '米': 'en-us' }[locale_ja]
    if not locale:
      raise Exception()
    return id_upper, phrase_id, locale, kp
  except:
    return None


if __name__ == '__main__':
  filenames = filenames_raw.split(',')
  zips = glob(zip_path)
  zips.sort(key=os.path.getmtime, reverse=False)

  # rename
  for name in filenames[:5]:
  # for name, path in zip(filenames, zips):
    zip_file = f'{pwd}/{name}.zip'
    meta = name_to_meta(name)
    if meta:
      id_upper, phrase_id, locale, kp = meta
      print(id_upper, phrase_id, locale, kp)

    # extract_path = f'{pwd}/{name}'
    # print(f'{path} -> {zip_file}')
    # os.rename(path, zip_file)

    # 解凍
    # print(f'extract {extract_path}')
    # with ZipFile(zip_file) as f:
    #   f.extractall(extract_path)

    # print(glob(f'extract_path/*.mp3'))