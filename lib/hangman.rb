require "colorize"

module Hangman
  # Contains state of hangman game
  class Hangman
    @@PATH_TO_DICTIONARY_SOURCE = File.expand_path("../../sources/10000_english_words.txt", __FILE__)
    
    attr_reader :alphabet, :health
    def initialize
      @MAX_HEALTH = 6
      @health = @MAX_HEALTH - 2
      @word = Hangman.get_random_word
      @alphabet = ("a".."z").reduce({}) do |result, letter| 
        result[letter] = false
        result
      end
    end
    
    def display_health
      str = ""
      health.times {str << "❤︎".colorize(:red)}
      (@MAX_HEALTH-health).times { str << "❤︎".colorize(:white) }
      puts str
    end
    
    def display_word
      chars = @word.chars.map do |letter|
        if @alphabet[letter] then letter
        else "_"
        end
      end
      puts chars.join(" ")
    end
    
    def display_alphabet
      arr = @alphabet.map do |key, value|
        if value && !word.include?(key) then
          key.colorize(:red)
        else if value && word.include?(key) then
          key.colorize(:green)
        else key
        end
      end
      end
      puts arr.join(" ")
    end
    
    def self.load_dictionary
      f = File.open(@@PATH_TO_DICTIONARY_SOURCE)
      dictionary = []
      while line = f.gets do
        dictionary << line.chomp if line.chomp.size.between?(5,12)
      end
      dictionary
    end
    
    def self.get_random_word
      self.load_dictionary.sample
    end
  end
end
