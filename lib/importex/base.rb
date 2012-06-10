module Importex
  class Base
    attr_reader :attributes
    
    # Defines a column that may be found in the excel document. The first argument is a string
    # representing the name of the column. The second argument is a hash of options.
    # 
    # Options:
    # [:+type+]
    #   The Ruby class to be used as the value on import.
    #   
    #     column :type => Date
    #   
    # [:+format+]
    #   Usually a regular expression representing the required format for the value. Can also be a string
    #   or an array of strings and regular expressions.
    #   
    #     column :format => [/^\d+$/, "0.0"]
    #   
    # [:+required+]
    #   Boolean specifying whether or not the given column must be present in the Excel document.
    #   Defaults to false.
    def self.column(*args)
      @columns ||= []
      @columns << Column.new(*args)
    end
    
    # Pass a path to an Excel (xls) document and optionally the worksheet index. The worksheet
    # will default to the first one (0). The first row in the Excel document should be the column
    # names, all rows after that should be records.
    def self.import(path, worksheet_index = 0)
      @records ||= []
      workbook = Spreadsheet.open(path)
      worksheet = workbook.worksheet(worksheet_index)

      columns = worksheet.row(0).map do |cell|
        @columns.detect { |column| column.name == cell.to_s }
      end

      missing_columns = @columns.select(&:required?) - columns

      raise MissingColumn, "Columns #{missing_columns.map(&:name).join(",")} is/are required but it doesn't exist in #{columns.compact.map(&:name).join(",")}." unless missing_columns.blank?
      
      (1...worksheet.row_count).each do |row_number|
        row = worksheet.row(row_number)
        unless row.at(0).nil?
          attributes = {}
          columns.each_with_index do |column, index|
            if column
              if row.at(index).nil?
                value = ""
              elsif row.at(index).class == :date
                value = row.at(index).date.strftime("%Y-%m-%d %H:%M:%I")
              else
                value = row.at(index)
              end
              attributes[column.name] = column.cell_value(value, row_number)
            end
          end
          @records << new(attributes)
        end
      end
    end
    
    # Returns all records imported from the excel document.
    def self.all
      @records
    end
    
    def initialize(attributes = {})
      @attributes = attributes
    end
    
    # A convenient way to access the column data for a given record.
    # 
    #   product["Price"]
    # 
    def [](name)
      @attributes[name]
    end
  end
end
