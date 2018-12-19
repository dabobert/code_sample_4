class Game < ApplicationRecord
  serialize :board_state
  serialize :valid_subgames

  after_initialize :setup



  def setup
    if new_record?
      self.valid_subgames = (0..8).to_a
      self.board_state = [
        Array.new(9),
        Array.new(9),
        Array.new(9),
        Array.new(9),
        Array.new(9),
        Array.new(9),
        Array.new(9),
        Array.new(9),
        Array.new(9)
      ]      
    end
  end

  def board
    self.board_state.to_s.gsub('nil','\'\'')
  end

  def winner
    ''
  end

  def turn
    if self.player_1_turn?
      "X"
    else
      "O"
    end
  end


  def to_json
    {
      :id => self.id,
      :board => self.board,
      :winner => self.winner,
      :turn => self.turn,
      :valid_subgames => self.valid_subgames
    }
  end

end
