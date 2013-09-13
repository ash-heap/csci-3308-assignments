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
cake      = Dessert.new('Cake'     , 400)
apple     = Dessert.new('Apple'    , 100)
ice_cream = Dessert.new('Ice Cream', 300)
yogurt    = Dessert.new('Yogurt'   , 150)
raise unless cake.delicious?      && !cake.healthy?
raise unless apple.delicious?     && apple.healthy?
raise unless ice_cream.delicious? && !ice_cream.healthy?
raise unless yogurt.delicious?    && yogurt.healthy?



## b) JellyBean Class

### code
class JeyllyBean < Dessert
  def initialize(name, calories, flavor)
    @flavor = flavor
    super(name, calories)
  end
  attr_accessor :flavor
  def delicious?
    return false if self.flavor.downcase == "black licorice"
    super
  end
end

### tests
red     = JeyllyBean.new('Jelly Bean',  50,            'red')
green   = JeyllyBean.new('Jelly Bean', 100,          'green')
blue    = JeyllyBean.new('Jelly Bean', 150,           'blue')
cyan    = JeyllyBean.new('Jelly Bean', 200,           'cyan')
yellow  = JeyllyBean.new('Jelly Bean', 250,         'yellow')
magenta = JeyllyBean.new('Jelly Bean', 300,        'magenta')
black1  = JeyllyBean.new('Jelly Bean', 350, 'Black Licorice')
black2  = JeyllyBean.new('Jelly Bean', 150, 'black licorice')
raise unless red.delicious?     && red.healthy?
raise unless green.delicious?   && green.healthy?
raise unless blue.delicious?    && blue.healthy?
raise unless cyan.delicious?    && !cyan.healthy?
raise unless yellow.delicious?  && !yellow.healthy?
raise unless magenta.delicious? && !magenta.healthy?
raise unless !black1.delicious? && !black1.healthy?
raise unless !black2.delicious? && black2.healthy?






# Part 2 - Object Oriented Programming

