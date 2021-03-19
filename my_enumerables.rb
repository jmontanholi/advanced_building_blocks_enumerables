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
    all = true
    if block_given?
      my_each { |i| break all = false unless yield(i) }
    elsif !arg.nil?
      all = get_instance(arg)
    else
      my_each { |i| break all = false if [false, nil].include?(i) }
    end
    all
  end

  def get_instance(arg)
    all = true
    if arg.instance_of?(Regexp)
      my_each { |i| break all = false if i.to_s.match(arg).nil? }
    elsif arg.is_a?(Class)
      my_each { |i| break all = false unless i.is_a?(arg) }
    else
      my_each { |i| break all = false if i != arg }
    end
    all
  end

  def my_any?(arg = nil)
    control = 0
    if block_given?
      all = true
      my_each { |i| break all = false unless yield(i) }
      all
    elsif !arg.nil?
      if arg.instance_of?(Regexp)
        my_each { |i| control += 1 unless i.to_s.match(arg).nil? }
      elsif arg.is_a?(Class)
        my_each { |i| break control += 1 if i.is_a?(arg) }
      else
        my_each { |i| control += 1 if i == arg }
      end
    else
      control = 0
      my_each { |i| control += 1 if [false, nil].include?(i) }
      control.zero?
    end
    control.positive?
  end

  def my_none?(arg = nil)
    control = 0
    if block_given?
      my_each { |i| control += 1 unless yield(i) }
    elsif !arg.nil?
      if arg.instance_of?(Regexp)
        my_each { |i| control += 1 unless i.to_s.match(arg).nil? }
      elsif arg.is_a?(Class)
        my_each { |i| control += 1 if i.is_a?(arg) }
      else
        all = true
        my_each { |i| break all = false if i != arg }
        all
      end
    else
      my_each { |i| control += 1 if i != false || !i.nil? }
    end
    control.zero?
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
    if !proc.nil?
      my_each { |i| arr_new << proc.call(i) }
    elsif block_given?
      my_each { |i| arr_new << yield(i) }
    else
      to_enum(:my_map, proc)
    end
    arr_new
  end

  def my_inject(initial = nil, sym = nil)
    if (!initial.nil? && sym.nil?) && (initial.is_a?(Symbol) || initial.is_a?(String))
      sym = initial
      initial = nil
    end
    if !block_given? && !sym.nil?
      my_each { |item| initial = initial.nil? ? item : initial.send(sym, item) }
    else
      my_each { |item| initial = initial.nil? ? item : yield(initial, item) }
    end
    initial
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |prod, value| prod * value }
end

# # Testing
# control = [10, 1, 2, 5, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1 ]
# control2 = [10, 1, 2, 5, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1 ]
#  control3 = [nil, nil]
#  control4 = [1, 2]
#  control5 = [2,3,4]
#  test = ["a", "ba"]
#  puts "my_each:"
#  p control.my_each { |value| value < 3 }
#  p control.each { |value| value < 3}
#  puts "my_each with index:"
#  hash = {a: 1, b: 2, c: 3, d:4, e:5 }
#  p hash.my_each_with_index { |k, v| print k.to_s + ":" + v.to_s + " " }
#  p hash.each_with_index { |k, v| print k.to_s + ":" + v.to_s + " " }
#  puts "my_select:"
#  p control.my_select
#  puts "my_all?:"
#  p control2.my_all?(Numeric)
#  p test.my_all?(String)
#  p test.my_all?(/a/)
#  puts "my_any?:"
#  p control3.my_any?(/a/)
#  puts "my_none?:"
#  p control4.my_none?(String)
#  puts "my_count:"
#  p control.my_count
#  p control.my_count
#   my_proc = Proc.new { |i| i + 1 }
#   puts "my_map:"
#   p control.my_map(my_proc){ |i| i * 2 }
#   p (1..6).my_map { |i| i * 2 }
#   p control.my_map { |i| i * 2 }.my_map(my_proc)
#   p control.my_map
#  puts "my_inject:"
#  p (2..5).my_inject("+")
