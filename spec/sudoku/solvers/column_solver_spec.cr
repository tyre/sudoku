require "../../spec_helper"

describe Sudoku::Solvers::ColumnSolver do
  describe "#solve" do
    it "eliminates the values from the current column for all unsolved tiles" do
      tiles = [nil, 2, 8, nil, 7, nil, 5, nil, nil].map do |value|
        Sudoku::Components::Tile.new(9, value)
      end
      column = Sudoku::Components::Column.new(tiles)

      Sudoku::Solvers::ColumnSolver.solve!(column)

      possibilities = [1, 3, 4, 6, 9].to_set

      [
        tiles[0],
        tiles[3],
        tiles[5],
        tiles[7],
        tiles[8]
      ].each do |tile|
        tile.possibilities.should eq possibilities
      end
    end
  end
end
