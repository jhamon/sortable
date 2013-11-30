module Sortable
  def self.define_bang_methods(*methods)
    methods.each do |method|
      define_method("#{method}!") do |&blk|
        replace(send(method, &blk))
      end
    end
  end

  define_bang_methods :bubblesort, 
                      :mergesort,
                      :insertion_sort,
                      :quicksort

  def bubblesort(&blk)
    blk ||= Proc.new { |el1, el2| el1 <=> el2 }
    arr = self.dup
    swap_made = true
    last_index = length - 1
    until swap_made == false
      swap_made = false

      each_index do |idx|
        next if idx == last_index
        if blk.call(arr[idx], arr[idx+1]) == 1
          arr[idx], arr[idx+1] = arr[idx+1], arr[idx]
          swap_made = true
        end
      end
    end

    arr
  end

  def insertion_sort(&blk)
    blk ||= Proc.new { |pivot_val, compare_val| pivot_val <=> compare_val }
    arr = self.dup

    def swap_needed_at_index?(index, pivot, arr, blk)
        return (blk.call(pivot, arr[index]) != 1) &&
          (index == 0 || blk.call(pivot, arr[index - 1]) != -1) 
    end

    each_with_index do |pivot, pivot_idx|
      (0...pivot_idx).reverse_each do |compare_idx|
        if swap_needed_at_index?(compare_idx, pivot, arr, blk)
          arr.insert(compare_idx, pivot) 
          arr.delete_at(pivot_idx+1)
          break
        end
      end
    end

    arr
  end

  def mergesort(arr=nil, &blk)
    blk ||= Proc.new { |el1, el2| el1 <=> el2 }

    arr = self.dup if arr.nil?
    return arr if arr.length < 2

    middle = arr.length / 2
    left, right = arr.take(middle), arr.drop(middle)
    merge(mergesort(left, &blk), mergesort(right, &blk), blk)
  end

  def quicksort(arr=nil, &blk)
    blk ||= Proc.new { |pivot, element| pivot <=> element }

    def split(array, pivot, blk)
      left, equal, right = [], [], []
      array.each do |element|
        case blk.call(pivot, element)
        when 0
          equal << element
        when 1
          left << element
        when -1
          right << element
        end
      end

      [left, equal, right]
    end

    arr = self.dup if arr.nil?
    return arr if arr.length < 2

    pivot = arr[arr.length / 2]
    left, equal, right = split(arr, pivot, blk)
    quicksort(left, &blk) + equal + quicksort(right, &blk) 
  end

  private
    def merge(left, right, blk)
      merged = []

      until left.empty? or right.empty?
        merged <<
         ((blk.call(left.first, right.first)) == 1 ? right.shift : left.shift)
      end

      merged + left + right
    end
end
