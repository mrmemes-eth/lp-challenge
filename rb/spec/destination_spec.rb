require 'rspec'
require_relative '../lib/taxonomy'
require_relative '../lib/destination'

RSpec.describe Destination do
  let(:tax) { Taxonomy.new('../resources/taxonomy.xml') }
  let(:dest) { Destination.new(tax,"Cape Town") }

  describe "#file_name" do
    specify{ expect(dest.file_name).to eq("cape_town.html") }
  end

  describe "#super_region" do
    specify{ expect(dest.super_region).to be_kind_of(Destination) }
    specify{ expect(dest.super_region.name).to eq("South Africa") }
  end
end
