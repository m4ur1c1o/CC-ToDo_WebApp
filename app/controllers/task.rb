# GETS ============================================================================



# POSTS ===========================================================================

post '/task/new' do
	task = params[:task]
	current_user.tasks << Task.create!(content: task)
	redirect to("/users/#{current_user.id}")
end