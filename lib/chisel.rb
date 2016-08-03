require_relative 'header'
require_relative 'paragraph'
require_relative 'list'

class Chisel

  def initialize(markdown)
    @markdown = markdown
    @header = Header.new("")
    @list = List.new("")
    @paragraph = Paragraph.new("")
  end

  def to_html
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

  if $PROGRAM_NAME == __FILE__
      markdown_file = ARGV[0]
      html_file = ARGV[1]

      markdown = File.read(markdown_file)
      html = Chisel.new(markdown).to_html

      File.write(html_file, html)

      puts "Converted #{markdown_file} (#{markdown.lines.count} lines) to #{html_file} (#{html.lines.count} lines)"
  end
end
