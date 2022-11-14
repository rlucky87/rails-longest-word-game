require 'open-uri'

class GamesController < ActionController::Base
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @word = params[:word]

    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_reponse = URI.open(url).read
    word = JSON.parse(user_reponse)
    if validation?(@letters, @word) && word["found"]
     @score = "Congratulations #{@word} is a valid English word!"
    elsif validation?(@letters, @word) && !word["found"]
    @score = "Sorry but #{@word} does not seem to be a valid English word..."
    else
    @score = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end
  private

  def validation?(letters, word)
    word.chars.all? do |lettre|
      letters.include?(lettre)
    end


  end
  

end
