module Sudoku
  class Square
    property! tiles : Array(Array(Tile))
    property! all_possiblities : Set(Int32)

    def initialize(@tiles : Array(Array(Tile)))
      @all_possiblities = (1..(self.tiles.size ** 2)).to_set
      self.tiles.each do |row_of_tiles|
        row_of_tiles.each { |tile| tile.square = self }
      end
    end

    def contains?(value : Int32)
      self.tiles.any? do |row_of_tiles|
        row_of_tiles.any? { |tile| tile.value == value }
      end
    end

    def solved?
      self.tiles.all? do |row_of_tiles|
        row_of_tiles.all? { |tile| tile.solved? }
      end
    end

    def tile_values
      self.tiles.reduce(Array(Int32?).new()) do |values, row_of_tiles|
        row_of_tiles.each { |tile| values << tile.value }
        values
      end
    end

    def possibilities
      self.all_possiblities - tile_values.compact.to_set
    end
  end
end
