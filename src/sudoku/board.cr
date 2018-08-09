require "./tile"
require "./row"
require "./square"
module Sudoku
  class Board
    property! rows : Array(Row)
    property! tiles : Array(Array(Tile))
    property! squares : Array(Square)
    property! row_size : Int32
    property! square_size : Int32


    # A nil array member indicates an unknown or "blank" tile
    # This type definition is idiotic.
    def initialize(@board_values : Array(Array(Int32 | Nil)) | Array(Array(Nil) | Array(Int32) | Array(Int32 | Nil)) | Array(Array(Int32 | Nil) | Array(Int32)))
      self.row_size = @board_values.first.size
      self.square_size = Math.sqrt(row_size).to_i
      build_tiles
      build_rows
      build_squares
    end

    def raw
      self.rows.map do |row|
        row.tiles.map do |tile|
          tile.value
        end
      end
    end


    private def build_tiles()
      self.tiles = @board_values.map do |row_values|
        row_values.map do |tile_value|
          Tile.new(self.row_size, tile_value)
        end
      end
    end

    private def build_rows()
      self.rows = tiles.map do |row_of_tiles|
        Row.new(row_of_tiles)
      end
    end


    # 1. Break up the rows into groups of `square_size` (the height of a square)
    # 2. Break up each of those rows' tiles into groups of `square_size`
    # (the width of the square)
    # 3. Zip the groups of tiles back together so that the first
    # group of each row is together (square 1), the second group of each row's
    # tiles is together (square 2), etc.
    private def build_squares()
      self.squares = tiles.each_slice(self.square_size).map do |row_group|
        tile_groups = row_group.map do |row|
          row.each_slice(self.square_size).to_a
        end

        row_of_squares = Array(Square).new()
        square_size.times.map do |index|
          Square.new(tile_groups.map do |group|
            group[index]
          end.to_a)
        end.to_a
      end.to_a.flatten
    end
  end
end
