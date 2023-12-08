# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2023::Day08 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2023/08/input.txt")) }
  let(:example_input) {
    <<~EOF
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    EOF
  }

  let(:example_input2) {
    <<~EOF
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    EOF
  }



  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(6)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_1(input)).to eq(nil)
    # end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input2)).to eq(6)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_2(input)).to eq(nil)
    # end
  end
end
