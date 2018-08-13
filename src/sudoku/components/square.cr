require "./tile"

module Sudoku
  module Components
    class Square
      property! tile_rows : Array(Array(Tile))
      property! tiles : Array(Tile)
      property! all_possiblities : Set(Int32)

      def initialize(@tile_rows : Array(Array(Tile)))
        self.tiles = self.tile_rows.reduce(Array(Tile).new) do |tiles, tile_row|
          tile_row.each do |tile|
            tiles << tile
            tile.square = self
          end
          tiles
        end

        @all_possiblities = (1..(self.tiles.size)).to_set
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

      def contains?(value : Int32)
        self.tiles.any? { |tile| tile.value == value }
      end

      def solved?
        self.tiles.all? { |tile| tile.solved? }
      end

      def values
        self.tiles.reduce(Array(Int32?).new) do |values, tile|
          values << tile.value
        end
      end

      def possibilities
        self.all_possiblities - values.compact.to_set
      end
    end
  end
end
