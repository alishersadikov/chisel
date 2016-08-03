require './test/test_helper'
require './lib/header'

class HeaderTest < Minitest::Test

  def header_to_html(chunk)
    Header.new("").header_to_html(chunk)
  end

  def test_it_converts_chunks_beginning_with_hashes_to_headers_of_corresponding_level
    assert_equal "<h1>a</h1>", header_to_html("# a")
    assert_equal "<h2>a</h2>", header_to_html("## a")
    assert_equal "<h3>a</h3>", header_to_html("### a")
    assert_equal "<h4>a</h4>", header_to_html("#### a")
    assert_equal "<h5>a</h5>", header_to_html("##### a")
    assert_equal "<h6>a</h6>", header_to_html("###### a")
  end

  def test_it_converts_only_header_hashes_and_leaves_the_rest
    assert_equal "<h1>abc # def</h1>", header_to_html("# abc # def")
  end

  def test_it_handles_em_and_strong_tags_in_the_header
    assert_equal "<h1><em>a</em></h1>", header_to_html("# *a*")
    assert_equal "<h2><strong>a</strong></h2>", header_to_html("## **a**")
  end
end
