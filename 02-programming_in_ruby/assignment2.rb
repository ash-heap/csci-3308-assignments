# File: assignment.rb
# Written: 09/12/2013.255 - Michael R. Shannon
#






# Part 1 - Classes

## a) Dessert Class

### code
class Dessert
  def initialize(name, calories)
    @name = name
    @calories = calories
  end
  attr_accessor :name, :calories
  def healthy?
    @calories < 200
  end
  def delicious?
    true
  end
end

### tests
cake      = Dessert.new('Cake', 400)
apple     = Dessert.new('Apple', 100)
ice_cream = Dessert.new('Ice Cream', 300)
yogurt    = Dessert.new('Yogurt', 150)
raise unless cake.delicious?      && !cake.healthy?
raise unless apple.delicious?     && apple.healthy?
raise unless ice_cream.delicious? && !ice_cream.healthy?
raise unless yogurt.delicious?    && yogurt.healthy?



