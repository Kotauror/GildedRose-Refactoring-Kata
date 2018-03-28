require_relative 'gilded_rose'
require_relative 'item'

class ItemsPrinter

  attr_reader :days

  def initialize(days = 3)
    @days = days
  end

  def print_items(items)
    days = @days
    (0...days).each do |day|
      puts "-------- day #{day} --------"
      puts "name, sellIn, quality"
      items.each do |item|
        puts item.show_data
      end
      puts ""
      # update quality somewhere here
    end
  end

end
