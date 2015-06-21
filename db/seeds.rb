curiosity = Rover.find_or_create_by(name: "Curiosity",
                                    landing_date: Date.new(2012, 8, 6))
opportunity = Rover.find_or_create_by(name: "Opportunity",
                                      landing_date: Date.new(2004, 1, 25))
spirit = Rover.find_or_create_by(name: "Spirit",
                                 landing_date: Date.new(2004, 1, 4))

opportunity.cameras.find_or_create_by(name: "FHAZ", full_name: "Front Hazard Avoidance Camera")
opportunity.cameras.find_or_create_by(name: "RHAZ", full_name: "Read Hazard Avoidance Camera")
opportunity.cameras.find_or_create_by(name: "NAVCAM", full_name: "Navigation Camera")
opportunity.cameras.find_or_create_by(name: "PANCAM", full_name: "Panoramic Camera")
opportunity.cameras.find_or_create_by(name: "MINITES", full_name: "Miniature Thermal Emission Spectrometer (Mini-TES)")
opportunity.cameras.find_or_create_by(name: "ENTRY", full_name: "Entry, Descent, and Landing Camera")

curiosity.cameras.find_or_create_by(name: "FHAZ", full_name: "Front Hazard Avoidance Camera")
curiosity.cameras.find_or_create_by(name: "RHAZ", full_name: "Read Hazard Avoidance Camera")
curiosity.cameras.find_or_create_by(name: "MAST", full_name: "Mast Camera")
curiosity.cameras.find_or_create_by(name: "CHEMCAM", full_name: "Chemistry and Camera Complex")
curiosity.cameras.find_or_create_by(name: "MAHLI", full_name: "Mars Hand Lens Imager")
curiosity.cameras.find_or_create_by(name: "MARDI", full_name: "Mars Descent Imager")
curiosity.cameras.find_or_create_by(name: "NAVCAM", full_name: "Navigation Camera")

spirit.cameras.find_or_create_by(name: "FHAZ", full_name: "Front Hazard Avoidance Camera")
spirit.cameras.find_or_create_by(name: "RHAZ", full_name: "Read Hazard Avoidance Camera")
spirit.cameras.find_or_create_by(name: "NAVCAM", full_name: "Navigation Camera")
spirit.cameras.find_or_create_by(name: "PANCAM", full_name: "Panoramic Camera")
spirit.cameras.find_or_create_by(name: "MINITES", full_name: "Miniature Thermal Emission Spectrometer (Mini-TES)")
spirit.cameras.find_or_create_by(name: "ENTRY", full_name: "Entry, Descent, and Landing Camera")
