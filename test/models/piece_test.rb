require "test_helper"

describe Piece do
  let(:piece) { Piece.new }

  it "must be valid" do
    value(piece).must_be :valid?
  end
end
