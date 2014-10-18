class AddHabtmBetweenRecruitmentsAndParticipants < ActiveRecord::Migration
  def change
    create_table :recruitments_participants, id: false do |t|
      t.integer :recruitment_id
      t.integer :participant_id
    end
  end
end
