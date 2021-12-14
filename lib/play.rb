require './lib/robot'
require './lib/table'

class Play

	def initialize
		@table = Table.new 5,5
		@robot = Robot.new @table
	end

	def start(input)
		begin
			puts @robot.standInput(input)
		rescue StandardError => e
			puts "Rescued: #{e.message}"
		end
	end
	
end