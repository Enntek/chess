# frozen_string_literal: true

# This class represents pawns in chess
class Pawn < Piece
  attr_reader :color, :unmoved, :long_reach

  def post_initialize(**args)
    @unmoved = true
    @long_reach = false
  end

  def to_s
    color == 'white' ? '♙' : '♟'
  end

  def moved
    @unmoved = false
    @long_reach = false
  end

  def generate_path_double_step
    puts "\n\t#{self.class}##{__method__}\n "
    [[0, 0], [0, 1]] # fix this, we cannot really use generate_path for this one
  end

  def generate_attack_path
    # call generate_path with pawn_attack_moves below
    generate_path(board, start_sq, end_sq, pawn_attack_moves)
  end

  private

  def predefined_moves
    [[1, 0]]
  end

  def pawn_attack_moves
    [[1, -1], [1, 1]]
  end

end

  
  # # This method, as it stands, is a lie. A person wouldn't know what
  # # this method really does. You have to rewrite Pawn#generate_path.
  # def generate_path(board, start_sq, end_sq, base_path = [[1, 0]])
  #   # p self.class, __method__
  #   # p ['base_path', base_path]
  #   # base_path = [[1, 0], [2, 0]]
  #   path = base_path.map do |sq_index|
  #     # p ['sq_index', sq_index]
  #     sq_index = invert(sq_index) if color == 'black'
  #     [start_sq[0] + sq_index[0], start_sq[1] + sq_index[1]]
  #   end

  #   # p ['path', path]
  # end