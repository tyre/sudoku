require "../../spec_helper"

describe Sudoku::Solvers::SquareSolver do
  describe "#solve" do
    it "eliminates the values from the current square for all unsolved tiles" do
      tiles = [
        [nil, 2, 8],
        [nil, 7, nil],
        [5, nil, nil]
      ].map do |row|
        row.map { |value| Sudoku::Components::Tile.new(9, value) }
      end
      square = Sudoku::Components::Square.new(tiles)

      Sudoku::Solvers::SquareSolver.solve!(square)

      possibilities = [1, 3, 4, 6, 9].to_set
      tiles = tiles.flatten
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
