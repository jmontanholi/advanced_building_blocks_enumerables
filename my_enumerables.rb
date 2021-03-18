module Enumerable
  def my_each
		self.length.times{|i| yield(self[i])}
	end
end

puts
puts "---CONTROL---"
control = [1, 2, 8, 5, 5]
puts "control array = #{control}"
puts
puts "my_each:"
control.my_each { |i| print i.to_s + " " }
