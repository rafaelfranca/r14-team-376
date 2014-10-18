class SetStepStateToBeWaitingAsDefault < ActiveRecord::Migration
  def up
    change_column_default :recruitment_steps, :state, 'waiting'
  end

  def down
    change_column_default :recruitment_steps, :state, nil
  end
end
