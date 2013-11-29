module Sortable
  def mergesort(arr=nil)
    def merge(left, right)
      merged = []
      until left.empty? or right.empty?
        merged <<
         ((left.first < right.first) ? left.shift : right.shift)
      end
      merged + left + right
    end

    arr = self.dup if arr.nil?
    return arr if arr.length < 2

    middle = arr.length / 2
    left = arr.take(middle)
    right = arr.drop(middle)
    merge(mergesort(left), mergesort(right))
  end

  def mergesort!
    replace(mergesort)
  end
end
