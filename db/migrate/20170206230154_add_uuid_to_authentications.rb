class AddUuidToAuthentications < ActiveRecord::Migration[5.0]
  def change
    add_column :authentications, :uuid, :string
  end
end
