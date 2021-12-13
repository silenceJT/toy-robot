require './robot'
require './table'

def start
	puts "Input from file or console? (f/c):"
	inputFC = gets.chomp
	if inputFC == "c"
		puts "Please set the table size"
		inputSize = gets.chomp.split("\,")
		@table = Table.new(inputSize[0], inputSize[1])
		input = gets.chomp
		while input != "STOP"
			if input.start_with?("PLACE")
				input.slice!("PLACE")
				place = input.strip.split("\,")
				x = place[0].to_i
				y = place[1].to_i
				f = place[2]
				if validPosition?(x, y, f)
					@robot = Robot.new(x, y, f)
				else
					puts "invalid position"
				end
			elsif input.start_with?("MOVE")
				if safePosition?(@robot.positionX, @robot.positionY, @robot.facing)
					@robot.move
				end
			elsif input.start_with?("LEFT")
				@robot.left
			elsif input.start_with?("RIGHT")
				@robot.right
			elsif input.start_with?("REPORT")
				@robot.report
			end
			input = gets.chomp
		end
	elsif inputFC == "f"
		File.foreach('test.txt') do |line|
			input = line
			puts input
			if input.start_with?("PLACE")
				input.slice!("PLACE")
				place = input.strip.split("\,")
				x = place[0].to_i
				y = place[1].to_i
				f = place[2]
				if validPosition?(x, y, f)
					@robot = Robot.new(x, y, f)
				else
					puts "invalid position"
				end
				@robot.report
			elsif input.start_with?("MOVE")
				if safePosition?(@robot.positionX, @robot.positionY, @robot.facing)
					@robot.move
					@robot.report
				end
			elsif input.start_with?("LEFT")
				@robot.left
				@robot.report
			elsif input.start_with?("RIGHT")
				@robot.right
				@robot.report
			elsif input.start_with?("REPORT")
				@robot.report
			else
				inputSize = input.split("\,")
				@table = Table.new(inputSize[0], inputSize[1])
			end
		end
	end
			
end


def validPosition?(x, y, f)
	if x < 0 || x > @table.col || y < 0 || y > @table.row
		return false
	else
		return true
	end	
end


def safePosition?(x, y, f)
	# left col
	if x == 0
		case f
		when "WEST"
			return false
		when "NORTH"
			if y == @table.row
				return false
			else 
				return true
			end
		when "SOUTH"
			if y == 0
				return false
			else 
				return true
			end
		else
			return true
		end
	# right col
	elsif x == @table.col
		case f
		when "EAST"
			return false
		when "NORTH"
			if y == @table.row
				return false
			else 
				return true
			end
		when "SOUTH"
			if y == 0
				return false
			else 
				return true
			end
		else
			return true
		end
	# bottom row
	elsif y == 0
		case f
		when "SOUTH"
			return false
		when "WEST"
			if x == 0
				return false
			else
				return true
			end
		when "EAST"
			if x == @table.col
				return false
			else
				return true
			end
		else
			return true
		end
	# top row	
	elsif y == @table.row
		case f
		when "NORTH"
			return false
		when "WEST"
			if x == 0
				return false
			else
				return true
			end
		when "EAST"
			if x == @table.col
				return false
			else
				return true
			end
		else
			return true
		end
	end
end

start