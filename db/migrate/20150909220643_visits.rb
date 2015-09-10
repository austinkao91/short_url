class Visits < ActiveRecord::Migration

    def change
      create_table :visits do |t|
        t.integer :short_url_id
        t.integer :user_id
        t.timestamps
      end
      add_index :visits, [:short_url_id, :user_id]
    end
end
