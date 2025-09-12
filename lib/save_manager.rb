require_relative "./constants"
require "date"

# Methods related to saving and loading game states
module Hangman
  def self.save(string, name = "game_#{DateTime.now.strftime('%Y_%m_%d:%H-%M-%S.%L')}.save")
    Dir.mkdir(Constants::PATH_TO_SAVES_DIRECTORY) unless Dir.exist?(Constants::PATH_TO_SAVES_DIRECTORY)
    fname = "#{Constants::PATH_TO_SAVES_DIRECTORY}/#{name}"
    puts fname
    File.new(fname, File::CREAT, 0o755)
    File.open(fname, "w") { |f| f.write(string) }
  end

  def self.load(path)
    return unless File.exist?(path)

    str = ""
    File.open(path) { |f| str = f.readlines }
    str
  end

  def self.list_saves
    Dir["#{Constants::PATH_TO_SAVES_DIRECTORY}/*.save"]
  end
end
