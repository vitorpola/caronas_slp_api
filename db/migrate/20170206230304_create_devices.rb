class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.integer :user_id
      t.string :uuid
      t.string :model
      t.string :platform
      t.string :version
      t.string :token

      t.timestamps
    end
  end
end
