require 'spec_helper'
require 'tic_tac_toe_core/board'

module TicTacToeConsole
  class BoardHelper
    def self.create_initial_board_three(layout)
      TicTacToeCore::Board.new(3, layout.split(''))
    end
  
    def self.create_initial_board_four(layout)
      TicTacToeCore::Board.new(4, layout.split(''))
    end
  end
end
