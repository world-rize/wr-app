export GOOGLE_APPLICATION_CREDENTIALS=../.env/worldrize-9248e-d680634159a0.json
curl -X POST \
  -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @input.json \
  https://texttospeech.googleapis.com/v1/text:synthesize | \
  jq -r '.audioContent' | \
  base64 --decode > out.mp3