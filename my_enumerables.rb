module Enumerable
  def my_each
    length.times { |i| yield(self[i]) }
    self
  end

  def my_each_with_index
    length.times { |i| yield(self[i], i) }
    self
  end

  def my_select
    arr_new = []
    my_each { |i| arr_new << i if yield(i) }
    arr_new
  end

  def my_all?
    all = true
    my_each { |i| break all = false unless yield(i) }
    all
  end

  def my_any?
    any = false
    my_each { |i| break any = true if yield(i) }
    any
  end

  def my_none?(&block)
    !my_any?(&block)
  end

  def my_count(arg = nil)
    count = 0
    if arg.nil?
      if block_given?
        my_each { |i| count += 1 if yield(i) }
        count
      else
        count = length
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
# control = [10, 1, 2, 5, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1]

# puts "my_each:"
# control.my_each { |value| p value }
# puts
# puts "my_each with index:"
# control.my_each_with_index { |i, ind| print ind.to_s + ":" + i.to_s + " " }
# puts
# puts "my_select:"
# p control.my_select { |i| i < 11 }
# puts "my_all?:"
# p control.my_all? { |i| i < 15 }
# puts "my_any?:"
# p control.my_any? { |i| i < 15 }
# puts "my_none?:"
# p control.my_none? { |i| i < 15 }
# puts "my_count:"
# p control.my_count(1)
# p control.my_count
# my_proc = Proc.new { |i| i % 2 }
# puts "my_map:"
# p control.my_map(my_proc)
# p control.my_map { |i| i * 2 }
# p control.my_map { |i| i * 2 }.my_map(my_proc)
# puts "my_inject:"
# p control.my_inject(10) { |sum, i| sum + i }
# puts "multiply_els:"
# p multiply_els(control)
