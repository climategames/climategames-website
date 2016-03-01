require 'rails_helper'
require 'rake'

RSpec.feature "Home page" do
  scenario "for the french language" do
    pending "Still unsure how to best import the Refinery page"
    # Rake::Task['db:data:load'].invoke
    visit "/fr/home"
    expect(page).to have_content "Nous sommes la nature qui se défend"
  end
end
