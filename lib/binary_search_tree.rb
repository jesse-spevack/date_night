require './lib/node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root
  end

  def traverse_insert(node, score, movie)
    traverse_insert(node.left, score, movie)   if traverse_left?(node, score)
    traverse_insert(node.right, score, movie)  if traverse_right?(node, score)
    node.left = Node.new(score, movie)         if place_left?(node, score)
    node.right = Node.new(score, movie)        if place_right?(node, score)
  end

  def insert(score, movie)
    @root.nil? ? set_root_to_new_node(score, movie) : traverse_insert(@root, score, movie)
    depth_of(score)
  end

  def traverse_depth(node, score, depth)
    if node.score == score
      return depth
    elsif node.score > score
      traverse_depth(node.left, score, depth += 1)
    elsif node.score < score
      traverse_depth(node.right, score, depth += 1)
    end
  end

  def depth_of(score)
    traverse_depth(@root, score, 0)
  end

  def include?(score, node=@root)
    if node.score == score
      return true
    elsif node.score > score
      return false unless node.left_full?
      include?(score, node.left)
    elsif node.score < score
      return false unless node.right_full?
      include?(score, node.right)
    end
  end

  def max(node=@root)
    if node.right_full?
      max(node.right)
    else
      {node.movie => node.score}
    end
  end

  def min(node=@root)
    if node.left_full?
      min(node.left)
    else
      {node.movie => node.score}
    end
  end

  def all(node=@root, nodes_depth=[{:node => @root, :depth => 0}])
    if node.left_full?
      nodes_depth << { :node => node.left, :depth => depth_of(node.left.score) }
      all(node.left, nodes_depth)
    end
    if node.right_full?
      nodes_depth << { :node => node.right, :depth => depth_of(node.right.score) }
      all(node.right, nodes_depth)
    end
    return nodes_depth
  end

  def total
    all.count
  end

  def sort_nodes
    all.sort_by do |node_depth|
      node_depth[:node].score
    end
  end

  def sort
    sort_nodes.map do |node_depth|
      node = node_depth[:node]
      {node.movie => node.score}
    end
  end

  def load(file_path)
    File.open(file_path, "r") do |file|
      file.each_line do |line|
        movie_score = line.chomp.split(", ")
        insert(movie_score[0], movie_score[1])
      end
    end
    all.length
  end

  def get_nodes_at_depth(depth)
    all.reduce([]) do |nodes, node_depth|
      if node_depth[:depth] == depth
        nodes << node_depth[:node]
      end
      nodes
    end
  end

  def find_node_with_score(score)
    all.find do |node_depth|
      node_depth[:node].score == score
    end[:node]
  end

  def count_nodes_at_and_below_node_with_score(score)
    all(find_node_with_score(score)).count
  end

  def percent_of_tree_below_node_with_score(score)
    ((count_nodes_at_and_below_node_with_score(score) / all.count.to_f) * 100).to_i
  end

  def health(depth)
    get_nodes_at_depth(depth).map do |node|
      [node.score, 
       count_nodes_at_and_below_node_with_score(node.score),
       percent_of_tree_below_node_with_score(node.score)]
     end
  end

  private

  def set_root_to_new_node(score, movie)
    @root = Node.new(score, movie)
  end

  def traverse_left?(node, score)
    node.score > score && node.left_full?
  end

  def traverse_right?(node, score)
    node.score < score && node.right_full?
  end

  def place_left?(node, score)
    node.score > score && !node.left_full?
  end

  def place_right?(node, score)
    node.score < score && !node.right_full?
  end


end
