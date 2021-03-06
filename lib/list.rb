class List
  def initialize(markdown_chunk)
    @markdown_chunk = markdown_chunk
  end

  def un_list_to_html(markdown_chunk)
    markdown_lines = markdown_chunk.split("\n")
    html_lines = markdown_lines.map do |line|
      "\t<li>#{text_to_html(line[2..-1])}</li>\n"
    end
    "<ul>\n#{html_lines.join}</ul>"
  end

  def or_list_to_html(markdown_chunk)
    markdown_lines = markdown_chunk.split("\n")
    html_lines = markdown_lines.map do |line|
      "\t<li>#{text_to_html(line)[3..-1]}</li>\n"
    end
    "<ol>\n#{html_lines.join}</ol>"
  end

  def text_to_html(text)
    text.gsub("**").with_index { |_, index| "<#{'/' if index.odd?}strong>"}
    .gsub("*").with_index { |_, index| "<#{'/' if index.odd?}em>"}
    .gsub("&", "&amp;")
  end
end
