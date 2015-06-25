Matrix = []

File.open("matrix.txt") { |f|
  f.each_line { |line| Matrix.push(line.split(",").map { |s| s.to_i }) }
}

#==============================================================================
# ** PriorityQueue
#-----------------------------------------------------------------------------
# A simple priority queue structure that is always sorted by key value.
# Insertion is O(n) time, but removal is O(1) time and thus it is generally
# faster than a binary heap for small data sets due to the lack of overhead.
#==============================================================================

class PriorityQueue

  def initialize
    @queue = []
  end

  def size
    @queue.size
  end

  def empty?
    size == 0
  end

  def min
    return nil if empty?
    return @queue[0][1]
  end

  def insert(key, value)
    index = 0
    index += 1 until index == @queue.size or @queue[index][0] > key
    @queue.insert(index, [key, value])
  end

  def shift
    old_min = min
    remove_min
    old_min
  end

  def remove_min
    @queue.shift
  end

  def to_s
    @queue.to_s
  end

end

#==============================================================================
# ** BinaryHeap
#-----------------------------------------------------------------------------
# A Ruby implementation of the binary heap data structure.
#==============================================================================

class BinaryHeap < PriorityQueue

  attr_reader   :heap

  def initialize
    # Initialise heap with a nil value at i = 0 to keep indexing happy
    @heap = [nil]
  end

  def size
    # Total size of the heap minus the obligatory null entry
    @heap.size - 1
  end

  def min
    # There's no value if the heap is empty.
    return nil if empty?
    return @heap[1][1]
  end

  def insert(key, value)
    # Fill in the next value with a "hole"
    @heap.push(nil)
    # Position is the size of the heap minus the null entry.
    pos = size
    # While the key is less than the parent's key, and the root has not yet
    # been reached
    while pos > 1 and key < @heap[pos / 2][0]
      # Fill in the "hole", or children node with parent node.
      @heap[pos] = @heap[pos / 2]
      # Set the next position to the parent node.
      pos /= 2
    end
    # Finally, fill in the "hole" or duplicate reference.
    @heap[pos] = [key, value]
  end

  def remove_min
    # Nothing to do if the heap is already empty.
    return if empty?
    # Start at the root
    pos = 1
    # Set the entry to be bubbled to the last key, value pair, and delete that
    # entry from the heap
    bubble_entry = @heap.pop
    # Don't fill in the hole if the heap is empty
    return if empty?
    # While the leaf node has not yet been reached
    while pos * 2 < size
      # If the right child exists, and its key is smaller than the left
      # child's key
      if pos * 2 + 1 < size and @heap[pos * 2 + 1][0] < @heap[pos * 2][0]
        # Use the right child as the comparison
        next_pos = pos * 2 + 1
      else
        # Otherwise, use the left child
        next_pos = pos * 2
      end
      # Stop if the bubble entry's key is less than the child's key
      break if bubble_entry[0] < @heap[next_pos][0]
      # Otherwise, set the "hole" equal to the child
      @heap[pos] = @heap[next_pos]
      # Set the new position to the position of the child.
      pos = next_pos
    end
    # Finally, fill in the "hole" or duplicate reference.
    @heap[pos] = bubble_entry
  end

  def to_s
    # Simple string representation of the heap, unordered.
    @heap[1..-1].to_s
  end

end

#==============================================================================
# ** Node
#==============================================================================

class Node

  attr_reader   :x
  attr_reader   :y
  attr_reader   :cost
  attr_reader   :parent

  def initialize(x, y, parent)
    @parent = parent
    @x = x
    @y = y
    @cost = Matrix[y][x] + (@parent ? @parent.cost : 0)
  end

end

def goal_state?(node)
  # Goal is reached when the node is at the bottom-right corner of the matrix
  node.x == Matrix[0].size - 1 and node.y == Matrix.size - 1
end

curr_node = Node.new(0, 0, nil)
fringe = BinaryHeap.new
fringe.insert(curr_node.cost, curr_node)

# Keep track of the minimum cost incurred so far
cost_so_far = Array.new(Matrix.size * Matrix[0].size, -1)

# Dijkstra's Algorithm
while true
  curr_node = fringe.shift
  2.times { |i|
    # 0: Right, 1: Down
    x, y = case i
    when 0 then [curr_node.x + 1, curr_node.y]
    when 1 then [curr_node.x, curr_node.y + 1]
    end
    # Make sure that the node is inside the matrix
    next if x < 0 or y < 0
    next if x >= Matrix[0].size or y >= Matrix.size
    new_node = Node.new(x, y, curr_node)
    next if cost_so_far[y * Matrix.size + x] >= 0 and
        cost_so_far[y * Matrix.size + x] < new_node.cost
    fringe.insert(new_node.cost, new_node)
    cost_so_far[y * Matrix.size + x] = new_node.cost
  }
  break if goal_state?(curr_node)
end

p curr_node.cost
