class CreateThermostatReads < ActiveRecord::Migration[5.2]
  def change
    create_table :thermostat_reads do |t|
      t.float   :temperature
      t.float   :humidity
      t.float   :battery_charge
      t.integer :number
      t.integer :thermostat_id

      t.timestamps
    end

    add_index :thermostat_reads, :number
    add_index :thermostat_reads, :thermostat_id
  end
end
