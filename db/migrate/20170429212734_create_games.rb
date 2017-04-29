class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date, null: false
      t.integer :player_1_id, null: false, index: true
      t.integer :player_2_id, null: false, index: true
      t.integer :player_1_score, null: false
      t.integer :player_2_score, null: false
      t.timestamps null: false
    end
    add_foreign_key :users, :player_1, column: :player_1_id
    add_foreign_key :users, :player_2, column: :player_2_id
  end
end
