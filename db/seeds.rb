require './images'

@images.each do |attributes|
  image = Photo.new(attributes)
  image.save
  print "."
end
