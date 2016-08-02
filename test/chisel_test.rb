require 'minitest/autorun'
require 'minitest/pride'
require './lib/chisel'

class ChiselTest < Minitest::Test
  def test_it_converts_markdown_to_html
    skip
    markdown =
    '# My Life in Desserts

    ## Chapter 1: The Beginning

    "You just *have* to try the cheesecake," he said. "Ever since it appeared in
    **Food & Wine** this place has been packed every night."'

    expected_html =
    '<h1>My Life in Desserts</h1>

    <h2>Chapter 1: The Beginning</h2>

    <p>
      "You just <em>have</em> to try the cheesecake," he said. "Ever since it appeared in
      <strong>Food &amp; Wine</strong> this place has been packed every night."
    </p>'
    actual_html = Chisel.new(markdown).to_html
    assert_equal expected_html, actual_html
  end

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

  def test_it_converts_every_kind_of_chunk_into_characters
    assert_equal "<p>\n  line 1\n  line 2\n</p>", chunk_to_html("line 1\nline 2")
  end
end
