require 'spec_helper'
require_relative '../lib/stream_parser'

RSpec.describe StreamParser do
  context "simple destination" do
    let(:store) { Array.new }
    let(:emitter) { ->(attrs) { store.push(attrs) } }
    let(:parser) { StreamParser.new(emitter) }
    before do
      File.open('spec/fixtures/simple_destination.xml') do |f|
        Ox.sax_parse(parser, f)
      end
    end
    specify do
      expect(store).to eq([
        {:destination => {
          :atlas_id => "355613", :asset_id => nil,
          :title => "Table Mountain National Park",
          :"title-ascii" => "Table Mountain National Park",
          :introductory => {
            :introduction => {
              :overview => "There is only an overview here." }}}}])
    end
  end
end
