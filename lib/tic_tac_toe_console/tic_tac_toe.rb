require 'tic_tac_toe_core/game_setup'
require 'tic_tac_toe_console/ui/console_ui'

module TicTacToeConsole
  class TicTacToe
    def initialize(ui, game_setup)
      @ui = ui
      @game_setup = game_setup
    end

    def run
      loop do
        game = @game_setup.choose_game_type
        game.run
        break unless @ui.prompt_play_again?
      end
      @ui.prompt_good_bye
    end
  end
end
