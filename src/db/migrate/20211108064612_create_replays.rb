class CreateReplays < ActiveRecord::Migration[5.0]
  def change
    create_table :replays do |t|
      t.string :replay_to
      t.string :replay_from
      t.integer :micropost_id, foreign_key: true

      t.timestamps
    end
    add_index :replays, [:micropost_id, :created_at]
  end
end
