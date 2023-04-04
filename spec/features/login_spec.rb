require "rails_helper"

RSpec.describe "User Log In" do
  it "can log in a user with correct credentials" do
    user = User.create(name: "User One", email: "email@example.com", password: "password123")

    visit "/"

    click_link "Log In"

    fill_in :email, with:"email@example.com"
    fill_in :password, with: "password123"
    click_button "Log In"

    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_content("User One's Dashboard")
  end 

  it "does not log in user with incorrect credentials" do 
    user = User.create(name: "User One", email: "email@example.com", password: "password123")

    visit "/"

    click_link "Log In"

    fill_in :email, with:"email@example.com"
    fill_in :password, with: "nottherightpassword"
    click_button "Log In"


    expect(current_path).to eq("/login")
    expect(page).to have_content("Bad Credentials, try again.")
  end

  it "can log out a user" do
    user = User.create(name: "User One", email: "email@example.com", password: "password123")

    visit "/"

    click_link "Log In"

    fill_in :email, with:"email@example.com"
    fill_in :password, with: "password123"
    click_button "Log In"

    expect(current_path).to eq("/users/#{user.id}")
    save_and_open_page
    click_link "Log Out"

    expect(current_path).to eq("/")
    expect(page).to have_content("You are not logged in.")
    expect(page).to have_link("Log In")
  end  
end