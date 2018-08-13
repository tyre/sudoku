require "./row"
module Sudoku
  module Components
    class Column < Row
      def add_tile(tile)
        tile.column = self
        self.tiles << tile
      end
    end
  end
end
