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
puts "my_all?:"
p control.my_all? { |i| i < 3 }
puts "my_any?:"
p control.my_any? { |i| i < 3 }
