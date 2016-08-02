class Converter

  def convert(input_file)
    lines_array = input_file.lines.map(&:chomp)

    lines_array.each do |index|
      if lines_array[index][0] = "#"
        lines_array[index][0] = "<h1>"
        lines_array[index] = "#{lines_array[index]</h1>}"
        return lines_array[index]
      else
        "Alisher"
      end
    end
  end

end
