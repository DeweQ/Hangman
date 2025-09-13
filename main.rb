require "io/console"
require_relative "lib/hangman"
require_relative "lib/game"
require_relative "lib/save_manager"

# TODO: Clean this mess of a menu
def select_save
  loop do
    system("clear")
    saves = Hangman.list_saves
    commands = saves.map { |s| File.basename(s, ".*") }
    commands << "Back"
    commands.unshift(nil)
    puts "Select a save file"
    commands.each.with_index { |c, i| puts "[#{i}] - #{c}" unless c.nil? }
    responce = $stdin.getch.to_i
    break if responce == commands.index("Back")

    return saves[responce - 1] if responce.between?(1, saves.size)
  end
end

game = Hangman::Game.new
h = nil
loop do
  system("clear")
  puts "***HANGMAN***"
  menu = [nil, "Save game", "New game", "Load game", "Exit"]
  menu.delete_at(1) if h.nil? || h.finished?
  menu.each.with_index { |e, i| puts "[#{i}] - #{e}" unless e.nil? }
  responce = $stdin.getch.to_i
  next unless responce.between?(1, menu.size - 1)

  break if responce == menu.size - 1

  h = game.new_game if responce == menu.index("New game")

  save = select_save if responce == menu.index("Load game")
  unless save.nil?
    json = Hangman.load(save)
    h = Hangman::Hangman.from_json(json)
    game.load_game(h)
  end

  Hangman.save(h.to_json) if responce == menu.index("Save game")

  game.play unless h.nil?

  gets
end
