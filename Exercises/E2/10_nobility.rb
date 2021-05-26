module Walk
  def walk
    "#{self.name} #{gait} forward"
  end
end

class Person
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title
  
  def initialize(name, title)
    super(name)
    @title = title
  end
  
  def walk
    title + " " + super
  end
  
  private
  
  def gait
    "struts"
  end
end

class Cat
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

byron = Noble.new("Byron", "Lord")
p byron.walk

p byron.name
#=> "Byron"
p byron.title
#=> "Lord"