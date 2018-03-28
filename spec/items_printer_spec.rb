require 'items_printer'

describe ItemsPrinter do

  subject(:items_printer) { described_class.new(1)}
  subject(:items_printer_no_days) { described_class.new}
  items = ["Justyna", 1, 2]

  context 'Initialization' do
    describe '#initialize' do
      it 'is initialized with a guven number of days' do
        expect(items_printer.days).to eq 1
      end
      it 'has default number of days eq 3' do
        expect(items_printer_no_days.days).to eq 3
      end
    end
  end

  context 'Printing Items' do
    describe '#print_items(items)' do
      it 'prints information about the items' do
        expect{items_printer.print_items(items)}.to output(
          "-------- day 0 --------\n" +
          "name, sellIn, quality\n"
        ).to_stdout
      end
    end
  end



end



# "+5 Dexterity Vest, 10, 20\n" +
# 'Aged Brie, 2, 0' +
# 'Elixir of the Mongoose, 5, 7' +
# 'Sulfuras, Hand of Ragnaros, 0, 80' +
# 'Sulfuras, Hand of Ragnaros, -1, 80' +
# 'Backstage passes to a TAFKAL80ETC concert, 15, 20' +
# 'Backstage passes to a TAFKAL80ETC concert, 10, 49' +
# 'Backstage passes to a TAFKAL80ETC concert, 5, 49' +
# 'Conjured Mana Cake, 3, 6'
