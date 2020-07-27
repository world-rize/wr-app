"""
TTS Generator
"""
import sys
import os
import requests
import json

from google.cloud import texttospeech
from google.oauth2 import service_account

pwd = os.path.dirname(os.path.abspath(__file__))
auth_path = f'{pwd}/../.env/worldrize-9248e-d680634159a0.json'
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = auth_path

# speaker1
speaker_us = texttospeech.types.VoiceSelectionParams(
    language_code='en-US',
    name='en-US-Wavenet-A',
    # ssml_gender=texttospeech.enums.SsmlVoiceGender.FEMALE
)


def synthesize_text(text: str):
    client = texttospeech.TextToSpeechClient.from_service_account_json(auth_path)
    input_text = texttospeech.types.SynthesisInput(text=text)
    voice = texttospeech.types.VoiceSelectionParams(
        language_code='en-US',
        name='en-US-Wavenet-A',
        # ssml_gender=texttospeech.enums.SsmlVoiceGender.FEMALE
    )
    audio_config = texttospeech.types.AudioConfig(
        audio_encoding=texttospeech.enums.AudioEncoding.MP3)
    response = client.synthesize_speech(input_text, voice, audio_config)
    with open('output.mp3', 'wb') as out:
        out.write(response.audio_content)
        print('Audio content written to file "output.mp3"')

if __name__ == "__main__":
    text = 'Android is a mobile operating system developed by Google'
    synthesize_text(text)
