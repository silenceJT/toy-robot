class Robot
	attr_reader :positionX, :positionY, :facing, :table

	FACING = ["NORTH", "EAST", "SOUTH", "WEST"]

	def initialize(table)
		if table.nil?
			raise TypeError, 'Invalid table'
		else
			@table = table
		end
	end

	def place(x, y, f)
		raise TypeError, 'Invalid x or y' unless x.is_a? Integer and y.is_a? Integer
		raise TypeError, 'Invalid facing' unless FACING.include?(f)
			
		if validPosition?(x,y)
			@positionX = x
			@positionY = y
			@facing = f
			true
		else
			false
		end
	end


	def report
		if @positionX.nil? or @positionY.nil? or @facing.nil?
			return "Not on the table"
		else
			return "#{@positionX},#{@positionY},#{@facing.to_s.upcase}"
		end
	end


	# check if the position is inside the table
	def validPosition?(x, y)
		( x >= 0 && x <= self.table.col && y >= 0 && y <= self.table.row )		
	end


	def move
		if safeMove?(@positionX, @positionY, @facing)
			moved = true
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
		else
			moved = false
		end

		moved

	end

	# determine if the next movement is safe.
	def safeMove?(x, y, f)
		case f
		when "NORTH"
			y += 1
		when "SOUTH"
			y -= 1
		when "WEST"
			x -= 1
		else
			x += 1
		end

		( x >= 0 && x <= self.table.col && y >= 0 && y <= self.table.row )	
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

	def standInput(input)
		if input.start_with?("PLACE")
			input.slice!("PLACE")
			place = input.strip.split("\,")
			if place.count != 3
				raise ArgumentError, 'Invalid input'
			else
				x = place[0].to_i
				y = place[1].to_i
				f = place[2]

				place(x, y, f)
			end
		elsif input.start_with?("MOVE")
			move
		elsif input.start_with?("LEFT")
			left
		elsif input.start_with?("RIGHT")
			right
		elsif input.start_with?("REPORT")
			report
		else
			raise ArgumentError, 'Invalid input'
		end
	end

end