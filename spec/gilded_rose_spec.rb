require 'gilded_rose'

describe GildedRose do

  let(:vest) {double('+5 Dexterity Vest', :name => 'Vest', :sell_in => 1, :quality => 10)}
  let(:vest_0_s) {double('+5 Dexterity Vest', :name => 'Vest', :sell_in => 0, :quality => 10)}
  let(:vest_0_q) {double('+5 Dexterity Vest', :name => 'Vest', :sell_in => 10, :quality => 10)}
  let(:brie) {double('Aged Brie', :name => 'Aged Brie', :sell_in => 2, :quality => 0)}
  let(:quality_brie) {double('Aged Brie', :name => 'Aged Brie', :sell_in => 2, :quality => 50)}
  let(:quality_brie) {double('Aged Brie', :name => 'Aged Brie', :sell_in => 2, :quality => 50)}
  let(:elixir) {double('Elixir of the Mongoose', :name => 'Elixir of the Mongoose', :sell_in => 5, :quality => 7)}
  let(:elixir_0_s) {double('Elixir of the Mongoose', :name => 'Elixir of the Mongoose', :sell_in => 0, :quality => 7)}
  let(:elixir_0_q) {double('Elixir of the Mongoose', :name => 'Elixir of the Mongoose', :sell_in => 0, :quality => 0)}
  let(:backstage0) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 0, :quality => 20)}
  let(:backstage1) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 15, :quality => 20)}
  let(:backstage2) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 10, :quality => 49)}
  let(:backstage3) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 5, :quality => 49)}
  let(:cake) {double('Mana cake', :name => 'Conjured Mana Cake', :sell_in => 3, :quality => 6)}
  let(:cake_0) {double('Mana cake', :name => 'Conjured Mana Cake', :sell_in => 3, :quality => 0)}

  subject(:rose) { described_class.new([vest, brie, elixir, backstage1, backstage2, backstage3, cake]) }

  context 'Initialization' do
    describe '#initialize' do
      it 'is initialized with an array of items' do
        expect(rose.items).to eq [vest, brie, elixir, backstage1, backstage2, backstage3, cake]
      end
    end
  end

  context 'Updating quality' do
    describe 'update_brie' do
      it 'updates the quality of the brie when its less than 50' do
        expect(brie).to receive(:quality=).with(1)
        rose.update_brie(brie)
      end
      it 'doesnt update quality of brie when its already 50' do
        expect(quality_brie).not_to receive(:quality=).with(1)
        rose.update_brie(quality_brie)
      end
    end
    describe 'update_vest' do
      it 'decreases the quality of vest by 1 when sell_in > 0' do
        expect(vest).to receive(:quality=).with(9)
        rose.update_vest(vest)
      end
      it 'decreases the quality of vest by 2 when sell_in == 0' do
        expect(vest_0_s).to receive(:quality=).with(8)
        rose.update_vest(vest_0_s)
      end
      it 'doesnt decrease the quality if its 0' do
        expect(vest_0_q).not_to receive(:quality=).with(0)
        rose.update_vest(vest_0_q)
      end
    end
    describe 'update_elixir' do
      it 'decreases the quality of elixir by 1 when sell_in > 0' do
        expect(elixir).to receive(:quality=).with(6)
        rose.update_elixir(elixir)
      end
      it 'decreases the quality of elixir by 2 when sell_in == 0' do
        expect(elixir_0_s).to receive(:quality=).with(5)
        rose.update_elixir(elixir_0_s)
      end
      it 'doesnt decrease the quality if its 0' do
        expect(elixir_0_q).not_to receive(:quality=).with(0)
        rose.update_elixir(elixir_0_q)
      end
    end
    describe 'update_backstage' do
      it 'decreases the quality to 0 when sell_in == 0' do
        expect(backstage0).to receive(:quality=).with(0)
        rose.update_backstage(backstage0)
      end
      it 'increases the quality by 2 when sell_in <= 10' do
        expect(backstage2).to receive(:quality=).with 51
        rose.update_backstage(backstage2)
      end
      it 'increases the quality by 3 when sell_in <= 5' do
        expect(backstage3).to receive(:quality=).with 52
        rose.update_backstage(backstage3)
      end
      it 'increases the quality by 1in other cases' do
        expect(backstage1).to receive(:quality=).with 21
        rose.update_backstage(backstage1)
      end
    end
    describe 'update_cake' do
      it 'decreases the quality by 2' do
        expect(cake).to receive(:quality=).with 4
        rose.update_cake(cake)
      end
      it 'doesnt decrease the quality if its 0' do
        expect(cake_0).not_to receive(:quality=).with 0
        rose.update_cake(cake_0)
      end
    end
  end

  context 'updating sell_in date' do
    describe '#decrease_sell_in' do
      it 'decreases the sell_in by 1' do
        expect(vest).to receive(:sell_in=).with 0
        rose.decrease_sell_in(vest)
      end
    end
  end

end
