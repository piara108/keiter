get '/users/profile'  do
  @profile = User.find_by(id: session[:user_id])
  erb :'/users/profiles'
end

get '/users/:username' do
  @user = User.find_by(username: params[:username])
  @keit = Keit.where(user_id: @user.id)
  @followings = current_user.followings
  erb :'/users/index'
end

post '/users/:username' do
  current_user.followings << User.find_by(username: params[:username])
  redirect "/users/#{current_user.username}"
end

post '/keits' do
  Keit.create(text: params[:text], user_id: session[:user_id])
  redirect "/users/#{current_user.username}"
end

get '/users/profile/edit' do
  @user = current_user
  erb :'/users/edit'
end

put '/users/profile' do
  @editprofile = User.find_by(id: session[:user_id])
  @editprofile.update_attributes(
    username:      params[:username],
    password_hash: params[:password_hash],
    first_name:    params[:first_name],
    last_name:     params[:last_name],
    email:         params[:email],
    phone_number:  params[:phone_number]
    )
  redirect '/users/profile'
end

get '/userlist' do
  @user = current_user
  @users = User.all
  erb :'/user_list'
end

get '/users/profile/relationships' do
  erb :'/users/relationships'
end
