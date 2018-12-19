class MovesController < ApplicationController

  def create
    game = Game.find(params[:id])
    render :json => game.to_json
  end

end
