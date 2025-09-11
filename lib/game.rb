require_relative "./hangman"
require_relative "./constants"

module Hangman
  # Class that manages the game
  class Game
    def initialize
      @dictionary = load_dictionary
    end

    def new_game
      self.state = Hangman.new(generate_random_word)
    end

    def load_game(state)
      self.state = state
    end

    # rubocop:disable Metrics/AbcSize
    def play
      loop do
        system "clear"
        state.display
        break if state.finished?

        puts "Enter a letter"
        l = gets.chomp
        break if l.downcase == "exit"

        state.update_alphabet(l)
      end
      # rubocop:enable Metrics/AbcSize
      puts state.word if state.health.zero?
    end

    private

    attr_accessor :state

    def load_dictionary
      f = File.open(Constants::PATH_TO_DICTIONARY_SOURCE)
      dictionary = []
      while (line = f.gets)
        dictionary << line.chomp if line.chomp.size.between?(5, 12)
      end
      dictionary
    end

    def generate_random_word
      @dictionary.sample
    end
  end
end
