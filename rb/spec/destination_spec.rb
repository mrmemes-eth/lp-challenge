require 'rspec'
require_relative '../lib/taxonomy'
require_relative '../lib/destination'

RSpec.describe Destination do
  let(:tax) { Taxonomy.new('../resources/taxonomy.xml') }
  let(:attrs) do
    { title: 'Cape Town',
      introductory: { introduction: { overview: 'Cape Town Overview' } } }
  end
  let(:dest) { Destination.new(tax,attrs) }

  describe "#name" do
    specify{ expect(dest.name).to eq("Cape Town") }
  end

  describe "#overview" do
    specify{ expect(dest.overview).to eq('Cape Town Overview') }
    context "when there is no overview" do
      let(:dest) { Destination.new(tax,{title: 'Carp Towne'}) }
      specify{ expect(dest.overview).to be(nil) }
    end
  end

  describe "#file_name" do
    specify{ expect(dest.file_name).to eq("cape_town.html") }
  end

  describe "#super_region" do
    specify{ expect(dest.super_region).to be_kind_of(Destination) }
    specify{ expect(dest.super_region.name).to eq("South Africa") }
  end

  describe "#sub_regions" do
    specify do
      expect(dest.sub_regions.all?{|r| r.kind_of?(Destination) }).to be(true)
    end
    specify{ expect(dest.sub_regions.map(&:name)).to eq(["Table Mountain National Park"]) }
  end

end
