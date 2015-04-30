class Piece < ActiveRecord::Base
  validate :valid_piece_names
  belongs_to :user
  belongs_to :game

  scope :kings, -> { where(:type => 'King') }
  scope :queens, -> { where(:type => 'Queen') }
  scope :bishops, -> { where(:type => 'Bishop') }
  scope :knights, -> { where(:type => 'Knight') }
  scope :rooks, -> { where(:type => 'Rook') }
  scope :pawns, -> { where(:type => 'Pawn') }

  def valid_piece_names
    return if %w(King Queen Bishop Knight Rook Pawn).include?(type)
    errors.add(:type, 'must be one of King, Queen, Bishop, Knight, Rook, Pawn')
  end

  def as_json(options = {})
    super(options).merge(:type => self.type, :glyph => glyph)
  end

  def glyph
    self.type.downcase
  end

  def on_board?(x, y)
    (0..7).include?(x) && (0..7).include?(y)
  end
end
