class AddPositionIdToRecruitments < ActiveRecord::Migration
  def change
    add_reference :recruitments, :position, index: true
  end
end
