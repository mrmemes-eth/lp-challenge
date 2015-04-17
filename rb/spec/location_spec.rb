require 'spec_helper'
require_relative '../lib/location'

RSpec.describe Location do
  describe "#retrieve" do
    let(:africa) { Location.new(name: "Africa") }
    context "when the desired location is top-level" do
      it "returns that location" do
        expect(africa.retrieve("Africa")).to eq(africa)
      end
    end
    context "when the desired location is one level lower" do
      let(:sudan) { Location.new(name: "Sudan") }
      before { africa.locations = [sudan] }
      it "returns that location" do
        expect(africa.retrieve("Sudan")).to eq(sudan)
      end
      context "and there are multiple locations at that level" do
        let(:cape_town) { Location.new(name: "Cape Town") }
        before { africa.locations = [sudan, cape_town] }
        it "returns that node" do
          expect(africa.retrieve("Cape Town")).to eq(cape_town)
        end
      end
    end
    context "when the desired location is two levels deep" do
      let(:sudan) { Location.new(name: "Sudan") }
      let(:khartoum) { Location.new(name: "Khartoum") }
      before do
        sudan.locations = [khartoum]
        africa.locations = [sudan]
      end
      it "returns that node" do
        expect(africa.retrieve("Khartoum")).to eq(khartoum)
      end
    end
    context "when the desired location is arbitrarily deep" do
      let(:a) { Location.new(name: "a") }
      let(:b) { Location.new(name: "b") }
      let(:c) { Location.new(name: "c") }
      let(:d) { Location.new(name: "d") }
      let(:e) { Location.new(name: "e") }
      let(:f) { Location.new(name: "f") }
      let(:khartoum) { Location.new(name: "Khartoum") }
      before do
        africa.locations = [a]
        a.locations = [b]
        b.locations = [c]
        c.locations = [d]
        d.locations = [e]
        e.locations = [f]
        f.locations = [khartoum]
      end
      it "returns that node" do
        expect(africa.retrieve("Khartoum")).to eq(khartoum)
      end
    end
  end
end
