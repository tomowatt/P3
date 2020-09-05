use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::net::TcpListener;
use std::net::TcpStream;
use std::vec::Vec;

use serde_json::json;

fn get_words() -> Vec<String> {
    let filename = "nouns.txt";
    // Open a File
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);
    let mut words: Vec<String> = Vec::new();

    // Read File contents
    for (_index, line) in reader.lines().enumerate() {
        let line = line.unwrap();
        // Put contents into an Array/List/Vector
        words.push(line);
    }
    words
}

fn get_random_string(word_count: u8) -> String {
    let words = get_words();
    let mut random_words: Vec<String> = Vec::new();
    
    // Select N number of items from Array/List/Vector at Random
    for _i in 0..word_count {
        let index = (rand::random::<f32>() * words.len() as f32).floor() as usize;
        let noun = words.get(index).unwrap();
        random_words.push(noun.to_string());
    }
    // Generate a String from concatenating the Randomly selecting items
    let random_word_string = random_words.join("-");
    random_word_string
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    // Create JSON object using Generated String
    let password = json!({
        "Password": get_random_string(5)
    });

    let status_line = "HTTP/1.1 200 OK\r\n\r\n";
    let response = format!("{}{}", status_line, password.to_string());

    // Return JSON object on GET requests
    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}


fn main() {
    // Host a Web application
    let listener = TcpListener::bind("0.0.0.0:80").unwrap();

    for stream in listener.incoming() {
        let stream = stream.unwrap();

        handle_connection(stream);
    }
}
