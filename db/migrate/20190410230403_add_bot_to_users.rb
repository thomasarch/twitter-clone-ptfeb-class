class AddBotToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bot, :boolean
    add_column :users, :autopic, :string
  end
end
