
class Album
	attr_reader :name, :clean_name, :images
	
	def initialize
		@name = ""
		@clean_name = ""
		@images = []
	end
	def name=( name )
		@name = name
		puts "Name "+name
		@clean_name = name
	end
	
	def add_image( image )
		@images << image
	end
end
