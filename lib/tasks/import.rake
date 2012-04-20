#lib/tasks/import.rake
desc "Imports a CSV file into an ActiveRecord table"
task :csv_model_import, [:filename, :model] => :environment do |task,args|
  lines = File.new(args[:filename],"r:ISO-8859-1").readlines
  header = lines.shift.strip
  keys = header.split(',')
  lines.each do |line|
    params = {}
    values = line.strip.split(',')
    keys.each_with_index do |key,i|
      params[key] = values[i]
    end
    Module.const_get(args[:model]).create(params)
  end
end