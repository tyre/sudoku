require "./tile"

module Sudoku
  class Row
    @tiles = Array(Tile).new()
    
    property! board_size : Int32
    property! tiles : Array(Tile)

    def initialize(_tiles=Array(Tile).new())
      _tiles.each { |tile| add_tile(tile) }
      self.board_size = self.tiles.size
    end

    def add_tile(tile : Tile)
      tile.row = self
      self.tiles << tile
    end

    def solved?
      tiles.all? { |tile| tile.value? }
    end

    def contains?(value : Int32)
      tiles.any? { |tile| tile.value == value }
    end
  end
end
