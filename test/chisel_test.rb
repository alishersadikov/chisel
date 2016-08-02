require 'minitest/autorun'
require 'minitest/pride'
require './lib/chisel'

class ChiselTest < Minitest::Test
  def string_to_chunks(string)
    Chisel.new("").string_to_chunks(string)
  end

  def chunk_to_html(chunk)
    Chisel.new("").chunk_to_html(chunk)
  end

  def test_it_considers_blank_lines_to_delimit_chunks
    assert_equal ["a\nb", "c", "d"],
                  string_to_chunks("a\nb\n\nc\n\n\nd")
  end

  def test_it_converts_chunks_beginning_with_hashes_to_headersof_that_level
    assert_equal "<h1>abc # def</h1>", chunk_to_html("# abc # def")

    assert_equal "<h1>a</h1>", chunk_to_html("# a")
    assert_equal "<h2>a</h2>", chunk_to_html("## a")
    assert_equal "<h3>a</h3>", chunk_to_html("### a")
    assert_equal "<h4>a</h4>", chunk_to_html("#### a")
    assert_equal "<h5>a</h5>", chunk_to_html("##### a")
    assert_equal "<h6>a</h6>", chunk_to_html("###### a")
  end

  def test_it_converts_every_other_kind_of_chunk_into_characters
    assert_equal "<p>\n  line 1\n  line 2\n</p>", chunk_to_html("line 1\nline 2")
  end

  def test_it_converts_em_tags
    expected = "My <em>emphasized text</em> is awesome"
    actual = Chisel.new("").text_to_html("My *emphasized text* is awesome")
    assert_equal expected, actual
  end
  #My *emphasized and **stronged** text* is awesome.

  def test_it_converts_strong_tags
    expected = "My <strong>stronged text</strong> is awesome"
    actual = Chisel.new("").text_to_html("My **stronged text** is awesome")
    assert_equal expected, actual
  end

  def test_it_converts_both_em_and_strong_tages
    expected = "My <em>emphasized and <strong>stronged</strong> text</em> is awesome"
    actual = Chisel.new("").text_to_html("My *emphasized and **stronged** text* is awesome")
    assert_equal expected, actual
  end

  def test_it_converts_unordered_lists
    expected = "<ul>\n\t<li>Sushi</li>\n\t<li>Barbeque</li>\n\t<li>Mexican</li>\n</ul>"
    actual = Chisel.new("").un_list_to_html("* Sushi\n* Barbeque\n* Mexican")
    assert_equal expected, actual
  end

  def test_it_converts_ordered_lists
    expected = "<ol>\n\t<li>Sushi</li>\n\t<li>Barbeque</li>\n\t<li>Mexican</li>\n</ol>"
    actual = Chisel.new("").or_list_to_html("* Sushi\n* Barbeque\n* Mexican")
    assert_equal expected, actual
  end
end
