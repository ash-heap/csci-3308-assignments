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









