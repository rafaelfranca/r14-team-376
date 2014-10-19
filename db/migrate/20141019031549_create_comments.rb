class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :recruitment_step, index: true
      t.belongs_to :author, index: true
      t.text :body
      t.timestamps null: false
    end
  end
end
