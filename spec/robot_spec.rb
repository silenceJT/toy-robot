require "spec_helper"

describe Robot do
	let(:table) {Table.new 5,5}
	let(:robot) {Robot.new table}

	it "test the place is valid" do
		expect(robot.place(0,0,"NORTH")).to eq(true)
		expect(robot.place(4,4,"SOUTH")).to eq(true)
		expect(robot.place(5,5,"NORTH")).to eq(false)
		expect(robot.place(0,-1,"NORTH")).to eq(false)
	end

	it "invalid input value" do
		expect{ robot.place('0',1,"NORTH") }.to raise_error(TypeError)
		expect{ robot.place(nil,1,"NORTH") }.to raise_error(TypeError)
		expect{ robot.place(3,1,"MIDDLE") }.to raise_error(TypeError)
	end

	it "invalid input size" do
		expect{ robot.place(nil) }.to raise_error(ArgumentError)
		expect{ robot.place(0,0) }.to raise_error(ArgumentError)
		expect{ robot.place(0,"NORTH") }.to raise_error(ArgumentError)
		expect{ robot.place("NORTH") }.to raise_error(ArgumentError)
	end

	it "should report its position" do
		robot.place(0,0,"NORTH")
		expect(robot.report).to eq ("0,0,NORTH")
		robot.move
		expect(robot.report).to eq ("0,1,NORTH")
		robot.move
		robot.move
		robot.move
		robot.move
		expect(robot.report).to eq ("0,4,NORTH")
		robot.left
		expect(robot.report).to eq ("0,4,WEST")
		robot.move
		expect(robot.report).to eq ("0,4,WEST")
	end

	it "valid movement" do
		robot.place(0,0,"NORTH")
		expect(robot.move).to eq (true)
		expect(robot.positionX).to eq (0)
		expect(robot.positionY).to eq (1)
		expect(robot.facing).to eq ("NORTH")

		expect(robot.move).to eq (true)
		expect(robot.move).to eq (true)
		expect(robot.move).to eq (true)
		expect(robot.positionX).to eq (0)
		expect(robot.positionY).to eq (4)
		expect(robot.facing).to eq ("NORTH")

		expect(robot.move).to eq (false)
		expect(robot.positionX).to eq (0)
		expect(robot.positionY).to eq (4)
		expect(robot.facing).to eq ("NORTH")

		robot.right
		expect(robot.positionX).to eq (0)
		expect(robot.positionY).to eq (4)
		expect(robot.facing).to eq ("EAST")

		expect(robot.move).to eq (true)
		expect(robot.move).to eq (true)
		expect(robot.move).to eq (true)
		expect(robot.move).to eq (true)
		expect(robot.positionX).to eq (4)
		expect(robot.positionY).to eq (4)
		expect(robot.facing).to eq ("EAST")

		expect(robot.move).to eq (false)
		expect(robot.positionX).to eq (4)
		expect(robot.positionY).to eq (4)
		expect(robot.facing).to eq ("EAST")
	end

	it "turn left" do
		robot.place(0,0,"NORTH")
		robot.left
		expect(robot.facing).to eq ("WEST")
		robot.left
		expect(robot.facing).to eq ("SOUTH")
		robot.left
		expect(robot.facing).to eq ("EAST")
		robot.left
		expect(robot.facing).to eq ("NORTH")
	end

	it "turn right" do
		robot.place(0,0,"NORTH")
		robot.right
		expect(robot.facing).to eq ("EAST")
		robot.right
		expect(robot.facing).to eq ("SOUTH")
		robot.right
		expect(robot.facing).to eq ("WEST")
		robot.right
		expect(robot.facing).to eq ("NORTH")
	end

	it "excute stand input" do
		robot.standInput("PLACE 0,0,NORTH")
		expect(robot.report).to eq ("0,0,NORTH")

		robot.standInput("MOVE")
		expect(robot.report).to eq ("0,1,NORTH")

		robot.standInput("LEFT")
		expect(robot.report).to eq ("0,1,WEST")

		robot.standInput("RIGHT")
		expect(robot.report).to eq ("0,1,NORTH")

		robot.standInput("MOVE")
		robot.standInput("MOVE")
		robot.standInput("MOVE")
		expect(robot.report).to eq ("0,4,NORTH")
		robot.standInput("MOVE")
		expect(robot.report).to eq ("0,4,NORTH")
	end

end