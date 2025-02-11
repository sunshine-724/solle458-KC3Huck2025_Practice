from google import genai
import api_key

key = api_key.key
client = genai.Client(api_key=key)
response = client.models.generate_content(
    model='gemini-2.0-flash', contents='How does RLHF work?'
)
print(response.text)
