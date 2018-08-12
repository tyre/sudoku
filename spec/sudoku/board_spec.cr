require "../spec_helper"

describe Sudoku::Board do
  it "creates a board with a matrix of rows" do
    sample_rows = [
      [1,   2,   3,   4],
      [3,   4,   2,   nil],
      [4,   nil, 1,   2],
      [2,   1,   4,   3],
    ]
    board = Sudoku::Board.new(sample_rows)
    board.raw.should eq sample_rows
  end

  describe "#initialize" do
    it "should break up the rows into squares" do
      sample_rows = [
        [1,   2,   3,   4],
        [3,   4,   2,   nil],
        [4,   nil, 1,   2],
        [2,   1,   4,   3],
      ]
      board = Sudoku::Board.new(sample_rows)
      raw_squares = board.squares.map do |square|
        square.tiles.map do |row|
         row.map { |tile| tile.value }
        end
      end

      raw_squares.should eq [
        [
          [1, 2],
          [3, 4]
        ],
        [
          [3, 4,],
          [2, nil]
        ],
        [
          [4, nil],
          [2, 1]
        ],
        [
          [1, 2],
          [4, 3]
        ]
      ]
    end

    it "should build columns from the tiles" do
      sample_rows = [
        [1,   2,   3,   4],
        [3,   4,   2,   nil],
        [4,   nil, 1,   2],
        [2,   1,   4,   3],
      ]
      board = Sudoku::Board.new(sample_rows)
      raw_columns = board.columns.map do |column|
        column.tiles.map { |tile| tile.value }
      end

      raw_columns.should eq [
        [1, 3, 4, 2],
        [2, 4, nil, 1],
        [3, 2, 1, 4],
        [4, nil, 2, 3]
      ]
    end
  end
end
