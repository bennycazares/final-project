class Addcolumntouser2 < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :description, :text
    add_column :users, :title, :string
    
  end
end
