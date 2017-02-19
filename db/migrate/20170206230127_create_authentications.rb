class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :oauth_token
      t.string :oauth_token_secret

      t.timestamps
    end
  end
end
