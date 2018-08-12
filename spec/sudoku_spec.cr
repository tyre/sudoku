require "./spec_helper"

describe Sudoku do
  # Hard
  #
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

  # Easy
  #
  # [
  #   [nil,   2,   8, nil,   7, nil,   5, nil, nil],
  #   [  9, nil,   6, nil, nil,   5, nil, nil,   3],
  #   [  7, nil, nil,   4, nil, nil, nil,   2, nil],
  #
  #   [  4, nil,   2,   6, nil,   9, nil,   3, nil],
  #   [nil, nil,   1, nil,   8, nil,   9, nil, nil],
  #   [nil,   8, nil,   7, nil,   4,   1, nil,   2],
  #
  #   [nil,   5, nil, nil, nil,   8, nil, nil,   7],
  #   [  8, nil, nil,   2, nil, nil,   3, nil,   6],
  #   [nil, nil,   3, nil,   5, nil,   4,   8, nil]
  # ]

  # Answer
  #
  # [
  #   [3, 2, 8, 1, 7, 6, 5, 4, 9],
  #   [9, 4, 6, 8, 2, 5, 7, 1, 3],
  #   [7, 1, 5, 4, 9, 3, 6, 2, 8],
  #   [4, 7, 2, 6, 1, 9, 8, 3, 5],
  #   [6, 3, 1, 5, 8, 2, 9, 7, 4],
  #   [5, 8, 9, 7, 3, 4, 1, 6, 2],
  #   [1, 5, 4, 3, 6, 8, 2, 9, 7],
  #   [8, 9, 7, 2, 4, 1, 3, 5, 6],
  #   [2, 6, 3, 9, 5, 7, 4, 8, 1]
  # ]


end
