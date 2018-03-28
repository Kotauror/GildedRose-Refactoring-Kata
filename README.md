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

## If I had more time

I would create separate classes for each type of object. Each one of them would have an update method, characteristic for this particular class.
