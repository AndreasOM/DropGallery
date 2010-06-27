[TITLE]Galerie[/TITLE]
[CONTENT]
<ul>
	<% gallery.albums.each do |album| %>
	<li><a href="<%= album.name %>/"><%= album.clean_name %></a></li>
	<% end %>
</ul>
[/CONTENT]
