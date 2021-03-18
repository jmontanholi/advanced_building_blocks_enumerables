module Enumerable
  def my_each
    length.times { |i| yield(self[i]) }
  end

  def my_each_with_index
    length.times { |i| yield(self[i], i) }
  end

  def my_select
    arr_new = []
    self.my_each { |i| arr_new << i if yield(i) }
    arr_new
  end

  def my_all?
    next_value = 0
    self.my_each { |i| next_value += 1 if yield(i) }
    next_value == length
  end

  def my_any?
    next_value = 0
    self.my_each { |i| next_value += 1 if yield(i) }
    next_value.positive?
  end

  def my_none?
    next_value = 0
    self.my_each { |i| next_value += 1 if yield(i) }
    next_value.zero?
  end

  def my_count(arg = nil)
    count = 0
    if arg.nil?
      if block_given?
        self.my_each { |i| count += 1 if yield(i) }
        count
      else
        count = length
      end
    else
      self.my_each { |i| count += 1 if i == arg }
      count
    end
    count
  end

  def my_map
    arr_new = []
    self.my_each { |i| arr_new << yield(i) }
    arr_new
  end

  def my_inject(initial_value = 0)
    self.my_each { |i| initial_value = yield(initial_value, i) }
    initial_value
  end

  def multiply_els
    my_inject(1) { |prod, value| prod * value }
  end
end
