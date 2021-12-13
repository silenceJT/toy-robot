require './robot'
require './table'

def start
	puts "Input from file or console? (f/c):"
	inputFC = gets.chomp
	if inputFC == "c"
		puts "Please set the table size, for exampe: 5,5"
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
					puts "invalid position, place again."
				end
			elsif input.start_with?("MOVE")
				if safeMove?(@robot.positionX, @robot.positionY, @robot.facing)
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
					puts "invalid position, place again."
				end
				#@robot.report
			elsif input.start_with?("MOVE")
				if safeMove?(@robot.positionX, @robot.positionY, @robot.facing)
					@robot.move
					#@robot.report
				end
			elsif input.start_with?("LEFT")
				@robot.left
				#@robot.report
			elsif input.start_with?("RIGHT")
				@robot.right
				#@robot.report
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

	if x < 0 || x > @table.col || y < 0 || y > @table.row
		return false
	else
		return true
	end
end

start