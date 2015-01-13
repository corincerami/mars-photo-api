require './scraper'

images = scrape_images

images.each do |attributes|
  image = Photo.find_or_initialize_by(attributes)
  image.save
  print "."
end
