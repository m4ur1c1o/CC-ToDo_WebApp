helpers do
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user_validation
		if request.path_info.match(/users\/\d+/)
			puts "Entramos al regex"
			puts "params=#{request.path_info.scan(/\d/)} y current=#{current_user.id}"
			if request.path_info.scan(/\d/).first.to_i != current_user.id
				session[:errors] = "You don't have access to this page"
				redirect to('/')
			end
		end
  end

  def session_validation
  	pass if ['login', 'register', nil].include? request.path_info.split('/')[1]
		unless logged_in?
			# puts "No existe una sesion"
			session[:errors] = "No existe una sesion"
			# @error = session[:error]
			redirect to("/")
		end
  end
end