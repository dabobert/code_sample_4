class GamesController < ApplicationController


  def index
    render :json => Game.pluck(:id)
  end

  def create
    begin
      game = Game.create!
      render :json => game.to_json
    rescue Exception => error
      render :json => { :message => error.message, :error => error.message }, :status => 500
    end
  end

  def show
    begin
      game = Game.find(params[:id])
      render :json => game.to_json
    rescue Exception => error
      render :json => { :message => error.message, :error => error.message }, :status => 500
    end
  end
end
