#!/usr/bin/ruby
require 'rubygems'
require 'erb'
require 'maruku'
require 'ftools'

require 'album'
require 'gallery'
require 'image'

srcdir = ARGV.shift
destdir = ARGV.shift

gallery = Gallery.new

albums = {}
Dir.glob(srcdir+'**/*.jpg', File::FNM_CASEFOLD).sort.each do |srcname|
	if srcname =~ /^#{srcdir}(.+)$/
		name = $~[1]
		albumname = File.dirname( name )
		imgname = File.basename( name )
		
		album = gallery.find_album( albumname )
		image = Image.new
		image.name = imgname
		
		destname = destdir+"/"+album.clean_name+"/"+imgname
		destthumbname = destdir+"/"+album.clean_name+"/thumb_"+imgname
		# ensure the target directory exists
		File.makedirs( File.dirname( destname ) )
		
		if !File.exists?( destname ) || File.mtime( srcname ) > File.mtime( destname )
			puts "Needs update ( "+image.name+" )"
			system( "convert", srcname, "-resize", "800x600>", destname )
			system( "convert", srcname, "-resize", "260x200>", destthumbname )
		end
		album.add_image( image )
	end
end

albumtemplate = File.read("album.markdown")
album = ""
albumname = ""
images = []

gallery.albums.each { |album|
	p album.clean_name
	albummarkdown = ERB.new( albumtemplate )
	File.open( destdir+"/"+album.clean_name+"/index.page", "w") do |out|
#		doc = Maruku.new( albummarkdown )
#		out.write( doc.to_html )
		out.write( albummarkdown.result )
	end
}
listtemplate = File.read("list.markdown")
album = ""
albumname = ""
images = []
listmarkdown = ERB.new( listtemplate )
File.open( destdir+"/index.page", "w") do |out|
#		doc = Maruku.new( listmarkdown )
#		out.write( doc.to_html )
	out.write( listmarkdown.result )
end
