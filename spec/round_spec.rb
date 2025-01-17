require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'

RSpec.describe Round do 

    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)

  it 'exists' do 
    expect(round).to be_instance_of(Round)
  end 

  it 'has a deck' do 
    expect(round.deck).to eq(deck)
  end 

  it 'starts with no turns taken' do 
    expect(round.turns).to eq([])
  end 

  it 'starts with the first card' do 
    expect(round.current_card).to eq(card_1)
  end 

  it 'can take turn' do 
    expect(new_turn = round.take_turn("Juneau")).to eq(new_turn)
    expect(new_turn.class).to eq(Turn)
    expect(new_turn.correct?).to eq(true)
  end 

  it 'can count correct answers' do 
    new_turn = round.take_turn("Juneau")
    expect(round.number_correct).to eq(1)
  end 

  it 'still works with more turns' do 
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    new_turn = round.take_turn("Juneau")

    expect(round.current_card).to eq(card_2)
    round.take_turn("Venus")
    expect(round.turns.count).to eq(2) 
    expect(round.turns.last.feedback).to eq("Incorrect :(")
    expect(round.number_correct).to eq(1)
  end 

  it 'can tell how many correct by category' do 
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    new_turn = round.take_turn("Juneau")
    round.take_turn("Venus")

    expect(round.number_correct_by_category(:Geography)).to eq(1)
    expect(round.number_correct_by_category(:STEM)).to eq(0)
  end 

  it 'can tell percentage correct' do 
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    new_turn = round.take_turn("Juneau")
    round.take_turn("Venus")

    expect(round.percent_correct).to eq(50.0)
  end 

  it 'can tell percent correct by category' do 
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    new_turn = round.take_turn("Juneau")
    round.take_turn("Venus")

    expect(round.percent_correct_by_category(:Geography)).to eq(100.0)
    expect(round.current_card).to eq(card_3)
  end 
end 