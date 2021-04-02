require "./enumerables.rb"

describe "#my_each" do
  it 'goes through every item in an array' do
    expect([1, 2, 3, 4 ,5].my_each{|x| x}).to eql([1, 2, 3, 4, 5])
  end

  it 'returns an error if no array is passed' do
    expect {nil.my_each}.to raise_error(NoMethodError)
  end

  it 'my_each will return an enumerator if no block-given is passed' do
    expect([1,2,3,4,5].my_each).to be_an Enumerator
  end
end

describe "#my_each_with_index" do
  it 'goes through every item in an array and returns the item and its index' do
    expect( [1, 2, 3, 4 ,5].my_each_with_index { |k, v| "#{k} and #{v}"} ).to eql([1, 2, 3, 4, 5])
  end

  it 'returns an error if no array is passed' do
    expect {nil.my_each_with_index}.to raise_error(NoMethodError)
  end

  it 'my_each_with_index will return an enumerator if no block-given is passed' do
    expect([1,2,3,4,5].my_each_with_index).to be_an Enumerator
  end
end

describe '#my_select' do
  it 'my_select returns an array with the elements that match the condition that passed through block given' do
    expect([1,2,3,4,5].my_select { |num|  num.even? }).to eql([2, 4])
  end

  it 'returns an error if no array/object is passed' do
    expect {nil.my_select}.to raise_error(NoMethodError)
  end

  it 'my_select will not return an error if no block-given is passed' do
    expect { [1,2,3,4,5].my_select }.not_to raise_error
  end

  it 'my_select will return an enumerator if no block-given is passed' do
    expect([1,2,3,4,5].my_select).to be_an Enumerator
  end
end

describe '#my_all' do
  it 'my_all will return true if all elements pass tha condition in the block-given' do
    expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be true
  end

  it 'my_all will return false if not all elements pass tha condition in the block-given' do
    expect(%w[ant bear cat].all? { |word| word.length >= 4 }).to be false
  end
  
  it 'my_all will return true if all elements match the given argument' do
    expect([1, 2i, 3.14].my_all?(Numeric) ).to be true
  end

  it 'my_all will return false if not all elements match the given argument' do
    expect(%w[ant bear cat].my_all?(/t/)).to be false
  end

  it 'my_all will return false if any element in the given array is falsy value' do
    expect([nil, true, 99].my_all? ).to be false
  end
end