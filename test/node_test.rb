require './test/test_helper'
require './lib/node'

class NodeTest < Minitest::Test
  def test_it_has_all_attributes_of_a_node
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    assert_instance_of ScoreMovie, node.data
    assert_equal nil, node.left
    assert_equal nil, node.right
  end

  def test_it_knows_its_score
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    assert_equal 50, node.score
  end

  def test_it_knows_its_movie
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    assert_equal "Hannibal Buress: Animal Furnace", node.movie
  end

  def test_it_knows_if_it_has_children_nodes
    node = Node.new(50, "Hannibal Buress: Animal Furnace")
    assert_equal false, node.left_full?
    assert_equal false, node.right_full?
    assert_equal false, node.has_children?
  end

  def test_it_can_be_assigned_a_child
    node_1 = Node.new(50, "Hannibal Buress: Animal Furnace")
    node_2 = Node.new(50, "Hannibal Buress: Animal Furnace")

    node_1.left = node_2

    assert_equal node_2, node_1.left
  end

end
