require 'sinatra'


def get_words 
  nouns = []
  # Open a File
  File.open('nouns.txt', 'r') do |file|
    # Read File contents
    file.each do |line|
      # Put contents into an Array/List/Vector
      nouns.push(line.strip)
    end
  file.close
  end
  return nouns
end

def get_random_string (word_count)
  words = get_words()
  random_words = []
  for in 0..word_count - 1
    # Select N number of items from Array/List/Vector at Random
    random_words.push(words[rand(words.length)])
  end
  # Generate a String from concatenating the Randomly selecting items
  random_words_string = random_words.join('-')
  return random_words_string
end

def on_get 
   # Create JSON object using Generated String
   data = {:Password => get_random_string(5)}
   # Return JSON object on GET requests
   response = JSON.generate(data)
   return response
end

# Host a Web application
configure do
  set :bind, '0.0.0.0'
  set :host, '*'
  set :port, '80'
  set :default_content_type, 'application/json'
end

get '/' do
  on_get()
end