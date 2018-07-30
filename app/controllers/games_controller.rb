require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times{@letters.push((65 + rand(25)).chr)}


  end

  def score
    grid = params[:letters].split(" ")
    input = params[:word].upcase.split("")
    @final = ""
    if !in_grid?(grid,input)
      @final = "Sorry but #{input.join("")} can't be build out of #{grid.join(", ").chomp(',')}"
    elsif !valid?(params[:word])
      @final = "Sorry but #{input.join("")} does not seem to be a valid English word... "
    else
      @final = "Congradulations! #{input.join("")} is a valid English word!"
    end

  end


  private

  def in_grid?(grid,input)
    ingrid = true;
    input.each do |i|
      if !grid.include? i
        ingrid = false
      end
      grid.delete(i)
    end

    ingrid

  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user["found"]
  end
end
