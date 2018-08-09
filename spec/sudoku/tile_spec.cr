require "../spec_helper"

describe Sudoku::Tile do
  describe "when the value is not known" do
    it "creates an array of all possible values based on board size" do
      tile = Sudoku::Tile.new(4, nil)
      tile.possibilities.should eq [1, 2, 3, 4].to_set
    end
  end

  describe "#remove_possibility" do
    it "removes the value as a possibility" do
      tile = Sudoku::Tile.new(4, nil)
      tile.remove_possibility(3)
      tile.possibilities.should eq [1, 2, 4].to_set
    end
  end
end
