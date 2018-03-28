require 'items_printer'

describe ItemsPrinter do

  subject(:items_printer) { described_class.new(1)}
  subject(:items_printer_no_days) { described_class.new}
  let(:vest) {double('+5 Dexterity Vest', :name => 'Vest', :sell_in => 1, :quality => 10)}
  let(:brie) {double('Aged Brie', :name => 'Aged Brie', :sell_in => 2, :quality => 0)}

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
    describe '#print_items(items, number)' do
      it 'prints information about the items' do
        allow(vest).to receive(:show_data).and_return("Vest, 1, 10")
        allow(brie).to receive(:show_data).and_return("Aged Brie, 2, 0")
        expect{items_printer.print_items([vest, brie], 1)}.to output(
          "-------- day 1 --------\n" +
          "name, sellIn, quality\n" +
          "Vest, 1, 10\nAged Brie, 2, 0\n\n"
        ).to_stdout
      end
    end
  end

end
