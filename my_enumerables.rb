module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for i in self do
      yield(i)
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    count = 0
    for i in self do
      yield(i, count)
      count += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr_new = []
    my_each { |i| arr_new << i if yield(i) }
    arr_new
  end

  def my_all?(arg = nil)
    return false if self.empty?
    if block_given? 
      all = true
      my_each { |i| break all = false unless yield(i) }
      all 
    elsif !arg.nil?
      if arg.class == Regexp 
        control = 0
        my_each { |i| control += 1 unless !!(i.to_s.match(arg) )}
        control.zero?
      elsif arg.is_a? (Class)
        control = 0
        my_each { |i| control += 1 if !(i.kind_of? (arg))}
        control.zero?
      else
        all = true
        my_each { |i| break all = false if i != arg }
        all 
      end
    else
      control = 0
      self.my_each{ |i| control += 1 if i == false || i == nil}
      control.zero?
    end
  end

  def my_any?(arg=nil)
    if block_given? 
      all = true
      my_each { |i| break all = false unless yield(i) }
      all 
    elsif !arg.nil?
      if arg.class == Regexp 
        control = 0
        my_each { |i| control += 1 if !!(i.to_s.match(arg))}
        control.positive?
      elsif arg.is_a? (Class)
        control = 0
        my_each { |i| break control += 1 if (i.kind_of? (arg))}
        control.positive?
      else
        control = 0
        my_each { |i| control += 1 if i == arg }
        control.positive?
      end
    else
      control = 0
      self.my_each{ |i| control += 1 if i == false || i == nil}
      control.zero?
    end
  end

  def my_none?(arg = nil)
    if block_given? 
      control = 0
      my_each { |i| control += 1 unless yield(i) }
      control.zero? 
    elsif !arg.nil?
      if arg.class == Regexp 
        control = 0
        my_each { |i| control += 1 if !!(i.to_s.match(arg))}
        control.zero?
      elsif arg.is_a? (Class)
        control = 0
        my_each { |i| control += 1 if (i.kind_of? (arg))}
        control.zero?
      else
        all = true
        my_each { |i| break all = false if i != arg }
        all 
      end
    else
      control = 0
      self.my_each{ |i| control += 1 if i != false || i != nil}
      control.zero?
    end
  end

  def my_count(arg = nil)
    count = 0
    if arg.nil?
      if block_given?
        my_each { |i| count += 1 if yield(i) }
        count
      else
        count = size
      end
    else
      my_each { |i| count += 1 if i == arg }
      count
    end
    count
  end

  def my_map(proc = nil)
    arr_new = []
    if block_given?
      my_each { |i| arr_new << yield(i) }
    else
      my_each { |i| arr_new << proc.call(i) }
    end
    arr_new
  end

  def my_inject(initial_value = 0)
    my_each { |i| initial_value = yield(initial_value, i) }
    initial_value
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |prod, value| prod * value }
end

# Testing
control = [10, 1, 2, 5, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1 ]
control2 = [10, 1, 2, 5, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1 ]
control3 = [1, "_"]
control4 = ["a", "b"]
test = ["a", "ba"]
puts "my_each:"
p control.my_each { |value| value < 3 }
p control.each { |value| value < 3}
puts "my_each with index:"
hash = {a: 1, b: 2, c: 3, d:4, e:5 }
p hash.my_each_with_index { |k, v| print k.to_s + ":" + v.to_s + " " }
p hash.each_with_index { |k, v| print k.to_s + ":" + v.to_s + " " }
puts "my_select:"
p control.my_select
puts "my_all?:"
p control2.my_all?(Numeric)
p test.my_all?(String)
p test.my_all?(/a/)
puts "my_any?:"
p control3.my_any?(/a/)
puts "my_none?:"
p control4.my_none?(Numeric)
puts "my_count:"
p control.my_count
p control.my_count
# my_proc = Proc.new { |i| i % 2 }
# puts "my_map:"
# p control.my_map(my_proc)
# p control.my_map { |i| i * 2 }
# p control.my_map { |i| i * 2 }.my_map(my_proc)
# puts "my_inject:"
# p control.my_inject(10) { |sum, i| sum + i }
# puts "multiply_els:"
# p multiply_els(control)
