require "./row"
module Sudoku
  class Column < Row
    def add_tile(tile)
      tile.column = self
      self.tiles << tile
    end
  end
end
