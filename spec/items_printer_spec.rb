require 'items_printer'

describe ItemsPrinter do

  subject(:items_printer) { described_class.new(5)}
  subject(:items_printer_no_days) { described_class.new}

  context 'Initialization' do
    describe '#initialize' do
      it 'is initialized with a guven number of days' do
        expect(items_printer.days).to eq 5
      end
      it 'has default number of days eq 3' do
        expect(items_printer_no_days.days).to eq 3
      end
    end
  end
 
end
