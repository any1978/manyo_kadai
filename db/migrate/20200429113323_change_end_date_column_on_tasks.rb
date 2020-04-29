class ChangeEndDateColumnOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :end_date, :date, null: false
  end
end
