require './test/test_helper'
require './lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test

  attr_reader :tree

  def setup
    @tree = BinarySearchTree.new
  end

  def test_it_can_traverse_right
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    tree.traverse_insert(node, 60, "Johnny English")

    assert_equal Node, node.right.class
  end

  def test_it_can_traverse_left
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    tree.traverse_insert(node, 16, "Johnny English")

    assert_equal Node, node.left.class
  end

  def test_it_can_traverse_right_then_left
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    tree.traverse_insert(node, 92, "Sharknado 3")
    tree.traverse_insert(node, 61, "Bill & Ted's Excellent Adventure")

    assert_equal Node, node.right.left.class
  end

  def test_it_can_traverse_left_then_right
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    tree.traverse_insert(node, 16, "Johnny English")
    tree.traverse_insert(node, 45, "Bill & Ted's Excellent Adventure")

    assert_equal Node, node.left.right.class
  end

  def test_it_can_find_depth_of_score
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    tree.insert(16, "Johnny English")
    tree.insert(45, "Bill & Ted's Excellent Adventure")

    assert_equal 0, tree.depth_of(50)
    assert_equal 1, tree.depth_of(16)
    assert_equal 2, tree.depth_of(45)
  end

  def test_it_can_traverse_depth
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    tree.traverse_insert(node, 16, "Johnny English")
    tree.traverse_insert(node, 45, "Bill & Ted's Excellent Adventure")

    assert_equal 0, tree.traverse_depth(node, 50, 0)
    assert_equal 1, tree.traverse_depth(node, 16, 0)
    assert_equal 2, tree.traverse_depth(node, 45, 0)
  end

  def test_it_can_insert
    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")
  end

  def test_it_knows_if_it_includes_a_score
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal true, tree.include?(50)
    assert_equal false, tree.include?(99)
  end

  def insert_four_score_movies
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
  end

  def test_it_knows_max
    insert_four_score_movies
    expected = {"Sharknado 3"=>92}

    assert_equal expected, tree.max
  end

  def test_it_knows_min
    insert_four_score_movies
    expected = {"Johnny English"=>16}

    assert_equal expected, tree.min
  end

  def test_it_can_traverse_all_nodes
    insert_four_score_movies
    thing = tree.all
    assert_equal 4, tree.all.length
  end

  def test_it_can_sort_nodes
    insert_four_score_movies
    sorted_nodes = tree.sort_nodes
    assert_equal 4, sorted_nodes.length
    sorted_nodes.each { |node| assert_instance_of Node, node[:node] }
  end

  def test_it_can_sort
    insert_four_score_movies
    expected = [{"Johnny English"=>16},
                {"Hannibal Buress: Animal Furnace"=>50},
                {"Bill & Ted's Excellent Adventure"=>61},
                {"Sharknado 3"=>92}]

    assert_equal expected, tree.sort
  end

  def test_it_can_load_txt_files
    assert_equal 6, tree.load('sample.txt')
  end

  def test_knows_total_nodes
    insert_four_score_movies
    assert_equal 4, tree.total
  end

  def insert_seven_score_movies
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
  end

  def test_it_can_get_all_nodes_at_a_given_depth
    insert_seven_score_movies

    nodes_at_0 = tree.get_nodes_at_depth(0)
    nodes_at_1 = tree.get_nodes_at_depth(1)
    nodes_at_2 = tree.get_nodes_at_depth(2)

    assert_equal 98, nodes_at_0.first.score
    assert_equal 58, nodes_at_1.first.score
    assert_equal 36, nodes_at_2.first.score
    assert_equal 93, nodes_at_2.last.score
  end

  def test_find_node_with_score
    insert_seven_score_movies
    assert_instance_of Node, tree.find_node_with_score(98)
  end

  def test_it_can_get_count_nodes_at_and_below_node_with_score
    insert_seven_score_movies

    assert_equal 7, tree.count_nodes_at_and_below_node_with_score(98)
    assert_equal 6, tree.count_nodes_at_and_below_node_with_score(58)
    assert_equal 2, tree.count_nodes_at_and_below_node_with_score(36)
    assert_equal 3, tree.count_nodes_at_and_below_node_with_score(93)
  end

  def test_it_can_get_percent_of_tree_under_node
    insert_seven_score_movies

    assert_equal 100, tree.percent_of_tree_below_node_with_score(98)
    assert_equal 85, tree.percent_of_tree_below_node_with_score(58)
    assert_equal 28, tree.percent_of_tree_below_node_with_score(36)
    assert_equal 42, tree.percent_of_tree_below_node_with_score(93)
  end

  def test_it_can_assess_tree_health
    insert_seven_score_movies

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  end
end
