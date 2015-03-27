require './scraper'

images = scrape_images

image.each do |image|
  i = Image.find_or_create_by(sol: image["sol"], camera: image["camera"], img_src: image["img_src"])
  puts "Image #{i.id}"
end
