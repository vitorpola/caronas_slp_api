class CreateRides < ActiveRecord::Migration[5.0]
  def change
    create_table :rides do |t|
      t.integer :driver_id
      t.integer :from_city_id
      t.integer :from_neighborhood_id
      t.text :from_description
      t.integer :to_city_id
      t.integer :to_neighborhood_id
      t.text :to_description
      t.timestamp :start_at
      t.timestamp :end_at
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
