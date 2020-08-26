import ballerina/http;
import ballerina/io;
import ballerina/math;
import ballerina/lang.'string;
import ballerina/log;

function get_words() returns @tainted string[]|error{
    string[] words = [];
    io:ReadableByteChannel byteChannel = check io:openReadableFile("./nouns.txt");
    io:ReadableCharacterChannel characterChannel = new (byteChannel, "UTF-8");
    io:ReadableTextRecordChannel textRecordChannel = new(characterChannel, " ", "\n");

    while (textRecordChannel.hasNext()) {
        words.push(textRecordChannel.getNext().toString());
    }
    
    return words;
}

function get_random_string(int word_count) returns @untainted string|error {
    string[] words = check get_words();
    string[] random_words = [];
    string random_word_string = "";

    foreach int i in 0...word_count {
        random_words.push(words[check math:randomInRange(0, words.length())]);
    }

    // Reversed Array as words joined in reverse order
    foreach string word in random_words.reverse() {
        random_word_string = 'string:'join(word, "-", random_word_string);
    }
    // Remove additional "-" from start of String
    random_word_string = 'string:'substring(random_word_string, 1);
    return random_word_string;
}

listener http:Listener P3 = new(80);

@http:ServiceConfig {
    basePath: "/"
}

service ballerina on P3 {

    resource function ballerina(http:Caller outboundEP, http:Request request) {
        var random_string = get_random_string(5);
        if (random_string is error) {
            error err = random_string;
            log:printError("Error creating password", err);
        }

        json password = {"Password": random_string.toString()};
        http:Response response = new;
        response.setJsonPayload(password);
        var responseResult = outboundEP->respond(response);
        if (responseResult is error) {
            error err = responseResult;
            log:printError("Error sending response", err);
        }
    }
    
}