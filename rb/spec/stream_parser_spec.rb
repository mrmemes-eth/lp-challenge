require 'spec_helper'
require_relative '../lib/stream_parser'

RSpec.describe StreamParser do
  let(:store) { Array.new }
  let(:emitter) { ->(attrs) { store.push(attrs) } }
  let(:parser) { StreamParser.new(emitter) }

  context "simple destination" do
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

  context "destination with multiple elements with the same name" do
    before do
      File.open('spec/fixtures/multi_element.xml') do |f|
        Ox.sax_parse(parser, f)
      end
    end
    specify do
      expect(store).to eq([
        {:destination => {
          :atlas_id => "355613", :asset_id => nil,
          :title => "Table Mountain National Park",
          :"title-ascii" => "Table Mountain National Park",
          :history => {:history => {:history => ["History 1", "History 2", "History 3"]}}}}])
    end
  end
end
