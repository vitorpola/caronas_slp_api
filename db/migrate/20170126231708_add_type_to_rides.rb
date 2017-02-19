class AddTypeToRides < ActiveRecord::Migration[5.0]
  def change
    add_column :rides, :type, :string
  end
end
