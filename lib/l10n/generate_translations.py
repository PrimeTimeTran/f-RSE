from googletrans import Translator
import json
import codecs

translator = Translator()

languages = [
    'es',
    'vi',
]

for l in languages:

    with open('app_en.arb') as file:
        data = json.load(file)
        j = {}
        for i, (k, v) in enumerate(data.items()):
            if i < len(data):
                text = translator.translate(v, src='en', dest=l).text
                j[k] = text

        with codecs.open("app_" + l + ".arb", "w", encoding='utf8') as f:
            json.dump(j, f, ensure_ascii=False)