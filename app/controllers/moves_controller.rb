class MovesController < ApplicationController

  def create
    begin
      game = Game.find(params[:id])
      game.take_turn! params[:subgame].to_i, params[:cell].to_i
      render :json => game.to_json
    rescue Exception => error
      render :json => { :message => error.message, :error => error.message }, :status => 500
    end
  end

end
