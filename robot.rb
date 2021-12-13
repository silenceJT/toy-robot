class Robot
	attr_reader :positionX, :positionY, :facing

	def initialize(x, y, f)
		@positionX = x.to_i
		@positionY = y.to_i
		@facing = f
	end

	def report
		puts @positionX.to_s + "," + @positionY.to_s + "," + @facing
	end


	def move
		case @facing
		when "NORTH"
			@positionY += 1
		when "SOUTH"
			@positionY -= 1
		when "WEST"
			@positionX -= 1
		else
			@positionX += 1
		end
	end

	def left
		case @facing
		when "NORTH"
			@facing = "WEST"
		when "SOUTH"
			@facing = "EAST"
		when "WEST"
			@facing = "SOUTH"
		else
			@facing = "NORTH"
		end
	end

	def right
		case @facing
		when "NORTH"
			@facing = "EAST"
		when "SOUTH"
			@facing = "WEST"
		when "WEST"
			@facing = "NORTH"
		else
			@facing = "SOUTH"
		end
	end

end