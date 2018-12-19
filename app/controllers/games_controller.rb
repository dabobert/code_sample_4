class GamesController < ApplicationController


  def create
    begin
      game = Game.create!
      render :json => game
    rescue Exception => error
      render :json => {:status => 500, :message => error.message, :error => error.message}
    end
  end
end
