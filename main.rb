require 'gosu'

require_relative 'z_order'
require_relative 'button'
require_relative 'player'
require_relative 'goody'
require_relative 'window'
require_relative 'UI'
require_relative 'song'
require_relative 'song_player'

WINDOW_WIDTH    = 1280
WINDOW_HEIGHT   = 720

window = Window.new(WINDOW_WIDTH,WINDOW_HEIGHT)
window.show
