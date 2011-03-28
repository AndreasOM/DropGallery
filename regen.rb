#!/usr/bin/ruby
require 'rubygems'
require 'erb'
require 'maruku'
require 'ftools'

require 'yaml'

require 'album'
require 'gallery'
require 'image'

if ENV[ "ENVIRONMENT" ]
	environment = ENV[ "ENVIRONMENT" ]
else
	environment = "development"
end

APP_CONFIG = YAML.load_file( 'config.yml' )[environment]
if !APP_CONFIG
	puts "Missing configuration for #{environment}."
	exit
end

srcdir = APP_CONFIG['source']
workdir = APP_CONFIG['work']
destination = APP_CONFIG['destination']

# :TODO: make curly braces on env expansion optional
srcdir.gsub!(/\$\{(\w+)\}/) { ENV[ $1 ] } if srcdir
workdir.gsub!(/\$\{(\w+)\}/) { ENV[ $1 ] } if workdir
destination.gsub!(/\$\{(\w+)\}/) { ENV[ $1 ] } if destination

p srcdir
p workdir
gallery = Gallery.new

albums = {}
Dir.glob(srcdir+'/**/*.jpg', File::FNM_CASEFOLD).sort.each do |srcname|
	if srcname =~ /^#{srcdir}(.+)$/
		name = $~[1]
		albumname = File.dirname( name )
		imgname = File.basename( name )
		
		album = gallery.find_album( albumname )
		image = Image.new
		image.name = imgname
		
		destname = workdir+"/"+album.clean_name+"/"+imgname
		destthumbname = workdir+"/"+album.clean_name+"/thumb_"+imgname
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
	# add description
	descfilename = srcdir+album.name+"/description.markdown"
#	puts "||"+descfilename
	if File.exists?( descfilename )
		doc = Maruku.new( IO.read( descfilename ) )
		album.description = doc.to_html
	end
	albummarkdown = ERB.new( albumtemplate )
	File.open( workdir+"/"+album.clean_name+"/index.page", "w") do |out|
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
File.open( workdir+"/index.page", "w") do |out|
#		doc = Maruku.new( listmarkdown )
#		out.write( doc.to_html )
	out.write( listmarkdown.result )
end

# final upload (work -> destination)

if destination
	if ! destination.match( /^(.+):\/\/(.+)$/ )
		puts "destination needs protocol (e.g. 'scp://path' )"
	else
		path = $~[ 2 ]
		case $~[ 1 ]
		when "rsync+ssh"
			puts "Syncing via rsync+ssh"
			system( "rsync" ,"-avzr", "-e", "ssh", workdir+"/", path )
		else
			puts "Unknown protocol #{$~[ 1 ]}"
		end
	end
end

