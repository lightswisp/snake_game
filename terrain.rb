class Terrain < Gosu::Window


	def initialize(width, height, scale, padding)
		@width = width
		@height = height
		@scale = scale
		@tiles = []
		@tile_w, @tile_h = nil
		@settings = {}
		@padding = padding
	end

	def calculate_terrain()
		@tile_w = ((@width / @scale.to_f)  - @padding).ceil
		@tile_h = ((@height / @scale.to_f) - @padding).ceil
		
		@scale.times do |x|
			@scale.times do |y|				
				@tiles << {
					"x" => ((@width/@scale) * x).ceil,
					"y" => ((@height/@scale) * y).ceil,
					"width" => @tile_w,
					"height" => @tile_h
				}
			end
		end
		@settings["step"] = @tiles[1]["y"]
		@settings["max"] = @tiles.max_by{|cell| cell["y"]}["y"] 
	end

	def get()
		return @tiles
	end

	def settings()
		return @settings
	end

	def draw()
		@tiles.each{ |tile|
			draw_rect(tile["x"], tile["y"], tile["width"], tile["height"], Gosu::Color.new(0xff555555) )
		}
	end
end
