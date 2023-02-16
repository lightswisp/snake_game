class AppleEntity < Gosu::Window

    def initialize(terrain)
        @terrain = terrain.get()
        @tile = nil
    end

    def spawn()
        @tile =  @terrain[Random.new.rand(0...@terrain.length)].clone
    end

    def get()
        return @tile
    end

    def draw()
        draw_rect(@tile["x"], @tile["y"], @tile["width"], @tile["height"], Gosu::Color.argb(0xff_ff0000) )
    end

end