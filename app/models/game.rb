class Game < ApplicationRecord
  serialize :board_state
  serialize :valid_subgames
  serialize :meta_state

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

  def player
    if self.player_1_turn?
      "X"
    else
      "O"
    end
  end

  def take_turn(subgame, cell)
    ActiveRecord::Base.transaction do
      # done in theory, needs to be tested A LOT more
      # ie we can't play if this subgame is done
      raise "subgame has been conquered" if self.meta_state[subgame].present?
      # can't play if this cell is occupied
      raise "cell occupied" if self.board_state[subgame][cell].present?

      self.board_state[subgame][cell] = self.player
      # switch player: turns off to on, and on to off
      self.player_1_turn = !self.player_1_turn
    end
  end


  def to_json
    {
      :id => self.id,
      :board => self.board,
      :winner => self.winner,
      :turn => self.player,
      :valid_subgames => self.valid_subgames
    }
  end

end
