class RenameTypeFromRides < ActiveRecord::Migration[5.0]
  def change
    rename_column :rides, :type, :ride_type
  end
end
