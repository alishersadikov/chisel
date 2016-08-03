require './test/test_helper'
require './lib/list'

class ListTest < Minitest::Test
  def test_it_converts_unordered_lists
    expected = "<ul>\n\t<li>Sushi</li>\n\t<li>Barbeque</li>\n\t<li>Mexican</li>\n</ul>"
    actual = List.new("").un_list_to_html("* Sushi\n* Barbeque\n* Mexican")
    assert_equal expected, actual
  end

  def test_it_converts_ordered_lists
    expected = "<ol>\n\t<li>Sushi</li>\n\t<li>Barbeque</li>\n\t<li>Mexican</li>\n</ol>"
    actual = List.new("").or_list_to_html("1. Sushi\n2. Barbeque\n3. Mexican")
    assert_equal expected, actual
  end

  def test_it_handles_em_and_strong_tags_in_unordered_list
    expected = "<ul>\n\t<li><em>Sushi</em></li>\n\t<li><em>Barbeque</em></li>\n</ul>"
    actual = List.new("").un_list_to_html("* *Sushi*\n* *Barbeque*")
    assert_equal expected, actual
    
    expected = "<ul>\n\t<li><strong>Sushi</strong></li>\n\t<li><strong>Barbeque</strong></li>\n</ul>"
    actual = List.new("").un_list_to_html("* **Sushi**\n* **Barbeque**")
    assert_equal expected, actual
  end

  def test_it_handles_em_and_strong_tags_in_ordered_list
    expected = "<ol>\n\t<li><em>Sushi</em></li>\n\t<li><em>Barbeque</em></li>\n</ol>"
    actual = List.new("").or_list_to_html("1. *Sushi*\n2. *Barbeque*")
    assert_equal expected, actual

    expected = "<ol>\n\t<li><strong>Sushi</strong></li>\n\t<li><strong>Barbeque</strong></li>\n</ol>"
    actual = List.new("").or_list_to_html("1. **Sushi**\n2. **Barbeque**")
    assert_equal expected, actual
  end
end
