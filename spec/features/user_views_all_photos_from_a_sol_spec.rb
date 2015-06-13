require "rails_helper"

feature "User views a list of photos from a sol" do
  it "lists all photos from that sol" do
    photo = FactoryGirl.create(:photo)
    rover = photo.rover
    visit rover_photos_path(rover)

    fill_in "Sol", with: 829
    select "FHAZ", from: "Camera"
    click_on "Search"

    expect(page).to have_content photo.sol
    expect(page).to have_content photo.camera
  end
end
