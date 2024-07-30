class RemoveAdressFromPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :adress, :string
  end
end
