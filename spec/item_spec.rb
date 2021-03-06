require 'item'

describe Item do

  subject(:item) { described_class.new("Justyna", 5, 50) }

  context 'Initialization' do
    describe '#initialize' do
      it 'has a name of the product' do
        expect(item.name).to eq "Justyna"
      end
      it 'has a sell_in time' do
        expect(item.sell_in).to eq 5
      end
      it 'has quality' do
        expect(item.quality).to eq 50
      end
    end
  end

  context 'Dealing with an item ' do
    describe '#show_data' do
      it 'takes the item data and put them to a string' do
        expect(item.show_data).to eq "Justyna, 5, 50"
      end
    end
  end

end
