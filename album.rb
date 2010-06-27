
class Album
	attr_reader :name, :clean_name, :images
	
	def initialize
		@name = ""
		@clean_name = ""
		@images = []
	end
	def name=( name )
		@name = name
#		puts "Name "+name
		@clean_name = ""
		seperator = ""
		name.split( "/" ).each { |part|
			if part =~ /^\d\d\d\d-(.+)$/
				part = $~[ 1 ]
			end
			@clean_name += seperator+part
			seperator = "/"
		}
#		puts @clean_name
	end
	
	def add_image( image )
		@images << image
	end
end
