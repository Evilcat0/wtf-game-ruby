class Player

  Y = 450

  ACCELERATION_FACTOR     =0.5             # => (0.5 default)
  SKIDING_FACTOR          =0.98                 # => (0.98 default)
  DISTANCE_OF_COLLISION   = 80          # => (35 default)

  LIFE_LOST_PAUSE         = 1500

  FULL_LIVES              = 3

  attr_reader :score, :lives

  def initialize
    @x=WINDOW_HEIGHT / 2
    @velocity = 0.0
    @image=Gosu::Image.new("assets/images/cat110.png")
    @sound_collect = Gosu::Sample.new("assets/sounds/ding.mp3")
    @sound_shit = Gosu::Sample.new("assets/sounds/surprise.mp3")

    @score=0
    @lives=FULL_LIVES
    @lost_life_at = -20_000
    @angle = 0.0
  end

  def update(items)
    just_lost_a_life? ? update_angle : update_general(items)
  end

  def draw
    if just_lost_a_life?
      @image.draw_rot(x_middle, y_middle, ZOrder::Player, @angle)
    else
      @image.draw(@x, Y, ZOrder::Player)
    end
  end

  def go_left
    @velocity -= ACCELERATION_FACTOR
  end

  def go_right
    @velocity += ACCELERATION_FACTOR
  end

  def move
    @x += @velocity
    @x %= WINDOW_WIDTH
    @velocity *= SKIDING_FACTOR
  end

  def collect(items)
    items.reject! {|item| collide?(item) ? collision(item.type) : false}
  end

  def just_lost_a_life?
    Gosu::milliseconds - @lost_life_at < LIFE_LOST_PAUSE
  end

  def reset
    @score = 0
    @lives = FULL_LIVES
    @angle = 0.0
    @velocity = 0.0
  end

  private

  def collide?(item)
    distance = Gosu::distance(x_center_of_mass, y_center_of_mass,item.x_center_of_mass, item.y_center_of_mass)
    distance < DISTANCE_OF_COLLISION
  end

  def x_center_of_mass
    @x + @image.width / 2
  end
  alias_method :x_middle, :x_center_of_mass

  def y_center_of_mass
    Y + @image.height/4
  end

  def y_middle
    Y+@image.height/2
  end

  def collision(type)
    case type
    when :apple
      @score+=10
      @sound_collect.play(1.0)
    when :merde
        @lives -= 1
        @sound_shit.play(1.0)
        @lost_life_at = Gosu::milliseconds
    end

    true
  end

  def update_angle
    @angle += 10
  end

  def update_general(items)
    go_left if Button.left?
    go_right if Button.right?
    move
    collect(items)
  end

end
