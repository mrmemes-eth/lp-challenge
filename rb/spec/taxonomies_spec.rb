require 'rspec'
require './lib/taxonomies'

RSpec.describe "Parsing XML" do
  let(:taxonomies) do
    File.open('../resources/taxonomy.xml','r') do |file|
      Taxonomies.parse(file)
    end
  end
  it do
    expect(taxonomies.taxonomies.count).to eq(1)
  end

  describe "#retrieve" do
    specify do
      expect(taxonomies.retrieve("Sudan")).to be_kind_of(Location)
      expect(taxonomies.retrieve("Sudan").name).to eq("Sudan")
    end
  end
end

RSpec.describe Taxonomies do
  describe "#retrieve" do
    let(:sudan) { Location.new(name: "Sudan") }
    let(:africa) { Location.new(name: "Africa", locations: [sudan]) }
    let(:world) { Taxonomy.new(name: "World", locations: [africa]) }
    let(:taxonomies) { Taxonomies.new(taxonomies: [world]) }
    it "returns a child location" do
      expect(taxonomies.retrieve("Sudan")).to eq(sudan)
    end
  end
end

