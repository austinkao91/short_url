class Shortenedurls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :user_id
    end

    change_column :users, :email, :string, null: false
    add_index :shortened_urls, [:short_url], unique: true
  end
end
