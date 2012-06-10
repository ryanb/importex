class Integer
  def self.importex_value(str)
    unless str.blank?
      if ((str =~ /^[\.\d]+$/) || (str.is_a?(Integer)) || (str.is_a?(Float))) && (str.to_f.to_i == str.to_i)
        str.to_i
      else
        raise Importex::InvalidCell, "Not a Integer."
      end
    end
  end
end

class Float
  def self.importex_value(str)
    unless str.blank?
      if ((str =~ /^[\.\d]+$/) || (str.is_a?(Integer)) || (str.is_a?(Float)))
        str.to_f
      else
        raise Importex::InvalidCell, "Not a Float."
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
    raise Importex::InvalidCell, "Not a Time."
  end
end

class Date
  def self.importex_value(str)
    Date.parse(str) unless str.blank?
  rescue ArgumentError
    raise Importex::InvalidCell, "Not a Date."
  end
end
