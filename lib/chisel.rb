require 'pry'
class Chisel

  def initialize(markdown)
    @markdown = markdown
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
    return header_to_html(markdown_chunk) if header?(markdown_chunk)
    return un_list_to_html(markdown_chunk) if unordered_list?(markdown_chunk)
    return or_list_to_html(markdown_chunk) if ordered_list?(markdown_chunk)
    return paragraph_to_html(markdown_chunk)
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

  def header_to_html(markdown_chunk)
    #remove the leading hashes and space
    first_char = 1 + markdown_chunk.index(' ')
    last_char = -1
    header_text = markdown_chunk[first_char..last_char]
    #wrap it with the tag
    level = first_char - 1
    "<h#{level}>#{header_text}</h#{level}>"
  end

  def un_list_to_html(markdown_chunk)
    markdown_lines = markdown_chunk.split("\n")
    html_lines = markdown_lines.map do |line|
      "\t<li>#{line[2..-1]}</li>\n"
    end
    "<ul>\n#{html_lines.join}</ul>"
  end

  def or_list_to_html(markdown_chunk)
    markdown_lines = markdown_chunk.split("\n")
    html_lines = markdown_lines.map do |line|
      "\t<li>#{line[2..-1]}</li>\n"
    end
    "<ol>\n#{html_lines.join}</ol>"
  end

  def paragraph_to_html(markdown_chunk)
    "<p>\n#{indent(text_to_html(markdown_chunk))}</p>"
  end

  def indent(string)
    string.lines .map { |line| "  #{line.chomp}\n"}.join
  end

  def text_to_html(text)
    text.gsub("**").with_index { |_, index| "<#{'/' if index.odd?}strong>"}
    .gsub("*").with_index { |dont_care, index| "<#{'/' if index.odd?}em>"}
    .gsub("&", "&amp;")
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
# require_relative 'converter'
# class Chisel
#
# # $ ruby ./lib/chisel.rb my_input.markdown my_output.html
# # Converted my_input.markdown (6 lines) to my_output.html (8 lines)
#
#
#   input_file = ARGV[0] #my_input.md
#   output_file = ARGV[1] #my_output.html
#
#   converter = Converter.new
#
#   input_string = File.read(input_file)
#
#   converted_text = converter.convert(input_string)
#   File.write(output_file, converted_text)
#
#   output_string = File.read(output_file)
#
#   puts "Converted #{input_file} (#{input_string.lines.count} lines) to #{output_file} (#{output_string.lines.count} lines)"
#
# end
