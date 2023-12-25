# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2023::Day25 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2023/25/input.txt")) }
  let(:example_input) {
    <<~EOF
    jqt: rhn xhk nvd
    rsh: frs pzl lsr
    xhk: hfx
    cmg: qnr nvd lhk bvb
    rhn: xhk bvb hfx
    bvb: xhk hfx
    pzl: lsr hfx nvd
    qnr: nvd
    ntq: jqt hfx bvb xhk
    nvd: lhk
    lsr: lhk
    rzs: qnr cmg lsr rsh
    frs: qnr lhk lsr
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(54)
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
