# This file should contain all the record creation needed to seed the database with its default values.

#######
#
# This file will be run on every deploy, so make sure the changes here are non-destructive
#
#######

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

Dir[File.join(File.dirname(__FILE__),'seeds','*.rb')].each do |f|
  puts "Seeding from #{ File.basename f }..."
  load f
  puts "Done."
end
