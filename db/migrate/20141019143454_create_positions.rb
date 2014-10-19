class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title, null: false
      t.string :description
      t.references :organization, null: false, index: true

      t.timestamps null: false
    end
  end
end