### code
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s
    attr_reader attr_name
    class_eval %Q"
      def #{attr_name}_history
        return (@#{attr_name}_history = [nil]) unless defined? @#{attr_name}_history
        @#{attr_name}_history
      end
      def #{attr_name}=(new_value)
        @#{attr_name}_history = self.#{attr_name}_history + (@#{attr_name} = [new_value])
      end"
  end
end



### tests
class SomeClass
  attr_accessor_with_history :value_a
  attr_accessor_with_history :value_b
end
some_object = SomeClass.new
raise unless some_object.value_a_history == [nil]
some_object.value_a = 1
raise unless some_object.value_a_history == [nil, 1]
some_object.value_a = 2
raise unless some_object.value_a_history == [nil, 1, 2]
some_object.value_b = 3
raise unless some_object.value_b_history == [nil, 3]
some_object.value_b = :hello
raise unless some_object.value_b_history == [nil, 3, :hello]
some_object.value_b = "world"
raise unless some_object.value_b_history == [nil, 3, :hello, "world"]






# Part 3 - More OOP

## a) Currency Conversion

### code
class Numeric
  def method_missing(method_id)
    return Currency.new(self, method_id) if Currency.unit?(method_id)
    super
  end
end

class Symbol
  def singular
    self.to_s.gsub(/s$/, "").to_sym
  end
end

class InvalidCurrencyUnit < StandardError ; end
class Currency
  def initialize(value, unit)
    @value = value
    @unit  = self.class.validate_unit(unit.singular)
  end
  @@units = {:dollar => 1, :yen => 0.013, :euro => 1.292, :rupee => 0.019}
  def self.unit?(unit)
    @@units.has_key? unit.singular
  end
  def in(out_unit)
    self.value / @@units[self.unit] * @@units[self.class.validate_unit(out_unit.singular)]
  end
  def self.validate_unit(unit)
    raise InvalidCurrencyUnit unless @@units[unit] ; unit
  end
  attr_reader :value, :unit
end

### tests
epsilon = 0.0000001

raise unless (5.dollars.in(:dollar) - 5).abs <= epsilon
raise unless (5.dollar.in(:dollars) - 5).abs <= epsilon
raise unless (5.dollars.in(:rupee) - 5*0.019).abs <= epsilon
raise unless (5.dollar.in(:rupees) - 5*0.019).abs <= epsilon
raise unless (5.dollars.in(:yen) - 5*0.013).abs <= epsilon
raise unless (5.dollar.in(:yens) - 5*0.013).abs <= epsilon
raise unless (5.dollars.in(:euro) - 5*1.292).abs <= epsilon
raise unless (5.dollar.in(:euros) - 5*1.292).abs <= epsilon

raise unless (5.euros.in(:dollar) - 5/1.292).abs <= epsilon
raise unless (5.euro.in(:dollars) - 5/1.292).abs <= epsilon
raise unless (5.euros.in(:rupee) - 5/1.292*0.019).abs <= epsilon
raise unless (5.euro.in(:rupees) - 5/1.292*0.019).abs <= epsilon
raise unless (5.euros.in(:yen) - 5/1.292*0.013).abs <= epsilon
raise unless (5.euro.in(:yens) - 5/1.292*0.013).abs <= epsilon
raise unless (5.euros.in(:euro) - 5).abs <= epsilon
raise unless (5.euro.in(:euros) - 5).abs <= epsilon

raise unless (5.yens.in(:dollar) - 5/0.013).abs <= epsilon
raise unless (5.yen.in(:dollars) - 5/0.013).abs <= epsilon
raise unless (5.yens.in(:rupee) - 5/0.013*0.019).abs <= epsilon
raise unless (5.yen.in(:rupees) - 5/0.013*0.019).abs <= epsilon
raise unless (5.yens.in(:yen) - 5/0.013*0.013).abs <= epsilon
raise unless (5.yen.in(:yens) - 5/0.013*0.013).abs <= epsilon
raise unless (5.yens.in(:euro) - 5/0.013*1.292).abs <= epsilon
raise unless (5.yen.in(:euros) - 5/0.013*1.292).abs <= epsilon

raise unless (5.rupees.in(:dollar) - 5/0.019).abs <= epsilon
raise unless (5.rupee.in(:dollars) - 5/0.019).abs <= epsilon
raise unless (5.rupees.in(:rupee) - 5).abs <= epsilon
raise unless (5.rupee.in(:rupees) - 5).abs <= epsilon
raise unless (5.rupees.in(:yen) - 5/0.019*0.013).abs <= epsilon
raise unless (5.rupee.in(:yens) - 5/0.019*0.013).abs <= epsilon
raise unless (5.rupees.in(:euro) - 5/0.019*1.292).abs <= epsilon
raise unless (5.rupee.in(:euros) - 5/0.019*1.292).abs <= epsilon



## b) Palindromes

### code
class String
  def palindrome?
      word_chars = self.downcase.gsub /\W/, ''
      word_chars == word_chars.reverse
  end
end

### tests
raise unless "A man, a plan, a canal -- Panama".palindrome?
raise unless "Madam, I'm Adam!".palindrome?
raise if "Abracadabra".palindrome?



## c) Palindromes Again

### code
module Enumerable
  def palindrome?
      self.to_a == self.to_a.reverse
  end
end

### tests
raise unless [1, 2, 3, 2, 1].palindrome?
raise if ({"one" => 1, "two" => 2, "three" => 3, "two" => 2, "one" => 1}).palindrome?
raise unless ["palindrome", "this", "is", "this", "palindrome"].palindrome?
raise if ["palindrome", "this", "is", "not"].palindrome?






# Part 4 - Blocks

### code
class CartesianProduct
  include Enumerable
  def initialize(left, right)
    @left  = left
    @right = right
  end
  def each
    @left.each { |l| @right.each { |r| yield [l, r] } }
  end
end

### tests
a = CartesianProduct.new([:a, :b], [4, 5])
b = CartesianProduct.new([:a, :b], [])
c = CartesianProduct.new([:a, :b, :c], [4, 5])
raise unless a.to_a.sort == [[:a, 4], [:a, 5], [:b, 4], [:b, 5]].sort
raise unless b.to_a.sort == [].sort
raise unless c.to_a.sort == [[:a, 4], [:a, 5], [:b, 4], [:b, 5], [:c, 4], [:c, 5]].sort




