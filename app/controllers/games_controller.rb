require "open-uri"
require "json"

class GamesController < ApplicationController

  def new
    random_grindsize = rand(3..10)
    @letters = Array.new(random_grindsize) { ('A'..'Z').to_a.sample }
  end

  def score
    @game = params[:answer]
    if english_word?(params[:answer]) && included?(params[:answer], params[:letters].split(""))
      @score = "The word is valid according to the grid and is an English word"
    elsif included?(params[:answer], params[:letters].split("")) == false
      @score = "The word can't be built out of the original grid"
    else
      @score = "The word is valid according to the grid, but is not a valid English word"
    end

  end

  def english_word?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end



end
