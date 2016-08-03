require_relative 'header'
require_relative 'paragraph'
require_relative 'list'

class Converter

  def initialize(markdown)
    @markdown = markdown
    @header = Header.new("")
    @list = List.new("")
    @paragraph = Paragraph.new("")
  end

  def convert_to_html
    html_chunks = string_to_chunks(@markdown).map do |chunk|
      chunk_to_html(chunk)
    end
    chunks_to_string(html_chunks)
  end

  def string_to_chunks(string)
    string.split(/\n\n+/)
  end

  def chunks_to_string(html_chunks)
    html_chunks.join("\n\n") << "\n"
  end

  def chunk_to_html(markdown_chunk)
    return @header.header_to_html(markdown_chunk) if header?(markdown_chunk)
    return @list.un_list_to_html(markdown_chunk) if unordered_list?(markdown_chunk)
    return @list.or_list_to_html(markdown_chunk) if ordered_list?(markdown_chunk)
    return @paragraph.paragraph_to_html(markdown_chunk)
  end

  def header?(chunk)
    chunk[0] == '#'
  end

  def unordered_list?(chunk)
    chunk[0..1] == "* "
  end

  def ordered_list?(chunk)
    chunk[0..1] == "1."
  end
end
