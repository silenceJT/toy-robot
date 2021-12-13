class Table
	attr_reader :row, :col
	
	def initialize(row, col)
		@row = row.to_i - 1
		@col = col.to_i - 1
	end
end