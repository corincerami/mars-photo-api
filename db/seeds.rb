curiosity = Rover.create(name: "Curiosity", landing_date: Date.new(2012, 8, 6))
opportunity = Rover.create(name: "Opportunity", landing_date: Date.new(2004, 1, 25))

opportunity.cameras.create(name: "FHAZ")
opportunity.cameras.create(name: "RHAZ")
opportunity.cameras.create(name: "NAVCAM")
opportunity.cameras.create(name: "PANCAM")
opportunity.cameras.create(name: "MINITES")
opportunity.cameras.create(name: "ENTRY")

curiosity.cameras.create(name: "FHAZ")
curiosity.cameras.create(name: "RHAZ")
curiosity.cameras.create(name: "MAST")
curiosity.cameras.create(name: "CHEMCAM")
curiosity.cameras.create(name: "MAHLI")
curiosity.cameras.create(name: "MARDI")
curiosity.cameras.create(name: "NAVCAM")

Photo.all.each do |photo|
  if !photo.old_camera.blank?
    camera = photo.rover.cameras.find_by(name: photo.old_camera)
    photo.camera = camera
  end
  photo.rover = curiosity
  photo.save
end
