# Module that can be included (mixin) to take and output TSV data
require 'yaml'
# document
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  attr_accessor :data

  def take_tsv(tsv)
    rows = tsv.split("\n").map { |line| line.split("\t") }
    head = rows[0]
    data_row = rows[1..-1]
    @data = rows_to_table(head, data_row)
  end

  def rows_to_table(head, data_row)
    table = []
    data_row.each do |line|
      table << line_to_table(head, line)
    end
    table
  end

  def line_to_table(head, data_line)
    table = {}
    data_line.each.with_index do |line, i|
      table[head[i]] = line
    end
    table
  end

  def to_tsv
    str = @data.first.keys.join("\t")
    str << "\n" << value2string(@data)
  end

  def value2string(data)
    str = ''
    data.each do |line|
      str << line.values.join("\t") << "\n"
    end
    str
  end
end
