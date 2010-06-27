[TITLE]<%= albumname %>[/TITLE]
[CONTENT]
<table class="gallery"><tr>
	<% count=0 %>
	<% images.each do |image| %>
	<% if count>1 %>
	</tr><tr>
	<% count = 0 %>
	<% end %>

<td class="picture"><a href="<%= image %>" rel="lightbox[<%= albumname %>]" title="Hochzeit Sinta"><img src="thumb_<%= image %>"/></a><br/><%= albumname %></td>
	<% count+=1 %>
	<% end %>
</tr></table>
[/CONTENT]
