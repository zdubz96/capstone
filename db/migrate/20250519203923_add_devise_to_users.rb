class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Optional: trackable, confirmable, lockable etc.
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
