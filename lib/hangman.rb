require "colorize"

module Hangman
  # Contains state of hangman game
  class Hangman
    @@PATH_TO_DICTIONARY_SOURCE = File.expand_path("../sources/10000_english_words.txt", __dir__)
    @MAX_HEALTH = 6
    attr_reader :alphabet, :health

    def initialize(word)
      @health = @MAX_HEALTH
      @alphabet = ("A".."Z").each_with_object({}) do |letter, result|
        result[letter] = false
      end
    end

    def update_alphabet(letter)
      @health -= 1 unless @word.include?(letter) || alphabet[letter]
      alphabet[letter] = true 
    end
    
    def finished?
      health <= 0 || @word.chars.all? {|ch| @alphabet[ch]}
    end
    
    def word
      @word if finished?
    end

    def display_health
      str = ""
      health.times { str << "❤︎".colorize(:red) }
      (@MAX_HEALTH - health).times { str << "❤︎".colorize(:white) }
      puts str
    end

    def display_word
      chars = @word.chars.map do |letter|
        if @alphabet[letter] then letter
        else
          "_"
        end
      end
      puts chars.join(" ")
    end

    def display_alphabet
      arr = @alphabet.map do |key, value|
        if value && !@word.include?(key)
          key.colorize(:red)
        elsif value && @word.include?(key)
          key.colorize(:green)
        else
          key
        end
      end
      puts arr.join(" ")
    end

    def display
      display_health
      display_word
      display_alphabet
    end

    def self.load_dictionary
      f = File.open(@@PATH_TO_DICTIONARY_SOURCE)
      dictionary = []
      while (line = f.gets)
        dictionary << line.chomp if line.chomp.size.between?(5, 12)
      end
      dictionary
    end

    def self.get_random_word
      load_dictionary.sample
    end
  end
end
