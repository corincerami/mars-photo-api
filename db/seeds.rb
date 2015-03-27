require './scraper'

images = scrape_images

images.each do |image|
  p = Photo.find_or_create_by(sol: image[:sol], camera: image[:camera], img_src: image[:img_src])
  puts "Image #{p.id}"
end
