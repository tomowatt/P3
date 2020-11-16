import 'dart:io';
import 'dart:math';
import 'dart:convert';

List<String> get_words() {
  // Open a File
  File file = new File('nouns.txt');
  // Read File contents
  // Put contents into an Array/List/Vector
  List<String> nouns = file.readAsLinesSync();
  return nouns;
}

String getRandomString(int wordCount) {
  List<String> words = get_words();
  List<String> randomWords = [];
  // Select N number of items from Array/List/Vector at Random
  for (var i = 0; i < wordCount; i++) {
    var random = Random();
    randomWords.add(words[random.nextInt(words.length)]);
  }
  // Generate a String from concatenating the Randomly selecting items
  String randomWordString = randomWords.join("-");
  return randomWordString;
}

Future main() async {
  // Host a Web application
  var server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    80,
  );

  await for (HttpRequest request in server) {
    // Create JSON object using Generated String
    String password = getRandomString(5);
    var response = jsonEncode({"Password":password});
    // Return JSON object on GET requests
    request.response.headers.contentType = new ContentType("application", "json");
    request.response.write(response);
    await request.response.close();
  }
}