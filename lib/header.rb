class Header

  def initialize(chunk)
    @chunk = chunk
  end

  def header_to_html(markdown_chunk)
    first_char = 1 + markdown_chunk.index(' ')
    header_text = markdown_chunk[first_char..-1]
    level = first_char - 1
    "<h#{level}>#{header_text}</h#{level}>"
  end
end
