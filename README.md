## Sortable [![Build Status](https://travis-ci.org/jhamon/sortable.png)](https://travis-ci.org/jhamon/sortable)


Sortable is a small module containing several common sorting methods.  I mostly
wrote it as a way to learn about sorting algorithms, but if you want to use it
simple reopen the `Array` class and include the module.

``` ruby
require 'sortable.rb'

class Array
  include Sortable
end
```


So far, I have completed the following methods:
 - `bubblesort`
 - `insertion_sort`
 - `mergesort`
 - `quicksort`


## References:
- [Big O Cheat Sheet](http://www.bigocheatsheet.com)
- [Sorting Algorithms on
Wikipedia](https://en.wikipedia.org/wiki/Sorting_algorithm)

