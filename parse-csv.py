import csv
import json
import os



class WordsJSONGenerator(object):
    def __init__(self, file_name: str) -> None:
        self.file_name = file_name
        self.words: dict = {"count": 0, "words": []}

    def read_csv_list(self):
        if os.path.exists("words.json"):
            with open("words.json", "r+") as f:
                self.words = json.load(f)

        with open(self.file_name) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            row_index = 0
            for row in csv_reader:
                if row_index > 0:
                    new_element = {
                        "id": int(row[0]) + self.words["count"],
                        "word": row[1],
                        "example": row[2]
                    }
                    self.words["words"].append(new_element)
                row_index += 1
        self.words["count"] = len(self.words["words"])

    def save_words2json(self):
        with open("words.json", "w+") as f:
            json.dump(self.words, f)

if __name__ == "__main__":
    wjg = WordsJSONGenerator(file_name='Words400.csv')
    wjg.read_csv_list()
    wjg.save_words2json()