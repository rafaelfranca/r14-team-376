class AddStepsTemplateToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :steps_template, :string
  end
end
