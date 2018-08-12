require "../spec_helper"

describe Sudoku::Column do
  describe "#initialize" do
    it "sets the tiles' `column` to itself" do
      a_tile = Sudoku::Tile.new(4, nil)
      column = Sudoku::Column.new([a_tile])
      a_tile.column.should be column
    end
  end

  describe "#add_tile" do
    it "sets the tile's `column` to itself" do
      a_tile = Sudoku::Tile.new(4, nil)
      column = Sudoku::Column.new([a_tile])

      b_tile = Sudoku::Tile.new(9, 4)
      column.add_tile(b_tile)
      b_tile.column.should be column
    end
  end

  describe "solved?" do
    context "with no nil values" do
      it "should be solved" do
        column = Sudoku::Column.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, 2),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        column.solved?.should be_true
      end
    end

    context "with nil values" do
      it "should not be solved" do
        column = Sudoku::Column.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, nil),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        column.solved?.should be_false
      end
    end
  end

  describe "contains?" do
    context "when a tile has the value" do
      it "should return true" do
        column = Sudoku::Column.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, 2),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        column.contains?(1).should be_true
        column.contains?(2).should be_true
        column.contains?(3).should be_true
        column.contains?(4).should be_true
      end
    end

    context "when no tile has the value" do
      it "should return false" do
        column = Sudoku::Column.new([
          Sudoku::Tile.new(4, 1),
          Sudoku::Tile.new(4, nil),
          Sudoku::Tile.new(4, 3),
          Sudoku::Tile.new(4, 4)
        ])
        column.contains?(2).should be_false
      end
    end
  end
end
