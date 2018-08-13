require "../**"

module Sudoku
  module Helpers
    class PrettyPrinter
      def self.puts(board : Sudoku::Components::Board)
        puts "\n#{format(board)}\n\n"
      end

      def self.format(board : Sudoku::Components::Board)
        break_points = [board.square_size - 1, (board.square_size * 2 - 1)]
        board.rows.each.with_index.map do |row_and_index|
          row = row_and_index.first
          index = row_and_index.last
          if break_points.includes?(index)
            "#{format(row)}\n"
          else
            "#{format(row)}"
          end
        end.join("\n")
      end

      def self.format(row : Sudoku::Components::Row)
        "[ #{formatted_row_values(row)} ]"
      end

      def self.format(tile : Sudoku::Components::Tile)
        if tile.value.nil?
          "_"
        else
          "#{tile.value}"
        end
      end

      private def self.formatted_row_values(row : Sudoku::Components::Row)
        break_points = [row.square_size - 1, (row.square_size * 2 - 1)]
        row.tiles.each.with_index.map do |tile_and_index|
          tile = tile_and_index.first
          index = tile_and_index.last
          if break_points.includes?(index)
            "#{format(tile)} | "
          else
            "#{format(tile)}"
          end
        end.join(" ")
      end
    end
  end
end
