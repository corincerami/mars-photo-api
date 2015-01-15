require './scraper'

images = scrape_images

images.each do |image|
  image = Photo.find_or_create_by(img_src: image[:img_src], sol: image[:sol], camera: image[:camera])
end
