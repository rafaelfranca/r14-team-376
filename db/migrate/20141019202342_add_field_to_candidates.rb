class AddFieldToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :twitter, :string
    add_column :candidates, :github, :string
    add_column :candidates, :skype, :string
    add_column :candidates, :linkedin, :string
    add_column :candidates, :email, :string
  end
end
