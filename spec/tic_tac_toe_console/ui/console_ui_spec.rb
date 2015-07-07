require 'spec_helper'
require 'tic_tac_toe_console/ui/console_ui'
require 'tic_tac_toe_console/board_helper'
require 'tic_tac_toe_core/board'

module TicTacToeConsole
  module Ui
    describe ConsoleUi do
      let(:output) { StringIO.new }
      let(:marker) { 'X' }

      it "keeps asking for the user to enter a move until it chooses a valid move" do
        input = StringIO.new("a\n1\n8\n")
        ui = ConsoleUi.new(input, output)
        board = BoardHelper.create_initial_board_three('XXXXXX---')
        expect(ui.prompt_for_move(board, marker)).to eq(7)
        expect(output.string).to include("Cannot make that move, try again.")
      end

      it "draws the board" do
        board = TicTacToeCore::Board.create_empty(3)
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        ui.draw_board(board)
        expect(output.string).to include("  1  |  2  |  3  \n" +
                                         "-----+-----+-----\n" +
                                         "  4  |  5  |  6  \n" +
                                         "-----+-----+-----\n" +
                                         "  7  |  8  |  9  \n")
      end

      it "draws the board" do
        board = TicTacToeCore::Board.create_empty(4)
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        ui.draw_board(board)
        expect(output.string).to include(
          "  1  |  2  |  3  |  4  \n" +
          "-----+-----+-----+-----\n" +
          "  5  |  6  |  7  |  8  \n" +
          "-----+-----+-----+-----\n" +
          "  9  | 10  | 11  | 12  \n" +
          "-----+-----+-----+-----\n" +
          " 13  | 14  | 15  | 16  \n")
      end

      it "prompts for the players type until a valid input is entered" do
        input = StringIO.new("a\n5\n2\n")
        ui = ConsoleUi.new(input, output)

        expect(ui.get_players_type).to be(2)
        expect(output.string).to include("Enter the game type: ")
        expect(output.string).to include("Invalid game type.")
      end

      it "prompts for the board type until a valid input is entered" do
        input = StringIO.new("a\n5\n3\n")
        ui = ConsoleUi.new(input, output)

        expect(ui.get_board_type).to be(3)
        expect(output.string).to include("Enter board type: ")
        expect(output.string).to include("Invalid board type.")
      end

      it "prompts to play again" do
        input = StringIO.new("a\n3\ny\n")
        ui = ConsoleUi.new(input, output)

        expect(ui.prompt_play_again?).to be true
        expect(output.string).to include("Do you want to play again?")
        expect(output.string).to include("Invalid input (y/n)")
      end

      it "returns false when the user enters n for the play again prompt" do
        input = StringIO.new("n\n")
        ui = ConsoleUi.new(input, output)

        expect(ui.prompt_play_again?).to be false
      end

      it "displays the goodbye messsage" do
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        ui.prompt_good_bye

        expect(output.string).to include("Goodbye and Thanks for playing!")
      end

      it "displays the end game message when there is a winner" do
        input = StringIO.new
        board = BoardHelper.create_initial_board_three('XXX------')
        ui = ConsoleUi.new(input, output)
        ui.draw(board, 'X')

        expect(output.string).to include(ConsoleUi::GAME_OVER_MESSAGE + 'X' + " Wins!")
      end

      it "displays the end game message for a draw" do
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        board = BoardHelper.create_initial_board_three('XOXXOXOXO')
        ui = ConsoleUi.new(input, output)
        ui.draw(board, 'X')

        expect(output.string).to include(ConsoleUi::GAME_OVER_MESSAGE + ConsoleUi::TIE_MESSAGE)
      end
    end
  end
end
