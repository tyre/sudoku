require "../spec_helper"

describe Sudoku::Solver do
  context "with a simple solvable tile" do
    it "creates a board with a matrix of rows" do
      sample_rows = [
        [1, 2, 3, 4],
        [3, 4, 2, nil],
        [4, nil, 1, 2],
        [2, 1, 4, 3],
      ]
      board = Sudoku::Components::Board.new(sample_rows)
      solver = Sudoku::Solver.new(board)

      solver.solve!

      board.tiles_in_rows[1][3].value?.should be_true
      board.tiles_in_rows[1][3].value.should eq 1

      board.tiles_in_rows[2][1].value?.should be_true
      board.tiles_in_rows[2][1].value.should eq 3
    end
  end

  context "with an easy board" do
    it "should solve the board" do
      sample_rows = [
        [nil, 2, 8, nil, 7, nil, 5, nil, nil],
        [9, nil, 6, nil, nil, 5, nil, nil, 3],
        [7, nil, nil, 4, nil, nil, nil, 2, nil],
        [4, nil, 2, 6, nil, 9, nil, 3, nil],
        [nil, nil, 1, nil, 8, nil, 9, nil, nil],
        [nil, 8, nil, 7, nil, 4, 1, nil, 2],
        [nil, 5, nil, nil, nil, 8, nil, nil, 7],
        [8, nil, nil, 2, nil, nil, 3, nil, 6],
        [nil, nil, 3, nil, 5, nil, 4, 8, nil],
      ]

      board = Sudoku::Components::Board.new(sample_rows)
      solver = Sudoku::Solver.new(board)

      solver.solve!

      puts "~" * 25
      puts board.as_formatted_string
      puts "~" * 25
    end
  end

  context "with a medium difficulty board" do
    # [
    #   [  5, nil, nil,   9, nil, nil,   6, nil, nil],
    #   [  4, nil, nil,   2,   1, nil,   5,   3, nil],
    #   [nil,   8, nil, nil,   4, nil,   7,   1, nil],
    #   [nil,   7, nil, nil, nil, nil,   1, nil,   5],
    #   [nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #   [  8, nil,   5, nil, nil, nil, nil,   6, nil],
    #   [nil,   2,   8, nil,   5, nil, nil,   9, nil],
    #   [nil,   4,   9, nil,   3,   2, nil, nil,   6],
    #   [nil, nil,   1, nil, nil,   8, nil, nil,   2]
    # ]

    it "should solve the board" do
      sample_rows = [
        [5, nil, nil, 9, nil, nil, 6, nil, nil],
        [4, nil, nil, 2, 1, nil, 5, 3, nil],
        [nil, 8, nil, nil, 4, nil, 7, 1, nil],
        [nil, 7, nil, nil, nil, nil, 1, nil, 5],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [8, nil, 5, nil, nil, nil, nil, 6, nil],
        [nil, 2, 8, nil, 5, nil, nil, 9, nil],
        [nil, 4, 9, nil, 3, 2, nil, nil, 6],
        [nil, nil, 1, nil, nil, 8, nil, nil, 2],
      ]

      board = Sudoku::Components::Board.new(sample_rows)
      solver = Sudoku::Solver.new(board)

      solver.solve!

      puts "~" * 25
      puts board.as_formatted_string
      puts "~" * 25
    end
  end

  context "with a difficult board" do
    # [
    #   [nil, nil, nil,   5, nil,   6,   4, nil, nil],
    #   [nil, nil, nil, nil, nil, nil, nil,   6,   2],
    #   [  7, nil,   4, nil,   1, nil, nil, nil, nil],
    #   [  9, nil, nil, nil,   4,   3, nil, nil,   7],
    #   [nil,   2, nil, nil, nil, nil, nil, nil, nil],
    #   [nil,   8, nil, nil,   9, nil, nil,   5, nil],
    #   [nil, nil, nil, nil, nil, nil, nil, nil, nil],
    #   [  3, nil, nil, nil, nil,   8,   7, nil, nil],
    #   [nil,   5, nil,   3, nil,   4, nil, nil,   1]
    # ]

    it "should solve the board" do
      sample_rows = [
        [nil, nil, nil, 5, nil, 6, 4, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, 6, 2],
        [7, nil, 4, nil, 1, nil, nil, nil, nil],
        [9, nil, nil, nil, 4, 3, nil, nil, 7],
        [nil, 2, nil, nil, nil, nil, nil, nil, nil],
        [nil, 8, nil, nil, 9, nil, nil, 5, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [3, nil, nil, nil, nil, 8, 7, nil, nil],
        [nil, 5, nil, 3, nil, 4, nil, nil, 1],
      ]

      board = Sudoku::Components::Board.new(sample_rows)
      solver = Sudoku::Solver.new(board)

      solver.solve!

      puts board.as_formatted_string
    end
  end
end

# [ _ | _ | _ | 5 | _ | 6 | 4 | 7 | _ ]
# [ _ | _ | _ | 4 | _ | _ | 1 | 6 | 2 ]
# [ 7 | 6 | 4 | _ | 1 | _ | _ | _ | _ ]
# [ 9 | 1 | _ | _ | 4 | 3 | _ | _ | 7 ]
# [ _ | 2 | _ | _ | _ | _ | _ | 1 | _ ]
# [ _ | 8 | _ | _ | 9 | _ | _ | 5 | _ ]
# [ _ | _ | _ | _ | _ | _ | _ | _ | _ ]
# [ 3 | _ | _ | _ | _ | 8 | 7 | _ | _ ]
# [ _ | 5 | _ | 3 | _ | 4 | _ | _ | 1 ]
