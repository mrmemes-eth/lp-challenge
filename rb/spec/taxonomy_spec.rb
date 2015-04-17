require 'spec_helper'
require_relative '../lib/taxonomy.rb'

RSpec.describe Taxonomy do
  describe "#retrieve" do
    let(:sudan) { Location.new(name: "Sudan") }
    let(:africa) { Location.new(name: "Africa", locations: [sudan]) }
    let(:world) { Taxonomy.new(name: "World", locations: [africa]) }
    it "returns a child location" do
      expect(world.retrieve("Sudan")).to eq(sudan)
    end
  end
end
