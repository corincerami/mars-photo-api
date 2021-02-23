FactoryBot.define do
  factory :camera do
    name { "FHAZ" }
    rover
  end

  factory :rover do
    name { "Perserverance" }
    landing_date { Date.new(2021, 2, 18) }
    launch_date { Date.new(2020,  7, 30) }
    status { "active" }
  end

  factory :photo do
    sequence :img_src do |n| "https://mars.jpl.nasa.gov/msl-raw-images/proj/" +
      "msl/redops/ods/surface/sol/00829/opgs/edr/fcam/FRB_471079934EDR_F044" +
      "2062FHAZ00323M_.JPG#{n}"
    end
    sol { 829 }
    rover
    camera
  end
end
