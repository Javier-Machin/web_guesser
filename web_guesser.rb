require "sinatra"
require "sinatra/reloader"

class WebGuesser
  @@secret_number = rand(100)
  @@attemps = 0

  def self.reset_game
      @@secret_number = rand(100)
      @@attemps = 0
  end

  def self.check_guess(guess)
    @@attemps += 1
    guess = guess.to_i


    if @@attemps == 4 && guess != @@secret_number
      answer = ["Game over, the number was #{@@secret_number}, new number generated", "red"]
      reset_game
      answer
    elsif guess == 0
      ["Make a guess!", "deepskyblue"]
    elsif guess == @@secret_number
      answer = ["Thats correct! the secret number is #{@@secret_number}", "lightgreen"]
      reset_game
      answer
    elsif guess > @@secret_number + 5
      ["Way too high", "red"]
    elsif guess > @@secret_number
      ["Too high", "lightcoral"]
    elsif guess < @@secret_number - 5
      ["Way too low", "red"]
    elsif guess < @@secret_number
      ["Too low", "lightcoral"]
    end


  end

end

get '/' do
  guess_answer = WebGuesser::check_guess(params["guess"])
  erb :index, :locals => {:message => guess_answer[0], :color => guess_answer[1]}
end