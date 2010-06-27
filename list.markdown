[TITLE]Galerie[/TITLE]
[CONTENT]
<p>
Wir überarbeiten gerade unsere Galerie,<br/>
deshalb gibt es im Moment nur eine Liste der Alben.
</p>

<p>
Dafür gibt es ein paar neue Bilder.<br/>
Viel Spaß damit.
</p>
<ul>
	<% gallery.albums.each do |album| %>
	<li><a href="<%= album.clean_name %>/"><%= album.clean_name %></a></li>
	<% end %>
</ul>
[/CONTENT]
