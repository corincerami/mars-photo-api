require 'rails_helper'

RSpec.describe Camera, type: :model do
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :full_name }
  end

  describe "associations" do
    it { should belong_to :rover }
    it { should have_many :photos }
  end
end
