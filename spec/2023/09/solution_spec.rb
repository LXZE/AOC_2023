# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2023::Day09 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2023/09/input.txt")) }
  let(:example_input) {
    <<~EOF
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(114)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_1(input)).to eq(nil)
    # end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(2)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_2(input)).to eq(nil)
    # end
  end
end
