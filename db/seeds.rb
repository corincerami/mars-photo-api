require './scraper'

images = scrape_images

sql = "INSERT INTO photos (img_src, sol, camera) VALUES "

values = []
images.each do |image|
  values << "('#{image[:img_src]}', '#{image[:sol]}', '#{image[:camera]}')"
end

sql << values.join(", ")

Photo.destroy_all
ActiveRecord::Base.connection.execute(sql)
