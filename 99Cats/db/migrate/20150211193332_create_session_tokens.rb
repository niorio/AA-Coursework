class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
    end

    add_index :session_tokens, :user_id
    add_index :session_tokens, :session_token, unique: true

  end
end
