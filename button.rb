module Button

  def self.left?
    Gosu::button_down?(Gosu::KB_A)
  end

  def self.right?
    Gosu::button_down?(Gosu::KB_D)
  end

  def self.space?
    Gosu::button_down?(Gosu::KB_SPACE)
  end

end
