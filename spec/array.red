Spec.describe Array do |it|
  # it.can 'intersect' do
  #   ([1,1,3,5] & [1,2,3]).should_equal([1,3])
  # end
  
  it.can 'initialize with the [] literals' do
    [1].should_equal([1])
  end
  
  it.can 'initialize with the %w() literal' do
    %w(a).should_equal(['a'])
  end
  
  it.can 'multiply itself by an integer and return a larger array' do
    ([1,2,3] * 2).should_equal([1,2,3,1,2,3])
  end
  
  it.can 'multiply itself by a string and return a joined string' do
    ([1,2,3] * ":").should_equal('1:2:3')
  end
  
  it.can 'be added to another array, resulting in one large array' do
    ([1,2,3] + [4,5]).should_equal([1, 2, 3, 4, 5])
  end
  
  it.can 'subtract another array, returning an array containing only items that appear in itself and not in the other' do
    ([1,1,2,2,3,3,4,5] - [1,2,4]).should_equal([3, 3, 5])
  end
  
  it.can 'append an object to the its end as the last element' do
    ([1,2] << 'c' << 'd' << [3,4]).should_equal([1, 2, "c", "d", [3, 4]])
  end
  
  it.can 'compare itself to another array' do
    (['a','a','c'] <=> ['a','b','c']).should_equal(-1)
    ([1,2,3,4,5,6] <=> [1,2]).should_equal(1)
    ([1,2] <=> [1,2]).should_equal(0)
  end
  
  it.can 'check if its equal to another array' do
    (['a','c'] == ['a', 'c', 7]).should_be_false
    (['a','c', 7] == ['a', 'c', 7]).should_be_true
    (['a','c', 7] == ['a', 'd', 'f']).should_be_false
  end
  
  it.can 'retrieve the object at a numeric index' do
    a = ['a','b','c']
    a[0].should_equal('a')
    a.at(-1).should_equal('c')
    a.at(0).should_equal('a')
    a.slice(0).should_equal('a')
  end
  
  it.returns 'nil if the object at the numeric index is nil or index is greater than its length' do
    ['a','b',nil][2].should_be_nil
    ['a','b'][2].should_be_nil
    ['a','b',nil].slice(2).should_be_nil
    ['a','b'].slice(2).should_be_nil
  end
  
  it.returns 'a sub array based on a start position and length' do
    (['a','b','c','d'][1,2]).should_equal(['b','c'])
  end
  
  it.returns 'a limited sub array when a start position and length are provided and position + length go beyond the size of the array' do
    (['a','b','c','d'][3,2]).should_equal(['d'])
    ['a','b','c','d'].slice(3,2).should_equal(['d'])
  end
  
  it.returns 'nil if a position and length are provided and position is past the size of the array' do
    (['a','b','c','d'][4,2]).should_be_nil
    ['a','b','c','d'].slice(4,2).should_be_nil
  end
  
  it.returns 'a sub array when a range is provided' do
    (['a','b','c','d'][1..3]).should_equal(['b','c', 'd'])
    ['a','b','c','d'].slice(1..3).should_equal(['b','c', 'd'])
  end
  
  it.returns 'a limited sub array when a range is provided and the range goes beyond the size of the array' do
    (['a','b','c','d'][2..5]).should_equal(['c','d'])
    ['a','b','c','d'].slice(2..5).should_equal(['c','d'])
  end
  
  it.returns 'nil if a range is provided and the range begins beyong the sie of the array' do
    (['a','b','c','d'][4..5]).should_equal(nil)
    ['a','b','c','d'].slice(4..5).should_equal(nil)
  end
  
  it.can 'assgin objects to a specific location in the array, overwriting as neccessary' do
    a = ['0']
    a[0] = 'zero'
    a.should_equal(['zero'])
  end
  
  it.can 'assign objects to a specific location in the array, padding with nil if neccessary' do
    a = []
    a[4] = '4'
    a.should_equal([nil,nil,nil,nil,'4']) 
  end
  
  it.can 'assign objects from an array to a location in the array based on a start position and length' do
    ([1,2,3,4,5,6,7][0,3] = ['a','b', 'c']).should_equal(['a','b','c',4,5,6,7])
  end
  
  it.can 'assign objects from an array to a location in the array based on a range' do
    ([1,2,3,4,5,6,7][1..2] = ['a','b']).should_equal([1,'a','b',4,5,6,7])
  end
  
  it.can 'assoc' do
    a  = [['colors','red','blue','green'], ['letters','a','b','c'], 'foo']
    a.assoc('letters').should_equal(["letters", "a", "b", "c"])
    a.assoc('foo').should_be_nil
  end
  
  it.can 'clear' do
    [3,2,1].clear.should_equal([])
  end
  
  it.can 'map additonal values into a new array' do
   a = [1,2,3,4]
   b = a.collect {|x| x + 100}
   b.should_equal([101,102,103,104])
   a.should_not_equal(b)
   
   # map is an alias for collect
   a = [1,2,3,4]
   b = a.map {|x| x + 100}
   b.should_equal([101,102,103,104])
   a.should_not_equal(b)
  end
  
  it.can 'map additonal values into itself' do
    a = [1,2,3,4]
    b = a.collect! {|x| x + 100}
    b.should_equal([101,102,103,104])
    a.should_equal(b)

    # map! is an alias for collect!
    a = [1,2,3,4]
    b = a.map! {|x| x + 100}
    b.should_equal([101,102,103,104])
    a.should_equal(b)
  end
  
  it.can 'remove nil elements' do
    ['a',nil,'b',nil,'c'].compact!.should_equal(["a", "b", "c"])
  end
  
  it.returns 'nil when attempting to remove nil elements from an array that has no nil elements' do
    ["a", "b", "c"].compact!.should_equal(nil)
  end
  
  it.can 'add the elelemts of a new array to its own end, as elements' do
    [1,2].concat([3,4]).concat([5,6]).should_equal([1, 2, 3, 4, 5, 6])
  end
  
  it.can 'delete any objects in an array equal to a passed object, returning the passed object'
  
  it.returns 'nil when attempting to delete an object from an array that does not contain the object' do
    # ['a','b','b','b','c'].delete('z').should_equal(nil)
  end  
  
  it.can 'delete objects from an array based on a provided block'
  
  it.can 'delete an item at a specific index, returning the item' do
    a = ['a','b','c','d']
    a.delete_at(2).should_equal('c')
    a.should_equal(['a','b','d'])
  end
  
  it.returns 'nil when attemping to delete an item at specific position if the array does not contain an object at the position' do
    ['a','b','c','d'].delete_at(6).should_equal(nil)
  end
  
  it.can 'delete objects based on a specific equality checking block'
  it.can 'loop through its elements'
  it.can 'check whether it is empty'
  it.can 'check whether it is equal to another array, returning true or false'
  
  it.can 'fetch items with an index' do
    ['a','b','c'].fetch(1).should_equal('b')
  end
  
  it.returns 'nil when fetching an item with a provided index beyond the length' do
    ['a','b','c'].fetch(5).should_be_nil
  end
  
  it.returns 'a default value if one is provided when fetching at an index and there is no object at the index' do
    ['a','b','c'].fetch(5, 'FAIL').should_equal('FAIL')
  end
  
  it.can 'call a blockon failed value fetching if a block is provided'
  
  it.can 'fill itself with new values' do
    ['a','b','c', 'd'].fill('x').should_equal(['x','x','x','x'])
  end
  
  it.can 'fill itself with new values starting a start position and continuing for an optional length' do
    ['a','b','c', 'd'].fill('x', 2).should_equal(['a','b','x','x'])
    ['a','b','c', 'd'].fill('x', 1,2).should_equal(['a','x','x','d'])
  end
  
  it.can 'get the its first element' do
    ['1','2','3'].first.should_equal('1')
  end  
  
  it.can 'get the its first n elements with a provider number' do
     ['1','2','3'].first(2).should_equal(['1','2'])
  end
  
  it.can 'flatten and return a new flat array' do
    a = ['a','b',['d','e','f'],'g']
    b = a.flatten
    a.should_not_equal(['a','b','d','e','f','g'])
    b.should_equal(['a','b','d','e','f','g'])
  end
  
  it.can 'flatten itself' do
    a = ['a','b',['d','e','f'],'g']
    b = a.flatten!
    a.should_equal(['a','b','d','e','f','g'])
    b.should_equal(['a','b','d','e','f','g'])
  end
  
  it.returns 'nil if flattening itself and no changes were made' do
    ['a','b','d','e','f','g'].flatten!.should_equal(nil)
  end
  
  it.can 'determine whether it includes an object returning true or false' do
    ['a','b','c'].include?('a').should_be_true
    ['a','b','c'].include?('d').should_be_false
  end
  
  it.returns 'the index of an object when looking for an object and the object is in the array' do
    ['a','b','c'].index('a').should_equal(0)
  end
  
  it.returns 'nil when looking for an object and the object is not in the array' do
    ['a','b','c'].index('d').should_be_nil
  end
  
  it.can 'insert an object before paritcular index' do
    [1,2,3,4].insert(2,99).should_equal([1, 2, 99, 3, 4])
  end
  
  it.can 'insert an object before a paricular negative index' do
    [1,2,3,4].insert(-2,'a','b','c').should_equal([1, 2, 3, "a", "b", "c", 4])
  end
  
  it.returns 'printable version of itself' do
     [1,2,3].inspect.should_equal("[1, 2, 3]")
  end
  
  it.can 'join each element with a string, returning a new string' do
    ['a','b','c'].join(',').should_equal('a,b,c')
  end
  
  
  it.can 'get the its last element' do
    ['1','2','3'].last.should_equal('3')
  end  
  
  it.can 'get the its last n elements with a provider number' do
     ['1','2','3'].last(2).should_equal(['2','3'])
  end
  
  it.can 'provide its length as a number' do
    a = ['1','2','3']
    a.size.should_equal(3)
    a.length.should_equal(3)
  end
  
  it.returns 'the number of non-nil items' do
    [1, nil, 3, nil, 5].nitems.should_equal(3)
  end
  
  it.can 'remove its last item returing that item' do
    a = ['1','2','3']
    a.pop.should_equal('3')
    a.should_equal(['1','2'])
  end
  
  it.returns 'nil when attempting to pop an item when empty' do
    [].pop.should_equal(nil)
  end
  
  it.can 'append items to its end, returning itself' do
    [1,2,3].push(4).push(5,6,7).should_equal([1, 2, 3, 4, 5, 6, 7])
  end
  
  it.can 'rassoc' do
    a  = [[1,'one'], [2,'two'], [:ii,'two']]
    a.rassoc('two').should_equal([2, "two"])
    a.rassoc('three').should_be_nil
  end
  
  it.can 'create a new array with rejected elements removed' do
    a = [1,2,3,4,5]
    b = a.reject {|x| x > 3 }
    b.should_equal([1, 2, 3])
    a.should_not_equal(b)
  end
  
  it.can 'remove every element for which block evaluates to true' do
    a = [1,2,3,4,5]
    b = a.reject {|x| x > 3 }
    b.should_equal([1, 2, 3])
    a.should_equal(b)
  end
  
  it.can 'repalce its contents with the contents of another array, truncating or expanding if necessary' do
    ['a','b','c'].replace(['w','x','y', 'z']).should_equal(["w", "x", "y", "z"])
  end
  
  it.can 'return a reversed array' do
    a = [1,2,3,4,5]
    b = a.reverse
    b.should_equal([5,4,3,2,1])
    a.should_equal([1,2,3,4,5])
  end
  
  it.can 'reverse itself' do
    a = [1,2,3,4,5]
    b = a.reverse!
    b.should_equal([5,4,3,2,1])
    a.should_equal([5,4,3,2,1])
  end
  
  it.can 'return a sorted array' do
    a = [3, 2, 4, 1]
    b = a.sort
    b.should_equal([1,2,3,4])
    a.should_not_equal(b)
  end
  
  it.can 'sort itself' do
    a = [3, 2, 4, 1]
    b = a.sort!
    b.should_equal([1,2,3,4])
    a.should_equal(b)
  end
  
  it.can 'convert itself to an array' do
    [1,2,3].to_a.should_equal([1, 2, 3])
  end
  
  it.can 'convert itself to a string, calling .to_s on each element' do
    [1,2,3].to_s.should_equal('123')
  end
  
  it.can 'transpose' do
    [[1,2],[3,4],[5,6]].transpose.should_equal([[1, 3, 5], [2, 4, 6]])
  end
  
  it.can 'return a new array with repeated elements removed' do
    a = ['a','b','b','c','c','c']
    b = a.uniq
    a.should_not_equal(["a", "b", "c"])
    b.should_equal(["a", "b", "c"])
    a.should_not_equal(b)
  end
  
  it.can 'remove repeated elements from itself' do
    a = ['a','b','b','c','c','c']
    b = a.uniq!
    a.should_equal(["a", "b", "c"])
    b.should_equal(["a", "b", "c"])
    a.should_equal(b)
  end
  
  it.returns 'nil if removing repeated elements from itself has no effect' do
    ["a", "b", "c"].uniq!.should_equal(nil)
  end
  
  it.can 'prepend objects to the front, shifting the indices of another array\'s other elements up one, then returns itself' do
    a = ['b','c']
    a.unshift('a').should_equal(["a", "b", "c"])
    a.unshift(1,2,3).should_equal([1, 2, 3, "a", "b", "c"])
  end
  
  it.can 'retrurn an array containing the elements in self corresponding to the given selector(s)'
  it.can 'combine with another array instering elements at a position in one the same indexed element in the other (zipping)'
  
  it.can 'provider a union of two arrays' do
   ([1,2,3] | [3,4,1]).should_equal([1, 2, 3, 4])
  end
  
end