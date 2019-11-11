require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @letters = 9.times.map { alphabet.sample }.join(" ")
  end

  def score
    @result = 'Well done!'
    trial = params[:trial]
    letters = params[:letters].gsub!(/\s/, '')
    if !trial.upcase.chars.all? { |letter| trial.upcase.count(letter) <= letters.chars.count(letter) }
      @result = "Sorry #{trial} can't be build out of #{letters}"
    elsif word_exist?(trial) == false
      @result = "Sorry #{trial} does not seem to be a valid English word..."
    else
      @result = "Congratulations #{trial} is a valid English word"
    end
    @result
  end

  def word_exist?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    word['found']
  end
end
