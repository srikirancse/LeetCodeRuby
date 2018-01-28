module LeetCode
  # Question 169
  # @param {Integer[]} nums
  # @return {Integer}
  def majority_element(nums)
    majority = nums[0]
    count = 0
    nums.size.times do |i|
      if count.zero?
        majority = nums[i]
        count += 1
      elsif nums[i] == majority
        count += 1
      else
        count -= 1
      end
    end
    majority
  end

  # Definition for a binary tree node.
  # class TreeNode
  #     attr_accessor :val, :left, :right
  #     def initialize(val)
  #         @val = val
  #         @left, @right = nil, nil
  #     end
  # end

  # @param {TreeNode} root
  # @return {Integer}
  def sum_of_left_leaves(root)
    sum_of_left_leaves_helper(root, false)
  end

  def sum_of_left_leaves_helper(root, flag)
    return 0 if root.nil?
    return root.val if root.left.nil? && root.right.nil? && flag
    sum_of_left_leaves_helper(root.left, true) +
      sum_of_left_leaves_helper(root.right, false)
  end

  # @param {String} s
  # @return {Integer}
  def first_uniq_char(s)
    freq = []
    s.each_byte { |i| freq[i] = (freq[i] ||= freq[i].to_i) + 1 }
    s.size.times { |i| return i if freq[s[i].ord] == 1 }
    -1
  end

  # Question 628: Computes the maximum product
  # possible with the elements of array
  #
  # @param {Integer[]} nums
  # @return {Integer}
  def maximum_product(nums)
    nums.sort!
    [nums[0] * nums[1] * nums[-1],
     nums[-1] * nums[-2] * nums[-3]].max
  end

  # Question 448: Finds the list of missing numbers
  # in an array where 1 <= a[i] <= n (n = size of array)
  #
  # @param {Integer[]} nums
  # @return {Integer[]}
  def find_disappeared_numbers(nums)
    (1..nums.size).to_a - nums
  end

  # Question 179: Computes the largest possible
  # number with given numbers in array.
  #
  # @param {Integer[]} nums
  # @return {String}
  def largest_number(nums)
    nums.map(&:to_s).sort! { |a, b| b + a <=> a + b }.join('').to_i.to_s
  end

  # @param {Integer[]} nums
  # @return {Void} Do not return anything, modify nums in-place instead.
  def wiggle_sort(nums)
    sorted = nums.sort.reverse
    j = nums.size / 2
    k = 0
    (0..nums.size - 1).each do |i|
      nums[i] = i.even? ? sorted[j] : sorted[k]
      i.even? ? j += 1 : k += 1
    end
  end

  # Question 442: Find All Duplicates in an Array
  # @param {Integer[]} nums
  # @return {Integer[]}
  def find_duplicates(nums)
    res = []
    nums.each do |var|
      new_var = nums[var.abs - 1]
      new_var < 0 ? res << var.abs : nums[var.abs - 1] *= -1
    end
    res
  end

  # Question 406: Queue Reconstruction by Height
  # @param {Integer[][]} people
  # @return {Integer[][]}
  def reconstruct_queue(people)
    people.sort! { |a, b| a[0] != b[0] ? b[0] - a[0] : a[1] - b[1] }
    res = []
    people.each { |p| res.insert(p[1], p) }
    res
  end

  # Question 540: Finds single unique element in a Sorted Array
  # @param {Integer[]} nums
  # @return {Integer}
  def single_non_duplicate(nums)
    nums[(0..nums.size).bsearch { |i| nums[i] != nums[i ^ 1] }]
  end

  # Question 53: Maximum sub array sum of an array
  # @param {Integer[]} nums
  # @return {Integer}
  def max_sub_array(nums)
    global_max = local_max = nums[0]
    (1..nums.size - 1).each do |i|
      local_max = [local_max + nums[i], nums[i]].max
      global_max = [local_max, global_max].max
    end
    global_max
  end

  # Question 134: Gas Station
  # @param {Integer[]} gas
  # @param {Integer[]} cost
  # @return {Integer}
  def can_complete_circuit(gas, cost)
    gas_left = gas_required = start = 0
    gas.each do |g|
      gas_left += g - cost[gas.index(g)]
      next if gas_left >= 0
      start = gas.index(g) + 1
      gas_required -= gas_left
      gas_left = 0
    end
    gas_left >= gas_required ? start : -1
  end

  # Question 322: Reconstruct Itinerary
  # @param {string[][]} tickets
  # @return {String[]}
  def find_itinerary(tickets)
    tickets = tickets.sort.reverse.group_by(&:first)
    route = []
    visit = lambda do |airport|
      visit[tickets[airport].pop[1]] while (tickets[airport] || []).any?
      route << airport
    end
    visit['JFK']
    route.reverse
  end

  # Question 461: Hamming Distance
  # @param {Integer} x
  # @param {Integer} y
  # @return {Integer}
  def hamming_distance(x, y)
    (x ^ y).to_s(2).count('1')
  end

  # Definition for an interval.
  # class Interval
  #     attr_accessor :start, :end
  #     def initialize(s=0, e=0)
  #         @start = s
  #         @end = e
  #     end
  # end

  # @param {Interval[]} intervals
  # @return {Interval[]}
  def merge(intervals)
    intervals.sort_by!(&:start)
    i = 0
    while i < intervals.size - 1
      if intervals[i].end >= intervals[i + 1].start
        merge_with_next_interval(intervals, i)
      else
        i += 1
      end
    end
    intervals
  end

  def merge_with_next_interval(intervals, i)
    current_interval = intervals[i]
    next_interval = intervals[i + 1]
    intervals[i].end = [next_interval.end, current_interval.end].max
    intervals.delete_at(i + 1)
  end

  # Definition for an interval.
  # class Interval
  #     attr_accessor :start, :end
  #     def initialize(s=0, e=0)
  #         @start = s
  #         @end = e
  #     end
  # end

  # @param {Interval[]} intervals
  # @return {Boolean}
  def can_attend_meetings(intervals)
    intervals.sort_by!(&:start)
    (1..intervals.size - 1).each do |i|
      return false if intervals[i].start < intervals[i - 1].end
    end
    true
  end

  # Definition for an interval.
  # class Interval
  #     attr_accessor :start, :end
  #     def initialize(s=0, e=0)
  #         @start = s
  #         @end = e
  #     end
  # end

  # @param {Interval[]} intervals
  # @return {Integer}
  def min_meeting_rooms(intervals)
    starts = []
    ends = []
    (0..intervals.size - 1).each do |i|
      starts[i] = intervals[i].start
      ends[i] = intervals[i].end
    end
    starts.sort!
    ends.sort!
    rooms = 0
    ends_ptr = 0
    (0..intervals.size - 1).each do |i|
      if starts[i] < ends[ends_ptr]
        rooms += 1
      else
        ends_ptr += 1
      end
    end
    rooms
  end

  # Question 621: Task Scheduler
  # @param {Character[]} tasks
  # @param {Integer} n
  # @return {Integer}
  def least_interval(tasks, n)
    freq = tasks.each_with_object(Hash.new(0)) { |v, h| h[v] += 1 }
    max_arr = freq.group_by(&:last).max
    [tasks.size, ((max_arr[0] - 1) * (n + 1) + max_arr[1].size)].max
  end

  # The knows API is already defined for you.
  # @param {Integer} person a
  # @param {Integer} person b
  # @return {Boolean} whether a knows b
  # def knows(a, b)

  # @param {Integer} n
  # @return {Integer}
  def find_celebrity(n)
    candidate = 1
    (2..n).each { |i| candidate = i if knows(candidate, i) }
    (1..n).each { |i| return -1 if knows(candidate, i) }
    candidate
  end

  # @param {Integer[]} nums
  # @return {Integer}
  def find_length_of_lcis(nums)
    return 0 if nums.size.zero?
    left_pointer = right_pointer = 0
    max_length = 1
    (1..nums.size - 1).each do |i|
      nums[i] <= nums[i - 1] ? left_pointer = right_pointer = i : right_pointer += 1
      max_length = [max_length, right_pointer - left_pointer + 1].max
    end
    max_length
  end

  # Question 286: Walls and Gates
  # @param {Integer[][]} rooms
  # @return {Void} Do not return anything, modify rooms in-place instead.
  def walls_and_gates(rooms)
    (0..rooms.length - 1).each do |i|
      (0..rooms[0].length - 1).each do |j|
        walls_and_gates_dfs(rooms, i, j, 0) if rooms[i][j].zero?
      end
    end
  end

  def walls_and_gates_dfs(rooms, i, j, d)
    return if (i < 0) || (i >= rooms.length) || (j < 0) || (j >= rooms[0].length) || (rooms[i][j] < d)
    rooms[i][j] = d
    walls_and_gates_dfs(rooms, i - 1, j, d + 1)
    walls_and_gates_dfs(rooms, i + 1, j, d + 1)
    walls_and_gates_dfs(rooms, i, j - 1, d + 1)
    walls_and_gates_dfs(rooms, i, j + 1, d + 1)
  end

  # Question 525: Contiguous Array
  # @param {Integer[]} nums
  # @return {Integer}
  def find_max_length(nums)
    hash = { 0 => 0 }
    max = count = 0
    nums.each_with_index do |val, index|
      val.zero? ? count -= 1 : count += 1
      hash.key?(count) ? max = [max, index + 1 - hash[count]].max : hash[count] = index + 1
    end
    max
  end

  # Question 325: Maximum Size Subarray Sum Equals k
  # @param {Integer[]} nums
  # @param {Integer} k
  # @return {Integer}
  def max_sub_array_len(nums, k)
    hash = {}
    max = count = 0
    nums.each_with_index do |val, index|
      count += val
      max = [max, index + 1].max if count == k
      max = [max, index - hash[count - k]].max if hash.key?(count - k)
      hash[count] = index unless hash.key?(count)
    end
    max
  end

  # Definition for a binary tree node.
  # class TreeNode
  #     attr_accessor :val, :left, :right
  #     def initialize(val)
  #         @val = val
  #         @left, @right = nil, nil
  #     end
  # end

  # @param {TreeNode} s
  # @param {TreeNode} t
  # @return {Boolean}
  def is_subtree(s, t)
    return false if s.nil?
    return true if same?(s, t)
    is_subtree(s.left, t) || is_subtree(s.right, t)
  end

  def same?(s, t)
    return true if s.nil? && t.nil?
    return false if s.nil? || t.nil?
    (s.val == t.val) && same?(s.left, t.left) && same?(s.right, t.right)
  end

  # Question 285: Inorder Successor in BST
  # @param {TreeNode} root
  # @param {TreeNode} p
  # @return {TreeNode}
  def inorder_successor(root, p)
    return if root.nil?
    return inorder_successor(root.right, p) if root.val <= p.val
    left = inorder_successor(root.left, p)
    left.nil? ? root : left
  end

  # Question 8: atoi
  # @param {String} str
  # @return {Integer}
  def my_atoi(str)
    sign = 1
    str.strip!
    if str[0] == '-' || str[0] == '+'
      sign = -1 if str[0] == '-'
      str.slice!(0)
    end
    cap_integer(sign * construct_integer(str))
  end

  def cap_integer(number)
    [-2**31, [number, 2**31 - 1].min].max
  end

  def construct_integer(str)
    res = 0
    str.each_char do |a|
      break unless numeric?(a)
      res = 10 * res + a.ord - '0'.ord
    end
    res
  end

  def numeric?(char)
    digit = char.ord - '0'.ord
    digit >= 0 && digit <= 9
  end

  # Question 226: Invert Binary tree
  # @param {TreeNode} root
  # @return {TreeNode}
  def invert_tree(root)
    return unless root
    swap_children(root)
    invert_tree(root.left)
    invert_tree(root.right)
    root
  end

  def swap_children(root)
    temp = root.right
    root.right = root.left
    root.left = temp
    root
  end

  # Question 637: Average levels of a binary tree
  # @param {TreeNode} root
  # @return {Float[]}
  def average_of_levels(root)
    return unless root
    res = []
    average_of_levels_dfs(root, res, 0)
    res.collect { |ind| ind[0].to_f / ind[1] }
  end

  def average_of_levels_dfs(root, res, index)
    return unless root
    res[index] = [0, 0] unless res[index]
    res[index][0] += root.val
    res[index][1] += 1
    average_of_levels_dfs(root.left, res, index + 1)
    average_of_levels_dfs(root.right, res, index + 1)
  end

  # @param {Integer[][]} a
  # @param {Integer[][]} b
  # @return {Integer[][]}
  def multiply(a, b)
    c = Array.new(a.length) { Array.new(b[0].length, 0) }
    (0..a.length - 1).each do |i|
      (0..a[0].length - 1).each do |k|
        next if a[i][k].zero?
        (0..b[0].length - 1).each do |j|
          c[i][j] += a[i][k] * b[k][j] unless b[k][j].zero?
        end
      end
    end
    c
  end

  # Question 314: Vertical order traversal
  # @param {TreeNode} root
  # @return {Integer[][]}
  def vertical_order(root)
    return [] unless root

    min_max = [0, 0]
    q = Queue.new
    cols = Queue.new

    q << root
    cols << 0

    hash = vertical_order_bfs(q, cols, min_max)
    rearrange_bfs_hash(hash, min_max)
  end

  def rearrange_bfs_hash(hash, min_max)
    res = []
    (min_max[0]..min_max[1]).each do |i|
      res << hash[i]
    end
    res
  end

  def vertical_order_bfs(q, cols, min_max)
    hash = {}

    until q.empty?
      root = q.pop
      col = cols.pop

      add_col_to_hash(hash, col, root)

      add_left_child(q, cols, col, root, min_max) if root.left

      add_right_child(q, cols, col, root, min_max) if root.right
    end

    hash
  end

  def add_col_to_hash(hash, col, root)
    hash[col] = [] unless hash.key?(col)
    hash[col] << root.val
  end

  def add_left_child(q, cols, col, root, min_max)
    q << root.left
    cols << col - 1
    min_max[0] = [min_max[0], col - 1].min
  end

  def add_right_child(q, cols, col, root, min_max)
    q << root.right
    cols << col + 1
    min_max[1] = [min_max[1], col + 1].max
  end

end


