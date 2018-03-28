require 'gilded_rose'

describe GildedRose do

  let(:vest) {double('+5 Dexterity Vest', :name => 'Vest', :sell_in => 1, :quality => 10)}
  let(:brie) {double('Aged Brie', :name => 'Aged Brie', :sell_in => 2, :quality => 0)}
  let(:elixir) {double('Elixir of the Mongoose', :name => 'Elixir of the Mongoose', :sell_in => 5, :quality => 7)}
  let(:sulfuras1) {double('Sulfuras, Hand of Ragnaros', :name => 'Sulfuras, Hand of Ragnaros', :sell_in => 0, :quality => 80)}
  let(:sulfuras2) {double('Sulfuras, Hand of Ragnaros', :name => 'Sulfuras, Hand of Ragnaros', :sell_in => 1, :quality => 80)}
  let(:backstage1) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 15, :quality => 20)}
  let(:backstage2) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 10, :quality => 49)}
  let(:backstage3) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 5, :quality => 49)}
  let(:cake) {double('Mana cake', :name => 'Conjured Mana Cake', :sell_in => 3, :quality => 6)}

  subject(:rose) { described_class.new([vest, brie, elixir, sulfuras1, sulfuras2, backstage1, backstage2, backstage3, cake]) }

  context 'Initialization' do
    describe '#initialize' do
      it 'is initialized with an array of items' do
        expect(rose.items).to eq [vest, brie, elixir, sulfuras1, sulfuras2, backstage1, backstage2, backstage3, cake]
      end
    end
  end

  context 'Updating quality' do
    describe 'update_brie' do
      it 'updates the quality of the brie' do
        # allow(brie).to receive(:quality).and_return 1
        rose.update_brie(brie)
        expect(brie.quality).to eq 1
      end
    end
  end

end
