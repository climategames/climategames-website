class AddPasswordProtectedToRefineryPages < ActiveRecord::Migration
  def change
    add_column :refinery_pages, :password_protected, :boolean, default: true
  end
end
