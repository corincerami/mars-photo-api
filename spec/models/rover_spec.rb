require 'rails_helper'

RSpec.describe Rover, type: :model do
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :landing_date }
  end

  describe "associations" do
    it { should have_many :photos }
    it { should have_many :cameras }
  end
end
