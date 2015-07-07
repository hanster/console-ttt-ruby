module TicTacToeConsole
  module Ui
    class InputGameType
      GAME_TYPES_PROMPT = "Game Types: \n\n"
      ENTER_GAME_TYPE_PROMPT = "Enter the game type: "
      INVALID_GAME_TYPE_PROMPT = "Invalid game type."
      attr_reader :value, :options

      def initialize(input, options)
        @input = input
        @options = options
      end

      def parse_input
        @value = convert_input_to_game_type(@input.gets)
      end

      def prompt_message
        message = GAME_TYPES_PROMPT
        options.each do |key, value|
          message += key.to_s + " - " + value + "\n"
        end
        message + "\n" + ENTER_GAME_TYPE_PROMPT
      end

      def invalid_message
        INVALID_GAME_TYPE_PROMPT
      end

      def valid?
        @options.has_key?(@value)
      end

      private

      def convert_input_to_game_type(value)
        value[/^[1-4]$/] && value.to_i
      end
    end
  end
end
