class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :user, null: false, index: { unique: true }
      t.integer :score, default: 0
      t.integer :games_played, default: 0
      t.timestamps null: false
    end
  end
end
