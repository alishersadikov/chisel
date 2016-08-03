require 'minitest/autorun'
require 'minitest/pride'
require './lib/list'

class ListTest < Minitest::Test
  def test_it_converts_unordered_lists
    expected = "<ul>\n\t<li>Sushi</li>\n\t<li>Barbeque</li>\n\t<li>Mexican</li>\n</ul>"
    actual = List.new("").un_list_to_html("* Sushi\n* Barbeque\n* Mexican")
    assert_equal expected, actual
  end

  def test_it_converts_ordered_lists
    expected = "<ol>\n\t<li>Sushi</li>\n\t<li>Barbeque</li>\n\t<li>Mexican</li>\n</ol>"
    actual = List.new("").or_list_to_html("* Sushi\n* Barbeque\n* Mexican")
    assert_equal expected, actual
  end
end
