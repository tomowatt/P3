package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"math/rand"
	"net/http"
	"os"
	"strings"
	"time"
)

type RandomPassword struct {
	Password string
}

func getWords() []string {
	var file, error = os.Open("nouns.txt")

	if error != nil {
		fmt.Println(error.Error())
	}
	defer file.Close()

	var words []string
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		words = append(words, scanner.Text())
	}
	return words
}

func getRandomString(wordCount int) string {
	var words = getWords()
	var randomWords []string

	for i := 0; i < wordCount; i++ {
		rand.Seed(time.Now().UnixNano())
		randomWords = append(randomWords, words[rand.Intn(len(words))])
	}

	var randomWordString = strings.Join(randomWords, "-")

	return randomWordString
}

func onGet(writer http.ResponseWriter, request *http.Request) {
	var password = RandomPassword{getRandomString(5)}
	reponse := json.NewEncoder(writer)
	reponse.Encode(&password)
}

func main() {
	var port = 80
	http.HandleFunc("/", onGet)
	http.ListenAndServe(fmt.Sprintf(":%v", port), nil)
}
