require_relative 'gilded_rose'
require_relative 'item'

class ItemsPrinter

  attr_reader :days

  def initialize(days = 3)
    @days = days
  end

  def print_items(rose)
    days = @days
    (0...days).each do |day|
      puts "-------- day #{day} --------"
      puts "name, sellIn, quality"
      rose.items.each do |item|
        puts item.show_data
      end
      puts ""
      rose.update_data
    end
  end

end
