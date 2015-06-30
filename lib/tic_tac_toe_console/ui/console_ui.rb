require 'tic_tac_toe_core/board'
require 'tic_tac_toe_console/ui/input_move'
require 'tic_tac_toe_console/ui/input_board'
require 'tic_tac_toe_console/ui/input_new_game'
require 'tic_tac_toe_console/ui/input_game_type'

module TicTacToeConsole
  module Ui
    class ConsoleUi
      GOODBYE_MESSAGE = "Goodbye and Thanks for playing!"
      ANSI_CLS = "\u001b[2J"
      ANSI_HOME = "\u001b[H"
      INDEX_OFFSET = InputMove::INDEX_OFFSET
      CELL_WIDTH = 5
      VERTICAL_SEP = '|'
      HORIZONTAL_SEP = '-'
      CROSS_JOIN = '+'
      GAME_OVER_MESSAGE = "Game Over\n\n"
      WINNER_MESSAGE = "%s wins!"
      DRAW_MESSAGE = "It's a draw!"

      def initialize(input = STDIN, output = STDOUT)
        @input = input
        @output = output
      end

      def display_message(message)
        @output.puts message
      end

      def display_end_game_message(end_game_state)
        if end_game_state == TicTacToeCore::Board::DRAW
          message = DRAW_MESSAGE
        else
          message = WINNER_MESSAGE % end_game_state
        end
        display_message(GAME_OVER_MESSAGE + message)
      end

      def draw_board(board)
        new_empty_line
        display_message(make_board_representation(board))
        new_empty_line
      end

      def new_empty_line
        @output.puts
      end

      def clear_screen
        @output.print(ANSI_CLS + ANSI_HOME)
      end

      def prompt_good_bye
        display_message(GOODBYE_MESSAGE)
      end

      def prompt_for_input(inputter)
        loop do
          display_message(inputter.prompt_message)
          inputter.parse_input
          return inputter.value if inputter.valid?
          display_message(inputter.invalid_message)
        end
      end

      def prompt_for_move(board, marker)
        prompt_for_input(InputMove.new(@input, marker, board))
      end

      def prompt_board_type(options)
        prompt_for_input(InputBoard.new(@input, options))
      end

      def prompt_game_type(options)
        prompt_for_input(InputGameType.new(@input, options))
      end

      def prompt_play_again?
        prompt_for_input(InputNewGame.new(@input))
      end

      private

      def make_board_representation(board)
        board_positions = offset_indices(board)
        center_positions = center_positions(board_positions)
        rows = split_positions_into_rows(center_positions, board.dimension)
        horizon_sep = join_columns(rows)
        join_rows(horizon_sep, board)
      end

      def offset_indices(board)
        board.all_moves.map do |move|
          board.move_available?(move) ? move + INDEX_OFFSET : board.marker_at_position(move)
        end
      end

      def join_rows(rows, board)
        rows.join(row_seperator(board))
      end

      def join_columns(rows)
        rows.map do |row|
          row.join(VERTICAL_SEP)
        end
      end

      def split_positions_into_rows(positions, row_length)
        positions.each_slice(row_length).to_a
      end

      def center_positions(positions)
        positions.map do |position|
          position.to_s.center(CELL_WIDTH)
        end
      end

      def row_seperator(board)
        columns = Array.new(board.dimension, HORIZONTAL_SEP * CELL_WIDTH)
        "\n" + columns.join(CROSS_JOIN) + "\n"
      end
    end
  end
end
