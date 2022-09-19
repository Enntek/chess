# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# This creates moves in chess
class Move
  attr_reader :current_player, :board

  def test; end

  # Array of all 64 squares in index notation
  def board_squares
    squares = []
    8.times do |x|
      8.times do |y|
        squares << [x, y]
      end
    end
    squares
  end

  def initialize(**args)
    @current_player = args[:current_player] || Player.new
    @board = args[:board] || Board.new
    move_sequence # rename?
  end

  def move_sequence # rename?
    start_sq, end_sq = input_move
    transfer_piece(start_sq, end_sq)
  end

  def input_move
    # start_sq = gets.chomp.split('').map(&:to_i)
    # end_sq = gets.chomp.split('').map(&:to_i)
    # return
    
    loop do
      Display.input_start_msg
      start_sq = gets.chomp.split('').map(&:to_i)
      Display.input_end_msg
      end_sq = gets.chomp.split('').map(&:to_i)
      return [start_sq, end_sq] if valid?(start_sq, end_sq)

      Display.invalid_input_message
    end
  end

  def board_object(position_arr)
    board.grid[position_arr[0]][position_arr[1]]
  end

  # fetch uses value for lookup -> .fetch(value, dft)
  # dig uses (index), will not raise error, returns nil on no match

  def valid?(start_sq, end_sq)

    board_obj = board_object(start_sq)
    return false unless board_squares.include?(start_sq) && board_squares.include?(end_sq) # both inputs must be on the board
    return false if board_obj == 'unoccupied' # board sq must not be empty
    return false if board_obj.color != current_player.color # piece must be player's own
    
    return false unless reachable?(start_sq, end_sq) # false if piece cannot reach end square
    
    # return false unless capturable?(start_sq, end_sq) # include result of reachable somehow
    # return false if path_blocked?(start_sq, end_sq)

    true

  end

  def reachable?(start_sq, end_sq)
    piece = board_object(start_sq)

    reachable_squares = piece.generate_path(start_sq, end_sq, piece.color, board_squares)

    puts 'legal move!' if reachable_squares.include?(end_sq)
    reachable_squares.include?(end_sq) ? true : false
  end

  # two types of valid moves:
  # both are identical, except for pawns
  # valid move: end_sq is capturable + path_not_blocked
  # also valid: end_sq is reachable + path_not_blocked

  # you need all 3 methods:
  # reachable?
  # path_blocked?
  # capturable?

  # check if any piece objects (non-capturable) blocking path to end_sq
  def capturable?(start_sq, end_sq, reachable = nil)
    own_obj = board_object(start_sq)
    other_obj = board_object(end_sq)
    return false if other_obj == 'unoccupied'
    return false if own_obj.color == other_obj.color
    return true unless own_obj.instance_of?(Pawn)
    # return reachable || reachable?(start_sq, end_sq) unless own_obj.instance_of?(Pawn)
    # puts own_obj.color
    true
  end

  # def pawn_captures(pawn, )

  # end

  # later use knight_moves algo for path lookup, find first object in path
  def path_blocked?(start_sq, end_sq)
    piece = board_object(start_sq)
    path = piece.simple_path(start_sq, piece.color, board_squares)

    p path

    false
  end

  def transfer_piece(start_sq, end_sq)
    piece = board_object(start_sq)
    piece.moved
    board.update_square(end_sq, piece)
    board.update_square(start_sq, 'unoccupied')
  end
end
