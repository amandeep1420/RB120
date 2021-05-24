class Transform
  attr_reader :string
  
  def self.lowercase(string)
    string.downcase
  end
  
  def initialize(string)
    @string = string
  end
  
  def uppercase
    string.upcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

