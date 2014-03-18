require 'spec_helper'

describe "Add a class", :type => :feature do
  it "adds a class" do
    visit("/add/class")
    
    within('#add_class') do
      fill_in('name', :with => 'English 101')
      click_button('Submit')
    end
    
    expect(page).to have_content("English 101")
  end
end