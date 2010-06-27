
class Image
	attr_reader :name, :clean_name, :thumb_name
	
	def initialize
		@name = ""
	end
	
	def name=( name )
		@name = name
		@thumb_name = "thumb_"+name
		if name =~ /^\d\d\d\d-(.+)$/
			@clean_name = $~[ 1 ]
		else
			@clean_name = name
		end
		if @clean_name =~ /^(.+)\.jpg$/i
			@clean_name = $~[ 1 ]
		end
	end
end
