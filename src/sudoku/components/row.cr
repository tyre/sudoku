require "./tile"

module Sudoku
  module Components
    class Row
      @tiles = Array(Tile).new

      property! board_size : Int32
      property! tiles : Array(Tile)

      def initialize(_tiles = Array(Tile).new)
        _tiles.each { |tile| add_tile(tile) }
        self.board_size = self.tiles.size
      end

      def add_tile(tile : Tile)
        tile.row = self
        self.tiles << tile
      end

      def values
        tiles.map { |tile| tile.value }
      end

      def valid?
        tiles.reduce(Set(Int32).new) do |acc, tile|
          if acc.includes?(tile.value)
            return false
          elsif tile.value?
            acc.add(tile.value.not_nil!)
          else
            acc
          end
        end
      end

      def solved?
        tiles.all? { |tile| tile.value? }
      end

      def contains?(value : Int32)
        tiles.any? { |tile| tile.value == value }
      end

      def as_formatted_string
        square_length = Math.sqrt(board_size)
        break_points = [square_length - 1, (square_length * 2 - 1)]
        values_output = tiles.each.with_index.map do |tile_and_index|
          tile = tile_and_index.first
          index = tile_and_index.last
          if break_points.includes?(index)
            tile.as_formatted_string + " | "
          else
            tile.as_formatted_string
          end
        end

        "[ " + values_output.join(" | ") + " ]"
      end
    end
  end
end
