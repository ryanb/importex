class Integer
  def self.importex_value(str)
    unless str.blank?
      if str =~ /^[.\d]+$/
        str.to_i
      else
        raise Importex::InvalidCell, "Not a number."
      end
    end
  end
end

class Float
  def self.importex_value(str)
    unless str.blank?
      if str =~ /^[.\d]+$/
        str.to_f
      else
        raise Importex::InvalidCell, "Not a number."
      end
    end
  end
end

class Boolean
  def self.importex_value(str)
    !["", "f", "F", "n", "N", "0"].include?(str)
  end
end

class Time
  def self.importex_value(str)
    Time.parse(str) unless str.blank?
  rescue ArgumentError
    raise Importex::InvalidCell, "Not a time."
  end
end

class Date
  def self.importex_value(str)
    Date.parse(str) unless str.blank?
  rescue ArgumentError
    raise Importex::InvalidCell, "Not a date."
  end
end
