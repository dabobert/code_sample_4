class GamesController < ApplicationController


  def index
    render :json => Game.pluck(:id)
  end

  def create
    begin
      game = Game.create!
      render :json => game.to_json
    rescue Exception => error
      render :json => { :status => 500, :message => error.message, :error => error.message }
    end
  end

  def show
    begin
      game = Game.find(params[:id])
      render :json => game.to_json
    rescue Exception => error
      render :json => { :status => 500, :message => error.message, :error => error.message }
    end
  end
end
