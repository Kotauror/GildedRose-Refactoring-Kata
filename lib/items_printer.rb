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
    #   items.each do |item|
    #     puts item
    #   end
    #   puts ""
    #   gilded_rose.update_quality
    #   days += 1
    end
  end

end


# puts "OMGHAI!"
# items = [
#   Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
#   Item.new(name="Aged Brie", sell_in=2, quality=0),
#   Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
#   Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
#   Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
#   Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
#   Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
#   Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
#   # This Conjured item does not work properly yet
#   Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
# ]
