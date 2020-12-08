class AddProfToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prof, :string
  end
end
