require 'rails_helper'

RSpec.describe Photo, :type => :model do
  describe "attributes" do
    it { should respond_to :img_src }
    it { should respond_to :camera }
    it { should respond_to :sol }
    it { should respond_to :earth_date }
  end

  describe "associations" do
    it { should belong_to :rover }
    it { should belong_to :camera }
  end
end
