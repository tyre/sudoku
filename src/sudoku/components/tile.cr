require "./square"
require "./row"
require "./column"

module Sudoku
  module Components
    class Tile
      property! possibilities : Set(Int32)
      property value : Int32?
      property square : Square?
      property row : Row?
      property column : Column?

      def initialize(@board_size : Int32, @value : Int32?)
        reset_possibilities
      end

      def reset_possibilities
        if value?
          self.possibilities = Set(Int32).new
        else
          self.possibilities = (1..@board_size).to_set
        end
      end

      def remove_possibility(value)
        possibilities.delete(value)
      end

      def remove_possibilities(values : Set(Int32))
        self.possibilities -= values
      end

      def value?
        !!@value
      end

      def value=(new_value)
        if self.value
          raise "Already have value set at #{self.value}! Not setting to #{new_value}"
        end
        @value = new_value
      end
    end
  end
end
