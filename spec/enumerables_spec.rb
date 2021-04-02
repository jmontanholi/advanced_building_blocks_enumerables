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

describe '#my_all?' do
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

  it 'will return true if the array passed is empty and there is no block or argument' do 
    expect([].my_all?).to be true
  end
end

describe '#my_any?' do
  it 'will return true if any element pass the condition in the given block' do
    expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to be true
  end

  it 'will return false if no element pass the condition in the given block' do
    expect(%w[ant bear cat].my_any?{ |word| word.length >= 5}).to be false
  end

  it 'will return true if any element match the given argument' do
    expect([nil, true, 99].my_any?(Integer)).to be true
  end

  it 'will return true if no block is given and any element is a truthy value' do 
    expect([nil, true, 99].my_any?).to be true
  end

  it 'will return false if the array passed is empty and there is no block or argument' do 
    expect([].my_any?).to be false
  end
end

describe '#my_none?' do
  it 'will return true if no element pass the condition in the given block' do 
    expect(%w{ant bear cat}.my_none? { |word| word.length == 5 }).to be true
  end

  it 'will return false if any element pass the condition in the given block' do 
    expect(%w{ant bear cat}.my_none? { |word| word.length >= 4 }).to be false
  end

  it 'will return false if any element match the given argument' do
    expect([1, 3.14, 42].my_none?(Float)).to be false
  end

  it 'will return true if the given array is empty and no block or argument is given' do 
    expect([].my_none?).to be true
  end

  it 'will return true if all elements in the array are false values' do 
    expect([nil, false].my_none?).to be true
  end
end

describe '#my_count' do
  it 'my_count will return the number of elements in the array if no block-given or given argument passed' do
    expect([1, 2, 4, 2].my_count).to eql(4) 
  end

  it 'my_count will return the number of elements in the array that match the value of given argument' do
    expect([1, 2, 4, 2].my_count(2)).to eql(2) 
  end

  it 'my_count will return the number of elements in the array that pass the conition in block given' do
    expect([1, 2, 4, 2].my_count{ |x| x%2==0 }).to eql(3) 
  end
end

describe '#my_map' do
  it 'my_map Returns a new array with the results of running block once for every element in enum' do
    expect((1..4).my_map { |i| i*i }).to eql([1, 4, 9, 16])
  end

  it 'my_map will return an enumerator If no block is given' do
    expect((1..4).my_map).to be_an Enumerator
  end
end
