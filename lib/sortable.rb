module Sortable
  def self.define_bang_methods(*methods)
    methods.each do |method|
      define_method("#{method}!") do
        replace(send(method))
      end
    end
  end

  define_bang_methods :bubblesort, 
                      :mergesort,
                      :insertion_sort,
                      :quicksort

  def quicksort(arr=nil)
    def split(array, value)
      left, equal, right = [], [], []
      array.each do |element|
        if element == value
          equal << element
        else
          reciever = (element < value ? left : right)
          reciever << element
        end
      end

      [left, equal, right]
    end

    arr = self.dup if arr.nil?
    return arr if arr.length < 2

    pivot = arr[arr.length / 2]
    left, equal, right = split(arr, pivot)
    quicksort(left) + equal + quicksort(right) 
  end

  def mergesort(arr=nil)
    arr = self.dup if arr.nil?
    return arr if arr.length < 2

    middle = arr.length / 2
    left, right = arr.take(middle), arr.drop(middle)
    merge(mergesort(left), mergesort(right))
  end

  def bubblesort
    arr = self.dup
    swap_made = true
    last_index = length - 1
    until swap_made == false
      swap_made = false

      each_index do |idx|
        next if idx == last_index
        if arr[idx] > arr[idx+1]
          arr[idx], arr[idx+1] = arr[idx+1], arr[idx]
          swap_made = true
        end
      end
    end

    arr
  end

  def insertion_sort
    arr = self.dup

    each_with_index do |pivot, pivot_idx|
      (0...pivot_idx).reverse_each do |compare_idx|
        if (pivot <= arr[compare_idx]) && 
          ((compare_idx == 0) || (pivot >= arr[compare_idx - 1]))
          arr.insert(compare_idx, pivot) 
          arr.delete_at(pivot_idx+1)
          break
        end
      end
    end

    arr
  end

  private
    def merge(left, right)
      merged = []

      until left.empty? or right.empty?
        merged <<
         ((left.first < right.first) ? left.shift : right.shift)
      end

      merged + left + right
    end

end
