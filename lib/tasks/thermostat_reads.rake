namespace :thermostat_reads do

  desc 'Generate dummy data for thermostat reads'
  task :dummy_data => :environment do

    puts ">> Started .."
    rand(2..5).times do
      thermostat = Thermostat.new(FactoryBot.build(:thermostat).attributes)
      rand(20..30).times do
        print "."
        thermostat.thermostat_reads.build(FactoryBot.build(:thermostat_read, thermostat: nil).attributes.merge(created_at: Time.now - rand(0..10).days))
      end
      thermostat.save!
    end
    puts ""
    puts ">> Finish"

  end
end
