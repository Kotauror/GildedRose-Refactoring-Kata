require 'items_printer'

describe ItemsPrinter do

  subject(:items_printer) { described_class.new(5)}

  context 'Initialization' do
    describe '#initialize' do
      it 'is initialized with a number of days' do
        expect(items_printer.days).to eq 5
      end
    end
  end

end
