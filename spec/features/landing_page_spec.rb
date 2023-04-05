require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  xit 'lists out existing users' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123")

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  it "does not show a section that lists existing users to visitors" do 
    expect(page).to_not have_content('Existing Users:')
  end

  it "shows a section that lists existing users to logged in users" do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
# save_and_open_page
    within(".existing-users") do
      expect(page).to have_content("Existing Users:")
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end  
  end

  it "does not let a visitor visit the dashboard" do 
    click_link "Dashboard"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in to view this page")
  end
end
