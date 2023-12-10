# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2023::Day10 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2023/10/input.txt")) }

let(:example_input) {
    <<~EOF
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    EOF
  }
  let(:example_input2) {
    <<~EOF
      ..F7.
      .FJ|.
      SJ.L7
      |F--J
      LJ...
    EOF
  }
  let(:example_input3) {
    <<~EOF
    ..........
    .S------7.
    .|F----7|.
    .||....||.
    .||....||.
    .|L-7F-J|.
    .|..||..|.
    .L--JL--J.
    ..........
    EOF
  }
  let(:example_input4) {
    <<~EOF
    .F----7F7F7F7F-7....
    .|F--7||||||||FJ....
    .||.FJ||||||||L7....
    FJL7L7LJLJ||LJ.L-7..
    L--J.L7...LJS7F-7L7.
    ....F-J..F7FJ|L7L7L7
    ....L7.F7||L7|.L7L7|
    .....|FJLJ|FJ|F7|.LJ
    ....FJL-7.||.||||...
    ....L---J.LJ.LJLJ...
    EOF
  }

  let(:example_input5) {
    <<~EOF
    FF7FSF7F7F7F7F7F---7
    L|LJ||||||||||||F--J
    FL-7LJLJ||||||LJL-77
    F--JF--7||LJLJ7F7FJ-
    L---JF-JLJ.||-FJLJJ7
    |F|F-JF---7F7-L7L|7|
    |FFJF7L7F-JF7|JL---7
    7-L-JL7||F7|L7F-7F7|
    L.L7LFJ|||||FJL7||LJ
    L7JLJL-JLJLJL--JLJ.L
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(4)
      expect(described_class.part_1(example_input2)).to eq(8)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_1(input)).to eq(nil)
    # end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input3)).to eq(4)
      expect(described_class.part_2(example_input4)).to eq(8)
      expect(described_class.part_2(example_input5)).to eq(10)
    end

    # it "returns nil for my input" do
    #   expect(described_class.part_2(input)).to eq(nil)
    # end
  end
end
