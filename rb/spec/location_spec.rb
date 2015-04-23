require 'rspec'
require_relative '../lib/taxonomy'
require_relative '../lib/location'

RSpec.describe Location do

  let(:tax) do
    Taxonomy.new('../resources/taxonomy.xml')
  end
  let(:africa) { tax.find('Africa') }
  let(:south_africa) { tax.find('South Africa') }

  describe '#ancestor' do
    specify do
      expect(africa.ancestor).to be(nil)
      expect(south_africa.ancestor).to eq('Africa')
    end
  end

  describe '#children' do
    let(:result) do
       ["Cape Town", "Free State", "Gauteng", "KwaZulu-Natal",
        "Mpumalanga", "The Drakensberg", "The Garden Route"]
    end
    specify { expect(south_africa.children).to eq(result) }
  end

end
