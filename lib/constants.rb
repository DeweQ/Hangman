module Hangman
  module Constants
    PATH_TO_DICTIONARY_SOURCE = File.expand_path("../sources/10000_english_words.txt", __dir__)
    PATH_TO_SAVES_DIRECTORY = File.expand_path("../saves/", __dir__)
    MAX_HEALTH = 6
  end
end
