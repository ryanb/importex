module Importex
  class Base
    attr_reader :attributes
    
    def self.column(*args)
      @columns ||= []
      @columns << Column.new(*args)
    end
    
    def self.import(path, worksheet_index = 0)
      @records ||= []
      workbook = Spreadsheet::ParseExcel.parse(path)
      worksheet = workbook.worksheet(worksheet_index)
      columns = worksheet.row(0).map do |cell|
        @columns.detect { |column| column.name == cell.to_s('latin1') }
      end
      (@columns.select(&:required?) - columns).each do |column|
        raise MissingColumn, "Column #{column.name} is required but it doesn't exist."
      end
      (1...worksheet.num_rows).each do |row_number|
        row = worksheet.row(row_number)
        unless row.at(0).nil?
          attributes = {}
          columns.each_with_index do |column, index|
            if column
              if row.at(index).nil?
                value = ""
              elsif row.at(index).type == :date
                value = row.at(index).date.strftime("%Y-%m-%d %H:%M:%I")
              else
                value = row.at(index).to_s('latin1')
              end
              attributes[column.name] = column.cell_value(value, row_number)
            end
          end
          @records << new(attributes)
        end
      end
    end
    
    def self.all
      @records
    end
    
    def initialize(attributes = {})
      @attributes = attributes
    end
    
    def [](name)
      @attributes[name]
    end
  end
end
