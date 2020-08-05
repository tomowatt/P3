import json
import random

import falcon


class PasswordString:

    def get_words(self):
        with open('nouns.txt') as nouns:
            return nouns.read().splitlines()

    def get_random_string(self, word_count=5):
        words = self.get_words()
        random_word_string = '-'
        random_words = [word for word in random.choices(words, k=word_count)]
        return random_word_string.join(random_words)

    def on_get(self, request, response):
        """Handles GET requests"""
        data = {"Password": self.get_random_string()}
        response.media = data

api = falcon.API()
api.add_route('/', PasswordString())
