class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.text :board_state
      t.boolean :player_1_turn, :default => true, :nil => false
      t.string :valid_subgames
      t.string :meta_state
      t.timestamps
    end
  end
end
