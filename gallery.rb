require 'album'

class Gallery
	attr_reader :albums
	def initialize
		@albums = []
	end
	def find_album( name )
		@albums.each { |album|
			if album.name == name
#				puts "Found album:"+name
				return album
			end
		}
		# not found, create
		album = Album.new
		album.name = name
		@albums << album
		puts "Created album:"+name
		album
	end
end
