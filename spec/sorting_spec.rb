require 'rspec'
require 'sortable.rb'

class Array
  include Sortable
end

describe "Sorting algorithms" do
  let(:shuffled_array) { [5, 2, 0, 1, 3] }
  let(:empty_array) { [] }
  let(:array_with_negative_numbers) { [-10, 4, -2, 5] }
  let(:array_with_duplicates) { [2, 4, 2, 2, 4, 0, -1] }
  let(:reversed_array) { [0, 1, 2, 3, 4, 5].reverse }

  Sortable.instance_methods(false).each do |sort_method|
    describe "##{sort_method}" do
      it "handles an empty array" do
        expect(empty_array.send(sort_method)).to eq([])
      end

      it "handles a shuffled array" do
        expect(shuffled_array.send(sort_method)).to eq(shuffled_array.sort)
      end

      it "handles an array with negative numbers" do
        expect(array_with_negative_numbers.send(sort_method)).to eq(array_with_negative_numbers.sort)
      end

      it "handles an array with duplicate entries" do
        expect(array_with_duplicates.send(sort_method)).to eq(array_with_duplicates.sort)
      end

      it "handles a reversed array" do
        expect(reversed_array.send(sort_method)).to eq(reversed_array.sort)
      end
    end
  end
end
