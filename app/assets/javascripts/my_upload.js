$('.upload_support').fileupload({
    dataType: 'json',
    done: function (e, data) {
    	console.log($(this));
  		$('<p/>').html(('<a href="' + data.result.url + '" target="_blank">' + data.result.name + '</a>' + '&nbsp;' + '<i class="icon-remove" id="' + data.result.id + '"></i>')).appendTo($(this).find("#attachments-zone"));
    }
});

$(".icon-remove").live("click", function(){
	if (confirm("Sure to destroy?") == false){
		return;
	}
	var current = $(this);
	attach_id = $(this).attr('id');
	var jqxhr = $.ajax({
	  type: "DELETE",
		url: "/attachments/" + attach_id,
		dataType: 'json'
	})
	.done(function() { 
		current.prev().addClass('bg-yellow'); 
		current.parent().fadeOut('slow'); 
	})
	.fail(function() { alert("error"); });
});
