class Goody
  MIN_VELOCITY    = 7.8        # => 0.8 default
  MAX_VELOCITY    = 14.3       # => 3.3 default

  attr_reader :x,:y, :type

  def initialize(type)
    @type = type
    @image =
      if type == :apple
        Gosu::Image.new("assets/images/pomme_rouge73.png")
      elsif type == :merde
        Gosu::Image.new("assets/images/rainbow_shit97.png")
      end

    @velocity = Gosu::random(MIN_VELOCITY,MAX_VELOCITY)

    @x = rand * (WINDOW_WIDTH - @image.width)
    @y = 0
  end

  def update
    @y += @velocity
  end

  def draw
    @image.draw(@x,@y,ZOrder::Items)
  end

  def x_center_of_mass
    @x+@image.width/2
  end

  def y_center_of_mass
    @y
  end

end
