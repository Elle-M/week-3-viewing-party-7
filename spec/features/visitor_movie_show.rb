require "rails_helper"

describe "Visitor Movie Show Page" do
  it "redirects visitor to login page if they try to visit a movie show page" do
    movie_1 = Movie.first

    visit "visitor/movies/#{movie_1.id}"

    click_link "Create Viewing Party"

    expect(current_path).to eq("visitor/movies/#{movie_1.id}")
    expect(page).to have_content("You must be logged in to view that page.")
  end
end