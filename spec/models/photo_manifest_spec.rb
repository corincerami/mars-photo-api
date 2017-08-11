require 'rails_helper'

describe PhotoManifest do
  let(:rover) { create(:rover) }
  let(:manifest) { PhotoManifest.new(rover) }
  let(:cache_key) { manifest.send :cache_key_name }

  describe "#to_a" do
    before(:each) do
      create_list :photo, 3, rover: rover, sol: 1000
      create_list :photo, 5, rover: rover, sol: 1001
    end

    it "lists each sol for which photos exist" do
      sols = manifest.to_a.map { |record| record[:sol] }
      expect(sols).to contain_exactly 1000, 1001
    end

    it "has a count of photos for each sol" do
      expect(manifest.to_a.first[:total_photos]).to eq 3
      expect(manifest.to_a.last[:total_photos]).to eq 5
    end

    it "lists all of the cameras for which photos exist in each sol" do
      camera = create(:camera, name: "TEST")
      create(:photo, rover: rover, sol: 1000, camera: camera)

      expect(manifest.to_a.first[:cameras]).to contain_exactly "FHAZ", "TEST"
      expect(manifest.to_a.last[:cameras]).to contain_exactly "FHAZ"
    end
  end

  describe "#photos" do
    it "returns result from cache if cached" do
      expect($redis).to receive(:get).twice.with(cache_key).and_return "[]"
      expect($redis).not_to receive(:set).with cache_key, manifest.to_a.to_json
      manifest.photos
    end

    it "creates a new collection and caches it if not cached" do
      expect($redis).to receive(:set).once.with cache_key, manifest.to_a.to_json
      expect($redis).to receive(:get).once.with cache_key
      manifest.photos
    end

    it "creates a new collection if more photos have been added since the last cache" do
      expect($redis).to receive(:set).once.with cache_key, manifest.to_a.to_json
      expect($redis).to receive(:get).once.with cache_key
      manifest.photos

      create(:photo, rover: rover)
      new_cache_key = manifest.send :cache_key_name
      expect($redis).to receive(:set).once.with new_cache_key, manifest.to_a.to_json
      expect($redis).to receive(:get).once.with new_cache_key
      manifest.photos
    end
  end
end
