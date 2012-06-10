require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Importex::Base do
  before(:each) do
    @simple_class = Class.new(Importex::Base)
    @xls_file = File.dirname(__FILE__) + '/../fixtures/simple.xls'
  end
  
  it "should import simple excel doc" do
    @simple_class.column "Name"
    @simple_class.column "Age", :type => Integer
    @simple_class.import(@xls_file)
    @simple_class.all.map(&:attributes).should == [{"Name" => "Foo", "Age" => 27}, {"Name" => "Bar", "Age" => 42}]
  end
  
  it "should import only the column given and ignore others" do
    @simple_class.column "Age", :type => Integer
    @simple_class.column "Nothing"
    @simple_class.import(@xls_file)
    @simple_class.all.map(&:attributes).should == [{"Age" => 27}, {"Age" => 42}]
  end
  
  it "should add restrictions through an array of strings or regular expressions" do
    @simple_class.column "Age", :format => ["foo", /bar/]
    lambda {
      @simple_class.import(@xls_file)
    }.should raise_error(Importex::InvalidCell, '27.0 (column Age, row 2) does not match required format: ["foo", /bar/]')
  end
  
  it "should support a lambda as a requirement" do
    @simple_class.column "Age", :format => lambda { |age| age.to_i < 30 }
    lambda {
      @simple_class.import(@xls_file)
    }.should raise_error(Importex::InvalidCell, '42.0 (column Age, row 3) does not match required format: []')
  end
  
  it "should have some default requirements" do
    @simple_class.column "Name", :type => Integer
    lambda {
      @simple_class.import(@xls_file)
    }.should raise_error(Importex::InvalidCell, 'Foo (column Name, row 2) does not match required format: Not a Integer.')
  end
  
  it "should have a [] method which returns attributes" do
    simple = @simple_class.new("Foo" => "Bar")
    simple["Foo"].should == "Bar"
  end
  
  it "should import if it matches one of the requirements given in array" do
    @simple_class.column "Age", :type => Integer, :format => ["", /^[.\d]+$/]
    @simple_class.import(@xls_file)
    @simple_class.all.map(&:attributes).should == [{"Age" => 27}, {"Age" => 42}]
  end
  
  it "should raise an exception if required column is missing" do
    @simple_class.column "Age", :required => true
    @simple_class.column "Foo", :required => true
    lambda {
      @simple_class.import(@xls_file)
    }.should raise_error(Importex::MissingColumn, "Columns Foo is/are required but it doesn't exist in Age.")
  end
end
