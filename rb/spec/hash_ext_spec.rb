require 'spec_helper'
require_relative '../lib/hash_ext.rb'

RSpec.describe Hash, "#update_in" do
  context "top level value, empty hash" do
    let(:h){ Hash.new }
    specify{ expect(h.update_in([:a],:b)).to eq({:a => :b}) }
  end
  context "top level value, non-empty hash" do
    let(:h){ {:b => :c} }
    specify{ expect(h.update_in([:a],:b)).to eq({:a => :b, :b => :c}) }
  end
  context "nested value" do
    let(:h) { {:a => {:b => :c}} }
    specify do
      expect(h.update_in([:a,:c], :d)).to eq({:a => {:b => :c, :c => :d}})
    end
  end
  context "arbitrarily deeply nested value" do
    let(:h) do
      {:a => {:b => {:c => {:d => {:e => :f}}}},
       :b => {:c => :d}}
    end
    let(:result) do
      {:a => {:b => {:c => {:d => {:e => :g}}}},
       :b => {:c => :d}}
    end
    specify do
      expect(h.update_in([:a,:b,:c,:d,:e], :g)).to eq(result)
    end
  end
end
