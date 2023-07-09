from googletrans import Translator
import json
import codecs

translator = Translator()

languages = [
    'es',
    'vi',
]

def translate_dict(data, dest_language):
    translated_dict = {}
    for key, value in data.items():
        if isinstance(value, dict):
            translated_dict[key] = translate_dict(value, dest_language)
        else:
            translated_dict[key] = translator.translate(value, src='en', dest=dest_language).text.title().title()
    return translated_dict

for l in languages:
    with open('app_en.arb') as file:
        data = json.load(file)
        translated_data = translate_dict(data, l)

        with codecs.open("app_" + l + ".arb", "w", encoding='utf8') as f:
            json.dump(translated_data, f, ensure_ascii=False)