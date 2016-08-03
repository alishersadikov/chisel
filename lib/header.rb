class Header
  def initialize(markdown_chunk)
    @markdown_chunk = markdown_chunk
  end

  def header_to_html(markdown_chunk)
    first_char = 1 + markdown_chunk.index(' ')
    header_text = markdown_chunk[first_char..-1]
    level = first_char - 1
    "<h#{level}>#{text_to_html(header_text)}</h#{level}>"
  end

  def text_to_html(text)
    text.gsub("**").with_index { |_, index| "<#{'/' if index.odd?}strong>"}
    .gsub("*").with_index { |_, index| "<#{'/' if index.odd?}em>"}
    .gsub("&", "&amp;")
  end

end
