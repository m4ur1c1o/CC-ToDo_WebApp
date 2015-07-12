# GETS =======================================================================

get '/task/delete/:id' do
	@task = Task.find(params[:id])

	erb :delete_task
end

# POSTS ======================================================================

post '/task/new' do
	task = params[:task]
	current_user.tasks << Task.create!(content: task)
	redirect to("/users/#{current_user.id}")
end

post '/done' do
	task_id = params[:id]
	task = Task.find(task_id)
	task.done = !task.done

	if task.save
		# "Done"
		if task.done
			"Done"
		else
			"Not done"
		end
	else
		"Task not updated"
	end
end

post '/task/delete/:id' do
	if params.has_key?("ok")
		task = Task.find(params[:id])
		task.destroy
		redirect to("/users/#{current_user.id}")
	else
		redirect to("/users/#{current_user.id}")
	end
end
