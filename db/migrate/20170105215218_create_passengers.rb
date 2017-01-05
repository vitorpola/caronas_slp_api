class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.integer :ride_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
