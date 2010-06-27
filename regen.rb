#!/usr/bin/ruby
require 'rubygems'
require 'erb'
require 'maruku'
require 'ftools'

srcdir = ARGV.shift
destdir = ARGV.shift

albums = {}
# Dir[srcdir+'**/*.jpg'].sort.each do |f|
Dir.glob(srcdir+'**/*.jpg', File::FNM_CASEFOLD).sort.each do |srcname|
#	p f
	if srcname =~ /^#{srcdir}(.+)$/
#		p $~
#		p $~[1]
		name = $~[1]
		destname = destdir+"/"+name
		albumname = File.dirname( name )
		imgname = File.basename( name )
		destthumbname = destdir+"/"+albumname+"/thumb_"+imgname
#		puts srcname+" -> "+name+" -> "+destname
		
		# ensure the target directory exists
		File.makedirs( File.dirname( destname ) )
		
		if !File.exists?( destname ) || File.mtime( srcname ) > File.mtime( destname )
			puts "Needs update"
			system( "convert", srcname, "-resize", "800x600>", destname )
			system( "convert", srcname, "-resize", "260x200>", destthumbname )
		end
		if !albums[ albumname ]
			puts "New album "+albumname
			albums[ albumname ] = []
		end
		albums[ albumname ] << imgname
	end
end
puts
puts
# file = File.open("album.markdown", "rb")
# albumtemplate = file.read
albumtemplate = File.read("album.markdown")
album = ""
albumname = ""
images = []
albums.each do |album, images|
	p album
	albumname = album
	albummarkdown = ERB.new( albumtemplate )
#	puts albummarkdown.result
	File.open( destdir+"/"+album+"/index.page", "w") do |out|
#		doc = Maruku.new( albummarkdown )
#		out.write( doc.to_html )
		out.write( albummarkdown.result )
	end
end

listtemplate = File.read("list.markdown")
album = ""
albumname = ""
images = []
listmarkdown = ERB.new( listtemplate )
#	puts albummarkdown.result
File.open( destdir+"/index.page", "w") do |out|
#		doc = Maruku.new( albummarkdown )
#		out.write( doc.to_html )
	out.write( listmarkdown.result )
end

