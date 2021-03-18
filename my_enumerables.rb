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

  def my_map
    arr_new = []
    length.times { |i| arr_new << yield(self[i]) }
    arr_new
  end

  def my_inject(initial_value = 0)
    length.times { |i| initial_value = yield(initial_value, self[i]) }
    initial_value
  end

  def multiply_els
    my_inject(1) { |prod, value| prod * value }
  end
end
