# Gilded Rose Refactoring Kata

This is my attempt at Gilded Rose Refactoring Kata.

## How to run the program

```plain
$ git clone https://github.com/Kotauror/GildedRose-Refactoring-Kata
$ cd GildedRose-Refactoring-Kata
```

open run.rb to change the configuration first (see the configuration paragraph below)
or just

```plain
$ cd lib
$ ruby run.rb
```

In order to see the tests:

```plain
$ rspec -fd
```

## Example of use
*(See how the values are changing)*

![Example of use](/images/screen.png)


## Approach

* I've took significant amount of time to understand what is going on in the code and how to start cleaning it up.
* I've started from:
  - deleting files that were unnecessary to the program;
  - refactoring lines which were unnecessary complicated;
  - extracting `Item` class to a separate file;
  - creating an `ItemsPrinter` class responsible for printing the output;
  - creating an `items_samples` file with all of the `Items`.
* Then I've TDD the `Item` class and `ItemsPrinter`.
* Once the classes were working, I've started to think how to clean up the huge `update_quality` method.

This is how it looked:

```ruby
def update_quality()
  @items.each do |item|
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      if item.quality > 0
        if item.name != "Sulfuras, Hand of Ragnaros"
          item.quality = item.quality - 1
        end
      end
    else
      if item.quality < 50
        item.quality = item.quality + 1
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in < 11
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
        end
      end
    end
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          if item.quality > 0
            if item.name != "Sulfuras, Hand of Ragnaros"
              item.quality = item.quality - 1
            end
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end
  end
end
```
* I've realised that the content of all of the if statements depend on the name of the `Item`. Therefore I've decided to divide the `update_quality` into smaller methods, each for one name of an `Item`.
* In order to do that I've used a case statement:

```ruby
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
```

* I've renamed the method from `update_quality` to update_data, as it is updating both quality and `sell_in`.
* Creation of many small functions made it far easier to test.

## Configuration

* In order to run the program, user need to pick desired configuration in the `run.rb` file:
  - create Items in which the user is interessted in;
  - define how many days the user is interessted in by passing an argument to the `ItemsPrinter` (by default it's 3).

```ruby
  printer = ItemsPrinter.new()
```

## Problems I've encountered

I had serious problems with stubbing attr_readers in the gilded_rose_spec. Initially all my items were meant to be doubles:

```ruby
let(:vest) {double('+5 Dexterity Vest', :name => 'Vest', :sell_in => 1, :quality => 10)}
let(:brie) {double('Aged Brie', :name => 'Aged Brie', :sell_in => 2, :quality => 0)}
let(:elixir) {double('Elixir of the Mongoose', :name => 'Elixir of the Mongoose', :sell_in => 5, :quality => 7)}
let(:sulfuras1) {double('Sulfuras, Hand of Ragnaros', :name => 'Sulfuras, Hand of Ragnaros', :sell_in => 0, :quality => 80)}
let(:sulfuras2) {double('Sulfuras, Hand of Ragnaros', :name => 'Sulfuras, Hand of Ragnaros', :sell_in => 1, :quality => 80)}
let(:backstage1) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 15, :quality => 20)}
let(:backstage2) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 10, :quality => 49)}
let(:backstage3) {double('Backstage passes', :name => 'Backstage passes to a TAFKAL80ETC concert', :sell_in => 5, :quality => 49)}
let(:cake) {double('Mana cake', :name => 'Conjured Mana Cake', :sell_in => 3, :quality => 6)}
```

Inside of my functions I was changing the `sell_in` and `quality` properties. The doubles weren't changning though. I spend almost 2 hours on googling how to stub `attr_reader` without a success.

Because of the fact, I've decided to create an `ItemDouble` class inside of the gilded_rose_spec, that was in face a mirror reflection of the `Item` class. This was I kept my `Item` class isolated and was able to avoid the `attr_reader` problem. This is how I solved it:

```ruby
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
  brie = ItemDouble.new("Aged Brie", 2, 0)
  quality_brie = ItemDouble.new("Aged Brie", 2, 50)
  elixir = ItemDouble.new("Elixir of the Mongoose", 5, 7)
  sulfuras1 = ItemDouble.new("Sulfuras, Hand of Ragnaros", 0, 80)
  sulfuras2 = ItemDouble.new("Sulfuras, Hand of Ragnaros", 0, 81)
  backstage0 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
  backstage1 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
  backstage2 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)
  backstage3 = ItemDouble.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)
  cake = ItemDouble.new("Conjured Mana Cake", 3, 6)
  cake_zero = ItemDouble.new("Conjured Mana Cake", 3, 0)
```
