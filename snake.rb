require 'set'
require 'pp'

class SnakeEntity < Gosu::Window

    def initialize(terrain)
        @terrain = terrain.get()
        @tiles = [] # snake body
        @moving_direction = nil
        @settings = terrain.settings()
    end

    def debug()
        p @tiles
    end

    def get()
        return @tiles.length
    end

    def spawn()
        @tiles << @terrain[Random.new.rand(0...@terrain.length)].clone
    end

    def self_collision?()
        tiles = @tiles.clone
        tiles.each{|tile|
            if tile["last_location"]
                return true if tile["last_location"]["x"] == tiles[0]["x"] && tile["last_location"]["y"] == tiles[0]["y"]
            end
        }
        return false    
    end

    def apple_collision?(apple_location)
        return true if apple_location["x"] == @tiles[0]["x"] && apple_location["y"] == @tiles[0]["y"]
        return false
    end

    def add_tile()

        case @moving_direction
            when "up"
                new_tile = @tiles[-1].clone
                new_tile["y"] = new_tile["y"] + @settings["step"]
                @tiles << new_tile
            when "right"
                new_tile = @tiles[-1].clone
                new_tile["x"] = new_tile["x"] - @settings["step"]
                @tiles << new_tile
            when "down"
                new_tile = @tiles[-1].clone
                new_tile["y"] = new_tile["y"] - @settings["step"]
                @tiles << new_tile
            when "left"
                new_tile = @tiles[-1].clone
                new_tile["x"] = new_tile["x"] + @settings["step"]
                @tiles << new_tile
        end

    end

    def up()
        if @tiles.length > 1
            @moving_direction = "up" if @moving_direction != "down" 
        else
            @moving_direction = "up"  
        end
    end

    def right()
        if @tiles.length > 1
            @moving_direction = "right" if @moving_direction != "left" 
        else
            @moving_direction = "right"  
        end
    end

    def down()
        if @tiles.length > 1
            @moving_direction = "down" if @moving_direction != "up" 
        else
            @moving_direction = "down"  
        end
    end

    def left()
        if @tiles.length > 1
            @moving_direction = "left" if @moving_direction != "right" 
        else
            @moving_direction = "left"  
        end
    end

    def draw()
        #p @moving_direction
        @tiles.each.with_index {|tile, index|
            if @moving_direction #if we have any direction to move to
               case @moving_direction
               when "up"

                if @tiles.length > 1
                    if index == 0 # if it's the head
                        tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                        y = tile["y"] == 0 ? @settings["max"] : tile["y"] - @settings["step"]
                        draw_rect(tile["x"], y, tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                        tile["y"] = y
                    else
                        next_tile = @tiles[index - 1]
                        tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                        draw_rect(next_tile["last_location"]["x"], next_tile["last_location"]["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                        tile["x"] = next_tile["last_location"]["x"]
                        tile["y"] = next_tile["last_location"]["y"]
                    end
                else
                    y = tile["y"] == 0 ? @settings["max"] : tile["y"] - @settings["step"]
                    draw_rect(tile["x"], y, tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                    tile["y"] = y
                end

               when "right"

                if @tiles.length > 1
                    if index == 0 # if it's the head
                        tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                        x = tile["x"] == @settings["max"] ? 0 : tile["x"] + @settings["step"]
                        draw_rect(x, tile["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                        tile["x"] = x
                    else
                        next_tile = @tiles[index - 1]
                        tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                        draw_rect(next_tile["last_location"]["x"], next_tile["last_location"]["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                        tile["x"] = next_tile["last_location"]["x"]
                        tile["y"] = next_tile["last_location"]["y"]
                    end

                else
                    x = tile["x"] == @settings["max"] ? 0 : tile["x"] + @settings["step"]
                    draw_rect(x, tile["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                    tile["x"] = x
                end

               when "down" 
                    
                    if @tiles.length > 1

                        if index == 0 # if it's the head
                            tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                            y = tile["y"] == @settings["max"] ? 0 : tile["y"] + @settings["step"]
                            draw_rect(tile["x"], y, tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                            tile["y"] = y
                        else
                            next_tile = @tiles[index - 1]
                            tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                            draw_rect(next_tile["last_location"]["x"], next_tile["last_location"]["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                            tile["x"] = next_tile["last_location"]["x"]
                            tile["y"] = next_tile["last_location"]["y"]
                        end

                    else
                        y = tile["y"] == @settings["max"] ? 0 : tile["y"] + @settings["step"]
                        draw_rect(tile["x"], y, tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                        tile["y"] = y
                    end

               when "left"
                
                    if @tiles.length > 1
                       if index == 0 # if it's the head
                            tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                            x = tile["x"] == 0 ? @settings["max"] : tile["x"] - @settings["step"]
                            draw_rect(x, tile["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                            tile["x"] = x
                       else
                            next_tile = @tiles[index - 1]
                            tile["last_location"] = {"x" => tile["x"], "y" => tile["y"] }
                            draw_rect(next_tile["last_location"]["x"], next_tile["last_location"]["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                            tile["x"] = next_tile["last_location"]["x"]
                            tile["y"] = next_tile["last_location"]["y"]
                       end
                    else
                        x = tile["x"] == 0 ? @settings["max"] : tile["x"] - @settings["step"]
                        draw_rect(x, tile["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
                        tile["x"] = x
                    end

               end

            else
                draw_rect(tile["x"], tile["y"], tile["width"], tile["height"], Gosu::Color.argb(0xff_00ffff) )
            end
        }
    end
end