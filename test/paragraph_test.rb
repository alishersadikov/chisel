require './test/test_helper'
require './lib/paragraph'

class ParagraphTest < Minitest::Test
  def test_it_indents_the_lines_by_two_spaces
    expected = "  line 1\n  line 2\n"
    actual = Paragraph.new("").indent("line 1\nline 2")
    assert_equal expected, actual
  end

  def test_it_converts_em_tags
    expected = "My <em>emphasized text</em> is awesome"
    actual = Paragraph.new("").text_to_html("My *emphasized text* is awesome")
    assert_equal expected, actual
  end

  def test_it_converts_strong_tags
    expected = "My <strong>stronged text</strong> is awesome"
    actual = Paragraph.new("").text_to_html("My **stronged text** is awesome")
    assert_equal expected, actual
  end

  def test_it_converts_both_em_and_strong_tages
    expected = "My <em>emphasized and <strong>stronged</strong> text</em> is awesome"
    actual = Paragraph.new("").text_to_html("My *emphasized and **stronged** text* is awesome")
    assert_equal expected, actual
  end

  def test_it_converts_paragraph_chunks
    expected = "<p>\n  line 1\n  line 2\n</p>"
    actual = Paragraph.new("").paragraph_to_html("line 1\nline 2")
    assert_equal expected, actual
  end
end
