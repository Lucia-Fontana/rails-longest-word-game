require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    filepath = URI.open("https://wagon-dictionary.herokuapp.com/#{params['word']}")
    info = JSON.parse(filepath.read)

    if params['word'].chars.all? { |letter| params['word'].count(letter) <= params['letters'].count(letter) }
      if info['found']
        @answer = "Congratulations #{params['word']} is a valid English word"
      else
        @answer = "Sorry but #{params['word']} doesn't seem a valid word"
      end
    else
      @answer = "Sorry but #{params['word']} cannot be built out of #{@letters}"
    end
  end
end
