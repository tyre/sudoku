require "../../spec_helper"

describe Sudoku::Components::Square do
  describe "#initialize" do
    it "associates itself with each `tile.square`" do
      tiles = [
        [
          Sudoku::Components::Tile.new(4, 1),
          Sudoku::Components::Tile.new(4, 2)
        ],
        [
          Sudoku::Components::Tile.new(4, 3),
          Sudoku::Components::Tile.new(4, 4)
        ]
      ]
      square = Sudoku::Components::Square.new(tiles)
      tiles.flatten.all? { |tile| tile.square == square }.should be_true
    end
  end

  describe "contains?" do
    context "when one square tile contains the value" do
      it "should return true" do
        tiles = [
          [
            Sudoku::Components::Tile.new(4, 1),
            Sudoku::Components::Tile.new(4, 2)
          ],
          [
            Sudoku::Components::Tile.new(4, 3),
            Sudoku::Components::Tile.new(4, 4)
          ]
        ]
        square = Sudoku::Components::Square.new(tiles)

        square.contains?(1).should be_true
        square.contains?(2).should be_true
        square.contains?(3).should be_true
        square.contains?(4).should be_true
      end
    end

    context "when no square tile contains the value" do
      it "should return false" do
        tiles = [
          [
            Sudoku::Components::Tile.new(4, 1),
            Sudoku::Components::Tile.new(4, nil)
          ],
          [
            Sudoku::Components::Tile.new(4, 3),
            Sudoku::Components::Tile.new(4, 4)
          ]
        ]
        square = Sudoku::Components::Square.new(tiles)

        square.contains?(2).should be_false
      end
    end
  end

  describe "#possibilities" do
    context "when square is solved" do
      it "returns an empty set" do
        tiles = [
          [
            Sudoku::Components::Tile.new(4, 1),
            Sudoku::Components::Tile.new(4, 2)
          ],
          [
            Sudoku::Components::Tile.new(4, 3),
            Sudoku::Components::Tile.new(4, 4)
          ]
        ]
        square = Sudoku::Components::Square.new(tiles)
        square.possibilities.should eq Set(Int32).new()
      end
    end

    context "when square has unsolved tiles" do
      it "returns a set of the remaining values" do
        tiles = [
          [
            Sudoku::Components::Tile.new(4, 1),
            Sudoku::Components::Tile.new(4, nil)
          ],
          [
            Sudoku::Components::Tile.new(4, nil),
            Sudoku::Components::Tile.new(4, 4)
          ]
        ]
        square = Sudoku::Components::Square.new(tiles)
        square.possibilities.should eq [2, 3].to_set
      end
    end
  end
end
