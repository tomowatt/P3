const fs = require('fs');
const express = require('express');
const random = require('random');

const app = express();
const port = 80;

function get_words() {
    var words = [];
    var file = fs.readFileSync('nouns.txt', 'utf-8').split(/\r?\n/);

    file.forEach((word) => {
        words.push(word);
    });

    return words;
};

function get_random_string(wordCount) {
    var words = get_words();
    var random_words = []

    for (let index = 0; index < wordCount; index++) {
        random_words.push(words[random.int(min = 0, max = words.length)]);
    }
    
    var random_word_string = random_words.join('-');
    return random_word_string;
};

app.get('/', (request, response) => {
    var password = {'Password': get_random_string(5)};
    response.send(password);
  });
  
app.listen(port);