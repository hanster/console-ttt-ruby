module TicTacToeConsole
  module Ui
    class InputBoard
      BOARD_TYPES_PROMPT = "Board Types: \n\n"
      BOARD_TYPE_PROMPT = "Enter board type: "
      INVALID_BOARD_TYPE_PROMPT = "Invalid board type."
      VALID_BOARD_INPUTS = [3, 4]
      attr_reader :value, :options

      def initialize(input, options)
        @input = input
        @options = options
      end

      def parse_input
        @value = convert_input_to_board_type(@input.gets)
      end

      def prompt_message
        message = BOARD_TYPES_PROMPT
        options.each do |key, value|
          message += key.to_s + " - " + value + "\n"
        end
        message + "\n" + BOARD_TYPE_PROMPT
      end

      def invalid_message 
        INVALID_BOARD_TYPE_PROMPT
      end

      def valid?
        options.has_key?(@value)
      end

      private 

      def convert_input_to_board_type(value)
        value[/^[3-4]$/] && value.to_i
      end
    end
  end
end
