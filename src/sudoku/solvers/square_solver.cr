require "../components/*"

module Sudoku
  module Solvers
    class SquareSolver
      # This can be optimized later if need be. We can loop once to a) gather
      # the values of tiles which have them set and b) gather the tiles that
      # don't have values. Then we would only loop over the unsolved tiles for
      # the second loop.
      def self.solve!(square : Sudoku::Components::Square)
        solved_tile_values = square.values.compact.to_set
        square.tiles.each do |tile|
          unless tile.value?
            tile.remove_possibilities(solved_tile_values)
          end
        end
      end
    end
  end
end
