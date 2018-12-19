class Game < ApplicationRecord
  serialize :board_state
  serialize :valid_subgames
  serialize :meta_state

  after_initialize :setup



  def setup
    if new_record?
      self.meta_state = Array.new(9)
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
    self.board_state.collect do |sub_array|
      sub_array.collect do |v|
        if v.nil?
          ''
        else
          v
        end
      end
    end
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

  def take_turn!(subgame, cell)
    ActiveRecord::Base.transaction do
      # done in theory, needs to be tested A LOT more
      # ie we can't play if this subgame is done
      raise "subgame has been conquered" if self.metacell_occupied?(subgame)
      # can't play if this cell is occupied
      raise "cell occupied" if self.board_state[subgame][cell].present?

      self.board
      self.board_state[subgame][cell] = self.player
      # switch player: turns off to on, and on to off
      self.player_1_turn = !self.player_1_turn
      self.valid_subgames = []
      self.save!
    end
  end

  # useful only conceptutally when hammering in rails console
  def subgame(index)
    self.board_state[index]
  end


  def available_meta_moves
    @available_meta_moves ||= self.meta_state.collect.with_index {|x,i| i if x.blank? }
  end


  def metacell_occupied?(subgame)
    self.meta_state[subgame].present?
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
