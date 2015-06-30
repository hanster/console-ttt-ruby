module TicTacToeConsole
  module Ui
    class InputBoard
      BOARD_TYPE_PROMPT = "Enter board type: "
      INVALID_BOARD_TYPE_PROMPT = "Invalid board type."
      VALID_BOARD_INPUTS = [1, 2, 3]
      attr_reader :value, :options

      def initialize(input, options)
        @input = input
        @options = options
      end

      def parse_input
        @value = convert_input_to_board_type(@input.gets)
      end

      def prompt_message
        options + "\n" + BOARD_TYPE_PROMPT
      end

      def invalid_message 
        INVALID_BOARD_TYPE_PROMPT
      end

      def valid?
        VALID_BOARD_INPUTS.include?(@value)
      end

      private 

      def convert_input_to_board_type(value)
        value[/^[1-3]$/] && value.to_i
      end
    end
  end
end
