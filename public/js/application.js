$(document).ready(function() {
	$('.done').click(function(e){
		e.preventDefault();
		var task_id = $(this).parents('li').attr('id');
		var li_task = $(this).parents('li');
		var done_link = $(this);
		$.ajax({
			type: 'POST',
			url: '/done',
			data: { id: task_id }
		}).done(function(data){
			if (data == "Done") {

				done_link.text("Not done");
				// li_task.find("span.task").wrapInner("<del><del>");
				li_task.find("span.task").toggleClass("task-done");
			} else {
				done_link.text("Done");
				li_task.find("span.task").toggleClass("task-done");
			}
		});
	});
});
