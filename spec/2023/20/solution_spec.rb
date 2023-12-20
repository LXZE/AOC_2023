# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2023::Day20 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2023/20/input.txt")) }
  let(:example_input) {
    <<~EOF
    broadcaster -> a, b, c
    %a -> b
    %b -> c
    %c -> inv
    &inv -> a
    EOF
  }
  let(:example_input2) {
    <<~EOF
    broadcaster -> a
    %a -> inv, con
    &inv -> b
    %b -> con
    &con -> output
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(32000000)
      expect(described_class.part_1(example_input2)).to eq(11687500)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_1(input)).to eq(nil)
    # end
  end

  describe "part 2" do
    # it "returns nil for the example input" do
    #   expect(described_class.part_2(example_input)).to eq(nil)
    # end

    # it "returns nil for my input" do
    #   expect(described_class.part_2(input)).to eq(nil)
    # end
  end
end
