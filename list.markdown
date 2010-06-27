[TITLE]Galerie[/TITLE]
[CONTENT]
<ul>
	<% albums.sort.each do |album,images| %>
	<li><a href="<%= album %>/"><%= album %></a></li>
	<% end %>
</ul>
[/CONTENT]
