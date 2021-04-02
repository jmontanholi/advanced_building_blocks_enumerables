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
    else arg.nil? ? my_each { |i| break all = false if [false, nil].include?(i) } : all = get_instance(arg)
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

  def get_instance_any(arg)
    control = 0
    if arg.instance_of?(Regexp)
      my_each { |i| control += 1 unless i.to_s.match(arg).nil? }
    elsif arg.is_a?(Class)
      my_each { |i| control += 1 if i.is_a?(arg) }
    else
      my_each { |i| control += 1 if i == arg }
    end
    control.positive?
  end

  def my_any?(arg = nil)
    control = 0
    if block_given?
      my_each { |i| control += 1 if yield(i) }
    elsif !arg.nil?
      return get_instance_any(arg)
    else
      my_each { |i| control += 1 unless i == false || i.nil? }
    end
    control.positive?
  end

  def my_none?(arg = nil)
    control = 0
    if block_given?
      my_each { |i| control += 1 if yield(i) }
    elsif !arg.nil?
      return !get_instance_any(arg)
    else
      my_each { |i| control += 1 unless i == false || i.nil? }
    end
    control.zero?
  end

  def my_count(arg = nil)
    count = 0
    if arg.nil?
      block_given? ? my_each { |i| count += 1 if yield(i) } : count = size
    else
      my_each { |i| count += 1 if i == arg }
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map, proc) unless block_given?

    arr_new = []
    proc.nil? ? my_each { |i| arr_new << yield(i) } : my_each { |i| arr_new << proc.call(i) }
    arr_new
  end

  def my_inject(initial = nil, sym = nil)
    if sym.nil? && (initial.is_a?(Symbol) || initial.is_a?(String))
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
# control3 = [false, 2]
# control4 = [1, 2]
# control5 = [2,3,4]
# test = ["1", 3]
# puts "my_each:"
# p control.my_each { |value| value}
# p control.each { |value| value}
# puts "my_each with index:"
# hash = {a: 1, b: 2, c: 3, d:4, e:5 }
# p [1, 2, 3, 4 ,5].my_each_with_index { |k, v|"#{k} and #{v}"}
# puts "my_select:"
# p control.my_select
# puts "my_all?:"
# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true
# puts "my_any?:"
# p control3.my_any?(/ue/)
# puts "my_none?:"
# p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none?(/d/)                        #=> true
# p [1, 3.14, 42].my_none?(Float)                         #=> false
# p [].my_none?                                          #=> true
# p [nil].my_none?                                      #=> true
# p [nil, false].my_none?                                #=> true
# p [nil, false, true].my_none?                          #=> false
# puts "my_count:"
# p control.my_count{|i| i < 17}
# p control.count{|i| i < 17}
# my_proc = Proc.new { |i| i + 1 }
# puts "my_map:"
# p control.map { |i| i*i }      #=> [1, 4, 9, 16]
# p control.my_map { |num| num < 10 }
# p control.map { |num| num < 10 }
# puts "my_inject:"
# p (2..5).my_inject
# p (2..5).inject
