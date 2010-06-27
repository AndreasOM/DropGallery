[TITLE]<%= album.clean_name %>[/TITLE]
[CONTENT]
<table class="gallery"><tr>
	<%
		count=0
		album.images.each do |image|
		if count>1
	%>
	</tr><tr>
	<%
		count = 0
		end
	%>
<td class="picture"><a href="<%= image.name %>" rel="lightbox[<%= album.clean_name %>]" title="<%= image.clean_name %>"><img src="<%= image.thumb_name %>"/></a><br/><%= image.clean_name %></td>
	<%
		count+=1
		end
	%>
</tr></table>
[/CONTENT]
