class CreateRecruitmentSteps < ActiveRecord::Migration
  def change
    create_table :recruitment_steps do |t|
      t.belongs_to :recruitment
      t.integer :order
      t.string :title
      t.text :description
      t.string :state
      t.timestamps null: false
    end
  end
end
