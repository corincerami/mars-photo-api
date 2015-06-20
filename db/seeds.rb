curiosity = Rover.find_or_create_by(name: "Curiosity",
                                    landing_date: Date.new(2012, 8, 6))
opportunity = Rover.find_or_create_by(name: "Opportunity",
                                      landing_date: Date.new(2004, 1, 25))
spirit = Rover.find_or_create_by(name: "Spirit",
                                 landing_date: Date.new(2004, 1, 4))

opportunity.cameras.find_or_create_by(name: "FHAZ")
opportunity.cameras.find_or_create_by(name: "RHAZ")
opportunity.cameras.find_or_create_by(name: "NAVCAM")
opportunity.cameras.find_or_create_by(name: "PANCAM")
opportunity.cameras.find_or_create_by(name: "MINITES")
opportunity.cameras.find_or_create_by(name: "ENTRY")

curiosity.cameras.find_or_create_by(name: "FHAZ")
curiosity.cameras.find_or_create_by(name: "RHAZ")
curiosity.cameras.find_or_create_by(name: "MAST")
curiosity.cameras.find_or_create_by(name: "CHEMCAM")
curiosity.cameras.find_or_create_by(name: "MAHLI")
curiosity.cameras.find_or_create_by(name: "MARDI")
curiosity.cameras.find_or_create_by(name: "NAVCAM")

spirit.cameras.find_or_create_by(name: "FHAZ")
spirit.cameras.find_or_create_by(name: "RHAZ")
spirit.cameras.find_or_create_by(name: "NAVCAM")
spirit.cameras.find_or_create_by(name: "PANCAM")
spirit.cameras.find_or_create_by(name: "MINITES")
spirit.cameras.find_or_create_by(name: "ENTRY")
