# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2023::Day17 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2023/17/input.txt")) }
  let(:example_input) {
    <<~EOF
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
    EOF
  }
  let(:example_input2) {
    <<~EOF
    111111111111
    999999999991
    999999999991
    999999999991
    999999999991
    EOF
  }
  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(102)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_1(input)).to eq(nil)
    # end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(94)
      expect(described_class.part_2(example_input2)).to eq(71)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_2(input)).to eq(nil)
    # end
  end
end
