module Sudoku
  class Tile

    property! possibilities : Set(Int32)
    property value : Int32?

    def initialize(board_size : Int32, @value)
      if value?
        self.possibilities = Set(Int32).new
      else
        self.possibilities = (1..board_size).to_set
      end
    end

    def remove_possibility(value)
      possibilities.delete(value)
    end

    def value?
      @value
    end

    def to_s(io)
      io << "Tile:"
      if value?
        io << " [#{self.value}]"
      else
        io << " #{self.possibilities.to_a}"
      end
    end
  end
end