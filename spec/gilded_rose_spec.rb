require 'gilded_rose'

class ItemDouble

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def show_data
    "#{@name}, #{@sell_in}, #{@quality}"
  end

end

describe GildedRose do

  vest = ItemDouble.new("+5 Dexterity Vest", 1, 10)
  vest_0_s = ItemDouble.new("+5 Dexterity Vest", 0, 10)
  vest_0_q = ItemDouble.new("+5 Dexterity Vest", 10, 0)
  brie = ItemDouble.new("Aged Brie", 2, 0)
  quality_brie = ItemDouble.new("Aged Brie", 2, 50)
  elixir = ItemDouble.new("Elixir of the Mongoose", 5, 7)
  elixir_zero = ItemDouble.new("Elixir of the Mongoose", 0, 7)
  elixir_zero_q = ItemDouble.new("Elixir of the Mongoose", 7, 0)
  sulfuras1 = ItemDouble.new("Sulfuras, Hand of Ragnaros", 0, 80)
  sulfuras2 = ItemDouble.new("Sulfuras, Hand of Ragnaros", 0, 81)
  backstage0 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
  backstage1 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
  backstage2 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)
  backstage3 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)
  cake = ItemDouble.new("Conjured Mana Cake", 3, 6)
  cake_zero = ItemDouble.new("Conjured Mana Cake", 3, 0)

  # let(:vest) {double('+5 Dexterity Vest', :name => 'Vest', :sell_in => 1, :quality => 10)}
  # let(:brie) {double('Aged Brie', :name => 'Aged Brie', :sell_in => 2, :quality => 0)}
  # let(:elixir) {double('Elixir of the Mongoose', :name => 'Elixir of the Mongoose', :sell_in => 5, :quality => 7)}
  # let(:sulfuras1) {double('Sulfuras, Hand of Ragnaros', :name => 'Sulfuras, Hand of Ragnaros', :sell_in => 0, :quality => 80)}
  # let(:sulfuras2) {double('Sulfuras, Hand of Ragnaros', :name => 'Sulfuras, Hand of Ragnaros', :sell_in => 1, :quality => 80)}
  # let(:backstage1) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 15, :quality => 20)}
  # let(:backstage2) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 10, :quality => 49)}
  # let(:backstage3) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 5, :quality => 49)}
  # let(:cake) {double('Mana cake', :name => 'Conjured Mana Cake', :sell_in => 3, :quality => 6)}

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
      it 'updates the quality of the brie when its less than 50' do
        rose.update_brie(brie)
        expect(brie.quality).to eq 1
      end
      it 'doesnt update quality of brie when its already 50' do
        rose.update_brie(quality_brie)
        expect(quality_brie.quality).to eq 50
      end
    end
    describe 'update_vest' do
      it 'decreases the quality of vest by 1 when sell_in > 0' do
        rose.update_vest(vest)
        expect(vest.quality).to eq 9
      end
      it 'decreases the quality of vest by 2 when sell_in == 0' do
        rose.update_vest(vest_0_s)
        expect(vest_0_s.quality).to eq 8
      end
      it 'doesnt decrease the quality if its 0' do
        rose.update_vest(vest_0_q)
        expect(vest_0_q.quality).to eq 0
      end
    end
    describe 'update_elixir' do
      it 'decreases the quality of elixir by 1 when sell_in > 0' do
        rose.update_elixir(elixir)
        expect(elixir.quality).to eq 6
      end
      it 'decreases the quality of elixir by 1 when sell_in == 0' do
        rose.update_elixir(elixir_zero)
        expect(elixir_zero.quality).to eq 5
      end
      it 'doesnt decrease the quality if its 0' do
        rose.update_elixir(elixir_zero_q)
        expect(elixir_zero_q.quality).to eq 0
      end
    end
    describe 'update_backstage' do
      it 'decreases the quality to 0 when sell_in == 0' do
        rose.update_backstage(backstage0)
        expect(backstage0.quality).to eq 0
      end
      it 'increases the quality by 2 when sell_in <= 10' do
        rose.update_backstage(backstage2)
        expect(backstage2.quality).to eq 51
      end
      it 'increases the quality by 3 when sell_in <= 5' do
        rose.update_backstage(backstage3)
        expect(backstage3.quality).to eq 52
      end
      it 'increases the quality by 1in other cases' do
        rose.update_backstage(backstage1)
        expect(backstage1.quality).to eq 21
      end
    end
    describe 'update_cake' do
      it 'decreases the quality by 2' do
        rose.update_cake(cake)
        expect(cake.quality).to eq 4
      end
      it 'doesnt decrease the quality if its 0' do
        rose.update_cake(cake_zero)
        expect(cake_zero.quality).to eq 0
      end
    end
  end

  context 'updating sell_in date' do
    describe '#decrease_sell_in' do
      it 'decreases the sell_in by 1' do
        rose.decrease_sell_in(vest)
        expect(vest.sell_in).to eq 0
      end
    end
  end

end
