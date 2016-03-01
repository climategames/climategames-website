class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :picturable_id
      t.string :picturable_type
    end
    add_attachment :pictures, :image
    add_index :pictures, :picturable_id
    add_index :pictures, [:picturable_id, :picturable_type]
  end
end
