require "rails_helper"

feature "User views a list of photos from a sol" do
  it "lists all photos from that sol" do
    camera = FactoryGirl.create(:camera)
    rover = camera.rover
    photo = FactoryGirl.create(:photo, rover: rover, camera: camera)
    visit rover_photos_path(rover)

    fill_in "Sol", with: 829
    select "FHAZ", from: "Camera"
    click_on "Search"

    expect(page).to have_content photo.sol
    expect(page).to have_content photo.camera.name
  end
end
