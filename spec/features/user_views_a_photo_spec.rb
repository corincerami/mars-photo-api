require "rails_helper"

feature "User views a photo" do
  it "shows the photo's details on the page" do
    photo = FactoryGirl.create(:photo)
    visit photo_path(photo)

    expect(page).to have_content photo.sol
    expect(page).to have_content photo.camera
  end
end
