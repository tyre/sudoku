require "./tile"
require "./row"
require "./square"

module Sudoku
  module Components
    class Board
      property! rows : Array(Row)
      property! columns : Array(Column)
      property! tiles_in_rows : Array(Array(Tile))
      property! tiles : Array(Tile)
      property! squares : Array(Square)
      property! row_size : Int32
      property! square_size : Int32

      # A nil array member indicates an unknown or "blank" tile
      def initialize(@board_values : Array(Array(Int32 | Nil)) | Array(Array(Nil) | Array(Int32) | Array(Int32 | Nil)) | Array(Array(Int32 | Nil) | Array(Int32)) | Array(Array(Int32 | Nil) | Array(Nil)))
        self.row_size = @board_values.first.size
        self.square_size = Math.sqrt(row_size).to_i
        build_tiles
        build_rows
        build_columns
        build_squares
      end

      def values
        tiles.map { |tile| tile.value }
      end

      def valid?
        rows.all? { |row| row.valid? }
        columns.all? { |column| column.valid? }
        squares.all? { |square| square.valid? }
      end

      def solved?
        unsolved_tiles.none?
      end

      def unsolved_tiles
        tiles.select { |tile| !tile.value? }
      end

      private def build_tiles
        self.tiles_in_rows = @board_values.map do |row_values|
          row_values.map do |tile_value|
            Tile.new(self.row_size, tile_value)
          end
        end
        self.tiles = tiles_in_rows.flatten
      end

      private def build_rows
        self.rows = tiles_in_rows.map do |row_of_tiles|
          Row.new(row_of_tiles)
        end
      end

      private def build_columns
        columns_acc = Array(Column).new
        self.columns = self.row_size.times.reduce(columns_acc) do |columns_acc, index|
          column_tiles = self.rows.map { |row| row.tiles[index] }
          columns_acc << Column.new(column_tiles)
        end
      end

      # 1. Break up the rows into groups of `square_size` (the height of a square)
      # 2. Break up each of those rows' tiles into groups of `square_size`
      # (the width of the square)
      # 3. Zip the groups of tiles back together so that the first
      # group of each row is together (square 1), the second group of each row's
      # tiles is together (square 2), etc.
      private def build_squares
        self.squares = self.tiles_in_rows.each_slice(self.square_size).map do |row_group|
          tile_groups = row_group.map do |row|
            row.each_slice(self.square_size).to_a
          end

          row_of_squares = Array(Square).new
          square_size.times.map do |index|
            Square.new(tile_groups.map do |group|
              group[index]
            end.to_a)
          end.to_a
        end.to_a.flatten
      end
    end
  end
end
