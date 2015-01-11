FactoryGirl.define do
  factory :photo do
    img_src "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00829/opgs/edr/fcam/FRB_471079934EDR_F0442062FHAZ00323M_.JPG"
    sol 829
    camera "FHAZ"
  end
end
