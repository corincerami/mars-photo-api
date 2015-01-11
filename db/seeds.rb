require './images'

@images.each do |attributes|
  image = Image.new(attributes)
  image.save
end
