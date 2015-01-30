require 'card'

describe Card do

  let(:card) {Card.new(:hearts, :two)}

  it 'should have a suit' do
    expect(card.suit).to eq(:hearts)
  end

  it 'should have a value' do
    expect(card.name).to eq(:two)
  end

  it 'should map card face to point value' do
    expect(card.point_value).to eq(2)
  end


end
