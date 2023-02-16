require 'gosu'
require './terrain'
require './apple'
require './snake'

# CONTROLS: W -> UP, A-> LEFT, S -> DOWN, D -> RIGHT

WIN_WIDTH = 600
WIN_HEIGHT = 600
SCALE = 10
PADDING = 5
FPS = 10

class Snake < Gosu::Window
  def initialize
    super WIN_WIDTH, WIN_HEIGHT + 45
    self.caption = "Snake"

    @terrain = Terrain.new(WIN_WIDTH, WIN_HEIGHT, SCALE, PADDING)
    @terrain.calculate_terrain()

    @apple = AppleEntity.new(@terrain)
    @apple.spawn # generating random pos for apple entity on game launch

    @snake = SnakeEntity.new(@terrain)
    @snake.spawn # generating random pos for snake entity on game launch

    @font = Gosu::Font.new(self, Gosu::default_font_name, 40)
    @game_over = false

  end
  
  def update
    @snake.up if Gosu.button_down? Gosu::KB_W
    @snake.right if Gosu.button_down? Gosu::KB_D
    @snake.down if Gosu.button_down? Gosu::KB_S
    @snake.left if Gosu.button_down? Gosu::KB_A
  end
  
  def draw
    if @snake.self_collision?
      @game_over = true
    end

    if !@game_over

      @font.draw_text("Score: #{@snake.get() - 1}", PADDING, WIN_HEIGHT, 1, 1.0, 1.0, Gosu::Color::WHITE)
      @font.draw_text("FPS: #{Gosu::fps}", WIN_WIDTH - 140, WIN_HEIGHT, 1, 1.0, 1.0, Gosu::Color::WHITE)
      @terrain.draw
      @apple.draw
      @snake.draw
      if @snake.apple_collision?(@apple.get())
        @snake.add_tile
        @apple.spawn 
      end
      sleep(1.to_f/FPS) 

    else
      @font.draw_text("GAME OVER!", (WIN_WIDTH / 2) - 105, (WIN_HEIGHT/2), 1, 1.0, 1.0, Gosu::Color::WHITE)
      @font.draw_text("Score: #{@snake.get() - 1}", (WIN_WIDTH / 2) - 105, (WIN_HEIGHT/2)+40, 1, 1.0, 1.0, Gosu::Color::WHITE)
    end

  end
end

Snake.new.show
