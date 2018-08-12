require "../spec_helper"

describe Sudoku::Row do
  describe "#initialize" do
    it "sets the tiles' `row` to itself" do
      a_tile = Sudoku::Tile.new(4, nil)
      row = Sudoku::Row.new([a_tile])
      a_tile.row.should be row
    end
  end

  describe "#add_tile" do
    it "sets the tile's `row` to itself" do
      a_tile = Sudoku::Tile.new(4, nil)
      row = Sudoku::Row.new([a_tile])

      b_tile = Sudoku::Tile.new(9, 4)
      row.add_tile(b_tile)
      b_tile.row.should be row
    end
  end

  describe "solved?" do
    context "with no nil values" do
      it "should be solved" do
        row = Sudoku::Row.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, 2),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        row.solved?.should be_true
      end
    end

    context "with nil values" do
      it "should not be solved" do
        row = Sudoku::Row.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, nil),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        row.solved?.should be_false
      end
    end
  end

  describe "contains?" do
    context "when a tile has the value" do
      it "should return true" do
        row = Sudoku::Row.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, 2),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        row.contains?(1).should be_true
        row.contains?(2).should be_true
        row.contains?(3).should be_true
        row.contains?(4).should be_true
      end
    end

    context "when no tile has the value" do
      it "should return false" do
        row = Sudoku::Row.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, nil),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        row.contains?(2).should be_false
      end
    end
  end
end
