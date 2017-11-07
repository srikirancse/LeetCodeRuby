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
    (0..nums.size - 1).step(2).each do |i|
      nums[i] = sorted[j]
      j += 1
    end
    j = 0
    (1..nums.size - 1).step(2).each do |i|
      nums[i] = sorted[j]
      j += 1
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

end

leetcode = Class.new { extend LeetCode }
leetcode.max_sub_array([-2,1,-3,4,-1,2,1,-5,4])