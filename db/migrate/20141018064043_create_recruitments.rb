class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.belongs_to :candidate
      t.belongs_to :recruiter
      t.timestamps null: false
    end
  end
end
