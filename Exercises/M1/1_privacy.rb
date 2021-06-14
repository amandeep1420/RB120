class Machine
  def initialize
    @switch = :null
  end
  
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end
  
  def view_state
    p switch
  end
  
  private

  attr_writer :switch
  attr_reader :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

pascal = Machine.new

pascal.start
pascal.view_state
pascal.stop
pascal.view_state