class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.string :message, nill: false

      t.timestamps
    end
  end
end
