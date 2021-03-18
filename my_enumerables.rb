module Enumerable
  def my_each
		self.length.times{|i| yield(self[i])}
	end

  def my_each_with_index
    self.length.times{|i| yield(self[i], i)}
  end
end

puts
puts "---CONTROL---"
control = [1, 2, 8, 5, 5]
puts "control array = #{control}"
puts
puts "my_each:"
control.my_each { |i| print i.to_s + " " }
puts "my_each:"
control.my_each_with_index { |i, ind| print ind.to_s + ":" + i.to_s + " " }