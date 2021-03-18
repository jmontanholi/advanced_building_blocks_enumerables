module Enumerable
  def my_each
    length.times { |i| yield(self[i]) }
  end

  def my_each_with_index
    length.times { |i| yield(self[i], i) }
  end

  def my_select
    arr_new = []
    length.times { |i| arr_new.push(self[i]) if yield(self[i]) }
    arr_new
  end

  def my_all?
    next_value = 0
    length.times { |i| next_value += 1 if yield(self[i]) }
    next_value == length
  end

  def my_any?
    next_value = 0
    length.times { |i| next_value += 1 if yield(self[i]) }
    next_value.positive?
  end

  def my_none?
    next_value = 0
    length.times { |i| next_value += 1 if yield(self[i]) }
    next_value.zero?
  end

  def my_count(arg = nil)
    count = 0
    if arg.nil?
      if block_given?
        length.times { |i| count += 1 if yield(self[i]) }
        count
      else
        count = length
      end
    else
      length.times { |i| count += 1 if self[i] == arg }
      count
    end
    count
  end
end

puts
puts '---CONTROL---'
control = [1, 2, 8, 5, 5]
puts "control array = #{control}"
puts
puts 'my_each:'
control.my_each { |i| print "#{i} " }
puts 'my_each:'
control.my_each_with_index { |i, ind| print "#{ind}:#{i} " }
puts 'my_select:'
p control.my_select { |i| i < 3 }
puts 'my_all?:'
p control.my_all? { |i| i < 3 }
puts 'my_any?:'
p control.my_any? { |i| i < 3 }
puts 'my_none?:'
p control.my_none? { |i| i < 3 }
puts 'my_count:'
p control.my_count(&:even?)
p control.my_count
p control.my_count(5)
