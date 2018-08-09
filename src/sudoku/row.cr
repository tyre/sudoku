require "./tile"

module Sudoku
  class Row
    property! board_size : Int32
    property! tiles : Array(Tile)

    def initialize(@tiles)
      self.board_size = self.tiles.size
    end

    def add_tile(tile : Tile)
      self.tiles << tile
    end
  end
end
