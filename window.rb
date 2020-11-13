class Window < Gosu::Window

  WIN_AT  =  150

  def initialize(width, height)
    super
    self.caption = "Catch 'em all son of a b****!"

    @background_image = Gosu::Image.new("assets/images/african-landscape.jpg")

    @player = Player.new
    @ui = UI.new

    @items = []

    @song_player = SongPlayer.new
    @song_player.play(Song::Level1)

    @game_over = false
    @win = false
  end

  def update
    reset if new_game?

    return if @game_over || @win

    update_game_over
    update_game_win
    update_items
    update_player
  end

  def new_game?
    (@game_over || @win) && Button.space?
  end

  def reset
    @items = []
    @player.reset
    @song_player.play(Song::Level1)
    @game_over = false
    @win = false
  end

  def update_game_over
    return unless @player.lives <= 0

    @game_over=true
    @song_player.play(Song::GameOver2)
  end

  def update_game_win
    return unless @player.score >= WIN_AT

    @win=true
    @song_player.play(Song::Win)
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @items.each(&:draw)
    @player.draw
    @ui.draw(game_state)
  end

  private

  def update_items
    return if @player.just_lost_a_life?

    populate_items
    @items.each(&:update)
    @items.reject! {|item| item.y > WINDOW_HEIGHT }
  end

  # apple : 0.035
  # merde : 0.040
  def populate_items
    return if @items.size >= 15

    type = rand
    if type < 0.010
      @items.push(Goody.new(:apple))
    elsif type < 0.040
      @items.push(Goody.new(:merde))
    end
  end

  def update_player
    @player.update(@items)
  end

  def game_state
    {
      score: @player.score,
      lives: @player.lives,
      game_over: @game_over,
      game_win: @win
    }
  end

end
