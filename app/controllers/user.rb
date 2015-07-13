before do
 session_validation
 current_user_validation
end

# GETS ============================================================================

# NEW
# get '/register' do

# 	erb :new_user
# end

# SHOW
get '/users/:id' do
	@user = current_user
	@tasks = @user.tasks.order(created_at: :desc)

	erb :show_user
end

# EDIT
get '/users/:id/edit' do
	id = params[:id]
	@user = User.find("#{id}")
	erb :edit_user
end

get '/logout' do
	session.clear
	redirect to('/')
end

# POSTS ===========================================================================


# LOGIN
post '/login' do
	email = params[:email]
	password = params[:password]
	user = User.authenticate(email, password)
	if user
		id = user.id
		# session[:email] = params[:email]
		session[:user_id] = id
		redirect to("/users/#{id}")
	else
		session[:errors] = "Datos incorrectos"
		erb :index
	end
end


# CREATE
post '/register' do
	# first_name = params[:user][:first_name]
	# last_name = params[:user][:last_name]
	# username = params[:user][:username]
	# email = params[:user][:email]
	# password = params[:user][:password]


	# @user = User.create(first_name: first_name, last_name: last_name, username: username, email: email, password: password)
	@user = User.create(params[:user])
	session[:user_id] = @user.id
	redirect to("/users/#{@user.id}")
end


# UPDATE
post '/users/:id' do
	puts params
	id = params[:id]
	user = User.find(id)


	first_name = params[:user][:first_name]
	last_name = params[:user][:last_name]
	username = params[:user][:username]
	email = params[:user][:email]
	password = params[:user][:password]


	if password == ""
		user.update(first_name: first_name, last_name: last_name, username: username, email: email)
	else
		# Meter un confirmación de el password anterior para poder cambiar el pasword
		user.update(params[:user])
	end
	redirect to("/users/#{id}")
end

# DELETE
post '/users/:id/delete' do
	id = params[:id]
	user = User.destroy(id)
	session.clear
	redirect to ('/')
end




