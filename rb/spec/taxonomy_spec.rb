require 'rspec'
require_relative '../lib/taxonomy'
require_relative '../lib/location'

RSpec.describe Taxonomy do
  let(:tax) do
    Taxonomy.new('../resources/taxonomy.xml')
  end

  describe '#find' do
    specify do
      expect(tax.find('Africa')).to be_kind_of(Location)
    end
  end

end

