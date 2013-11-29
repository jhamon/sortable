module Sortable
  def mergesort(arr=nil)
    arr = self.dup if arr.nil?
    return arr if arr.length < 2

    middle = arr.length / 2
    left = arr.take(middle)
    right = arr.drop(middle)
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
