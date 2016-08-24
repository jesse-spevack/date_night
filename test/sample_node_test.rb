require 'minitest/autorun'
require './lib/sample_node'

class SampleNodeTest < Minitest::Test

  def test_node_holds_data
    node = Node.new(61, "Bill and Ted")

    assert_equal [61, "Bill and Ted"], node.data
  end
end
