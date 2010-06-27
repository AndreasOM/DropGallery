
class Image
	attr_reader :name, :clean_name, :thumb_name
	
	def initialize
		@name = ""
	end
	
	def name=( name )
		@name = name
		@clean_name = name
		@thumb_name = "thumb_"+name
	end
end
