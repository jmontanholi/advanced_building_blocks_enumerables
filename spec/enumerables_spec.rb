require "./enumerables.rb"

describe "#my_each" do
  it 'goes through every item in an array' do
    expect([1, 2, 3, 4 ,5].my_each{|x| x}).to eql([1, 2, 3, 4, 5])
  end

  it 'returns an error if no array is passed' do
    expect {nil.my_each}.to raise_error(NoMethodError)
  end
end

describe "#my_each_with_index" do
  it 'goes through every item in an array and returns the item and its index' do
    expect( [1, 2, 3, 4 ,5].my_each_with_index { |k, v| "#{k} and #{v}"} ).to eql([1, 2, 3, 4, 5])
  end

  it 'returns an error if no array is passed' do
    expect {nil.my_each_with_index}.to raise_error(NoMethodError)
  end
end