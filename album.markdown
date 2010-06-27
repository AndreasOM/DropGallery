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
</tr><tr>
	<td colspan="2">
	<iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.elfenrausch.de%2Fgalerie%2F<%= album.clean_name %>&amp;layout=button_count&amp;show_faces=false&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:21px;" allowTransparency="true"></iframe>
	</td>
</tr></table>
<div>
</div>
[/CONTENT]
