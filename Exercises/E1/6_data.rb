class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    create_database_handle
    @flight_number = flight_number
  end
  
  def create_database_handle
    @database_handle = Database.init
  end
end