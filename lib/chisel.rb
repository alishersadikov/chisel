require_relative 'converter'
class Chisel

  markdown_file = ARGV[0]
  html_file = ARGV[1]

  markdown = File.read(markdown_file)
  html = Converter.new(markdown).convert_to_html

  File.write(html_file, html)

  puts "Converted #{markdown_file} (#{markdown.lines.count} lines) to #{html_file} (#{html.lines.count} lines)"
end
