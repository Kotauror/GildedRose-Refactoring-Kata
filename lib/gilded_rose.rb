class GildedRose

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_data()
    @items.each do |item|
      name = item.name
      case name
        when "Aged Brie"
          update_brie(item)
          decrease_sell_in(item)
        when "+5 Dexterity Vest"
          update_vest(item)
          decrease_sell_in(item)
        when "Elixir of the Mongoose"
          update_elixir(item)
          decrease_sell_in(item)
        when "Sulfuras, Hand of Ragnaros"
          update_sulfuras(item)
        when "Backstage passes to a TAFKAL80ETC concert"
          update_backstage(item)
          decrease_sell_in(item)
        when "Conjured Mana Cake"
          update_cake(item)
          decrease_sell_in(item)
      end
    end
  end

  def update_brie(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end
  end

  def update_vest(item)
    if item.quality > 0
      if item.sell_in > 0
        item.quality = item.quality - 1
      else
        item.quality = item.quality - 2
      end
    end
  end

  def update_elixir(item)
    if item.quality > 0
      if item.sell_in > 0
        item.quality = item.quality - 1
      else
        item.quality = item.quality - 2
      end
    end
  end

  def update_sulfuras(item)
  end

  def update_backstage(item)
    if item.sell_in == 0 then
      item.quality = 0
    elsif item.sell_in <= 5 then
      item.quality = item.quality + 3
    elsif item.sell_in <= 10 then
      item.quality = item.quality + 2
    else
      item.quality = item.quality + 1
    end
  end

  def update_cake(item)
    if item.quality > 0
      item.quality = item.quality - 2
    end
  end

  def decrease_sell_in(item)
    item.sell_in = item.sell_in - 1
  end

end
