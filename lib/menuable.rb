# frozen_string_literal: true

# This module provides the menu for chess
module Menuable
  private

  def start_menu
    start_input = gets.chomp
    # start_input = '1' # auto new game

    case start_input
    when '1'
      display.draw_board(board)
      puts "\nA new game has started!".magenta ###
    when '2'
      load_game_file
      press_any_key
    end
  end

  def midgame_menu
    puts menu_options
    menu_input = gets.chomp.downcase # add validation

    case menu_input
    when '1'
      save_from_menu
      save_game_file
    when '2'
      load_game_file
    when '3'
      view_move_list_from_menu
      puts move_list.all_moves.join(', ').magenta
      puts ' '
      'move_list'
    when '4'
      help_from_menu
      'help'
    when '5'
      exit_from_menu
    end
    press_any_key
    Display.draw_board(board)
  end

  def menu_options
    <<~HEREDOC
      \n\tMenu Options
      \t#{"1. Save Game"}.red
      \t2. Load Game
      \t3. View Move List
      \t4. Help
      \t5. Exit
    HEREDOC
  end

  def greeting
    puts "\n\t\tWelcome to chess!\n ".red
    puts "\t\tSelect an option:".green
    puts "\t\t1. New Game"
    puts "\t\t2. Load game"
    # puts "\n\t\tWelcome to chess!\n ".red
    # puts "\t\tSelect an option:".green
    # puts "\t\t1. New Game"
    # puts "\t\t2. Load game"
  end

  def save_from_menu
    puts 'Game has been saved!'
  end

  def view_move_list_from_menu
    puts "\nHere is the move list:".blue
  end

  def help_from_menu
    puts "\nHelp:"
    puts 'To input a move you may use any of the following notation:'.blue
    puts 'a2a4 | a2 to a4 | a2-a4 | a2 - a4'.red
  end

  def exit_from_menu
    puts 'Oh, okay. See you next time!'
    exit
  end

  def press_any_key
    puts 'Press any key to continue'.green
    gets
    nil
  end
end
