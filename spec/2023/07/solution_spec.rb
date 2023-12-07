# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2023::Day07 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2023/07/input.txt")) }
  let(:example_input) {
    <<~EOF
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(6440)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_1(input)).to eq(nil)
    # end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(5905)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_2(input)).to eq(nil)
    # end
  end
end
