class UI
  SCORE_X                 = 10
  SCORE_Y                 = 10
  SCORE_COLOR             = 0xff_ffff00

  LIVES_X                 = 10
  LIVES_X_SHIFT           = 39
  LIVES_Y                 = 60

  MOVE_FROM_THE_CENTER_Y  = 50

  PRESS_SPACE_LOW         = 210
  PRESS_SPACE_HIGH        = 270

  def initialize
    @font=Gosu::Font.new(50,name: "assets/fonts/vt323/VT323-Regular.ttf")
    @mid_font=Gosu::Font.new(80,name: "assets/fonts/vt323/VT323-Regular.ttf")
    @big_font=Gosu::Font.new(180,name: "assets/fonts/vt323/VT323-Regular.ttf")
    @heart=Gosu::Image.new("assets/images/heart45.png")

    @y = 240
    @y_velocity = -0.3
  end

  def draw(game)
    draw_score(game[:score])
    draw_lives(game[:lives])
    draw_game_over if game[:game_over]
    draw_game_win if game[:game_win]
  end

  private

  def draw_score(score)
    @font.draw_text("Score: #{score}", SCORE_X, SCORE_Y, ZOrder::UI, 1.0, 1.0,
               SCORE_COLOR)
  end

 def draw_lives(number)
   number.times do |index|
     @heart.draw(LIVES_X_SHIFT * index + LIVES_X, LIVES_Y, ZOrder::UI)
   end
 end

  def draw_game_over
    @big_font.draw_text_rel("GAME OVER",
                        WINDOW_WIDTH/2,
                        WINDOW_HEIGHT/2 - MOVE_FROM_THE_CENTER_Y,
                        ZOrder::UI,
                        0.5, 0.5)
    @mid_font.draw_text_rel("Press SPACE to restart",
                        WINDOW_WIDTH/2,
                        WINDOW_HEIGHT/2 + MOVE_FROM_THE_CENTER_Y,
                        ZOrder::UI,
                        0.5,0.5)
  end

  def draw_game_win
    @big_font.draw_text_rel("WIN",
                        WINDOW_WIDTH/2,
                        WINDOW_HEIGHT/2 - MOVE_FROM_THE_CENTER_Y,
                        ZOrder::UI,
                        0.5, 0.5)
    @mid_font.draw_text_rel("Press SPACE to restart",
                        WINDOW_WIDTH/2,
                        WINDOW_HEIGHT/2 + MOVE_FROM_THE_CENTER_Y,
                        ZOrder::UI,
                        0.5,0.5)
  end

  def y_velocity
    if @y<PRESS_SPACE_LOW || @y>PRESS_SPACE_HIGH
      @y_velocity = -@y_velocity
    end
    @y_velocity
  end

end
