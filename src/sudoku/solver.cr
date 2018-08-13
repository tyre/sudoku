require "./components/*"
require "./solvers/*"

module Sudoku
  class Solver
    property! board : Sudoku::Components::Board

    def initialize(@board : Sudoku::Components::Board, @debug = false)
    end

    def solve!
      unsolved_tiles = [board.unsolved_tiles.size]
      Sudoku::Helpers::PrettyPrinter.puts(board) if @debug
      until board.solved?
        if !board.valid?
          puts "Invalid board! Aborting" if @debug
          break
        end
        puts "Solving with #{unsolved_tiles.last} remaining…" if @debug
        solve
        unsolved_tiles << board.unsolved_tiles.size
        if unsolved_tiles.last(4).first == unsolved_tiles.last
          puts "Made no progress, aborting" if @debug
          break
        end
        Sudoku::Helpers::PrettyPrinter.puts(board) if @debug
      end
    end

    def solve
      reset_tile_possibilities
      prune_known_impossibilities
      return if solve_tiles_with_one_possibility
      solve_tiles_as_only_possibility
    end

    def reset_tile_possibilities
      board.tiles.each { |tile| tile.reset_possibilities }
    end

    def prune_known_impossibilities
      prune_row_impossibilities
      prune_column_impossibilities
      prune_square_impossibilities
    end

    def prune_row_impossibilities
      board.rows.each { |row| Sudoku::Solvers::RowSolver.solve!(row) }
    end

    def prune_column_impossibilities
      board.columns.each { |column| Sudoku::Solvers::ColumnSolver.solve!(column) }
    end

    def prune_square_impossibilities
      board.squares.each { |square| Sudoku::Solvers::SquareSolver.solve!(square) }
    end

    def solve_tiles_with_one_possibility
      board.tiles.reduce(false) do |solved_a_tile, tile|
        if !tile.value? && tile.possibilities.size == 1
          tile.value = tile.possibilities.first
          true
        else
          solved_a_tile
        end
      end
    end

    # If there is a tile in a row/column/square that is the only remaining
    # possibility for that number, then we know it is correct
    def solve_tiles_as_only_possibility
      # solve_row_tiles_as_only_possibility
      # solve_column_tiles_as_only_possibility
      solve_square_tiles_as_only_possibility
    end

    def solve_square_tiles_as_only_possibility
      board.squares.each do |square|
        empty_accumulator = Hash(Int32, Array(Sudoku::Components::Tile)).new
        tiles_by_possibilities = square.tiles.reduce(empty_accumulator) do |acc, tile|
          if tile.value?
            acc
          else
            tile.possibilities.each do |possibility|
              if acc.has_key?(possibility)
                acc[possibility].push(tile)
              else
                acc[possibility] = [tile]
              end
            end
            acc
          end
        end

        # puts tiles_by_possibilities.map { |k, v| {k, v.map { |t| t.object_id }} }.pretty_inspect

        tiles_by_possibilities.each do |possibility, tiles|
          if tiles.size == 1
            puts "Solving #{possibility} with #{tiles.map { |t| t.object_id }}" if @debug
            tiles.first.value = possibility
            return true
          end
        end
      end
    end
  end
end
