require 'spec_helper'
require_relative '../lib/hash_ext.rb'

RSpec.describe Hash do
  describe "#update_in" do

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

    context "creates missing values as maps" do
      let(:h) { Hash.new }
      specify do
        expect(h.update_in([:a],:b)).to eq({:a => :b})
      end
      specify do
        expect(h.update_in([:a, :b],:c)).to eq({:a  => {:b => :c}})
      end
    end

    context "when provided a lambda" do
      let(:h) { {:a => {:b => :c}} }

      context "simple lambda" do
        let(:str_proc) do
          ->(current) { current.to_s }
        end
        specify do
          expect(h.update_in([:a,:b],str_proc)).to eq({:a => {:b => "c"}})
        end
      end

      context "collating lambda" do
        let(:update_proc) do
          ->(new,current) { current ? [new].unshift(current) : new }
        end
        let(:result) { {:a => {:b => [:c,:d]}} }
        specify do
          expect(h.update_in([:a,:b], update_proc.curry.call(:d))).to eq(result)
        end
      end
    end

  end
  
  describe "#get_in" do
    let(:h) do
      {:a => {:b => {:c => {:d => {:e => :f}}}},
       :b => {:c => :d}}
    end

    context "shallow fetches" do
      specify { expect(h.get_in(:b)).to eq({:c => :d}) }
      specify do
        expect(h.get_in(:a, :b)).to eq({:c => {:d => {:e => :f}}})
      end
      context "when there is no key" do
        specify { expect(h.get_in(:z)).to eq(nil) }
        specify { expect(h.get_in(:a, :f)).to eq(nil) }
      end
    end

    context "arbitrarily deeply nested" do
      specify do
        expect(h.get_in(:a,:b,:c,:d,:e)).to eq(:f)
      end
      context "when there is no key" do
        specify { expect(h.get_in(:a,:b,:c,:d,:f)).to eq(nil) }
      end
    end
  end
end
