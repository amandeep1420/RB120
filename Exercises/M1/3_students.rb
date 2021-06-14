class Student
  def initialize(name='unregistered', year='unregistered')
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student; end

class UnregisteredStudent < Student
  def initialize
    super()
  end
end