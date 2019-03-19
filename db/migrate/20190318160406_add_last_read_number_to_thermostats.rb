class AddLastReadNumberToThermostats < ActiveRecord::Migration[5.2]
  def change
    add_column :thermostats, :last_read_number, :integer, default: 0
  end
end
