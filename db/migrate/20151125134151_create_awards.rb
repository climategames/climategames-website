class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards
    16.times do Award.create end
  end
end