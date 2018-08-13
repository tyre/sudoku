require "../components/*"

module Sudoku
  module Solvers
    class ColumnSolver
      # This can be optimized later if need be. We can loop once to a) gather
      # the values of tiles which have them set and b) gather the tiles that
      # don't have values. Then we would only loop over the unsolved tiles for
      # the second loop.
      def self.solve!(column : Sudoku::Components::Column)
        solved_tile_values = column.values.compact.to_set
        column.tiles.each do |tile|
          unless tile.value?
            tile.remove_possibilities(solved_tile_values)
          end
        end
      end
    end
  end
end
