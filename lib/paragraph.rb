class Paragraph
  def initialize(markdown_chunk)
    @markdown_chunk = markdown_chunk
  end

  def paragraph_to_html(markdown_chunk)
    "<p>\n#{indent(text_to_html(markdown_chunk))}</p>"
  end

  def indent(string)
    string.lines .map { |line| "  #{line.chomp}\n"}.join
  end

  def text_to_html(text)
    text.gsub("**").with_index { |_, index| "<#{'/' if index.odd?}strong>"}
    .gsub("*").with_index { |_, index| "<#{'/' if index.odd?}em>"}
    .gsub("&", "&amp;")
  end
end
