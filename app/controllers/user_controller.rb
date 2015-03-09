class UserController < ApplicationController
  #login
  def login
  #checks post method
    if request.post?
      @user=User.find_by_username(params[:username])
      if @user && @user.password==params[:password]
         session[:current_user_id] = @user.username
         @md5hash=Digest::MD5.hexdigest(params[:username])
         @md5hash=@md5hash.split("")
         session[:sequence]=(@md5hash[0].to_i(16) % 4).to_s + (@md5hash[1].to_i(16) % 4).to_s + (@md5hash[2].to_i(16) % 4).to_s + (@md5hash[3].to_i(16) % 4).to_s
         session[:knock]=""
         #redirect_to "/message/add"
      else
       flash[:failure] = "Enter a valid Username/password"
       render "/user/login"
      end
    end

  #GET method
    if(!session[:current_user_id].nil? && request.get?)
      if(session[:knock].nil?)
         session[:knock] = ""
         session[:knock]= session[:knock] + "1"
      end

      if(session[:knock].length < 4 )
         session[:knock]=session[:knock]+"1"
      end

      if(session[:knock].length == 4)
        if(session[:knock]==session[:sequence])
          session[:spy]=true
        else
          @jugaad=session[:knock].split("")
          @replace=@jugaad[1].to_s+@jugaad[2].to_s+@jugaad[3].to_s
          session[:knock]=""
          session[:knock]=session[:knock]+@replace
        end
      end
    end

      if(session[:current_user_id].nil? && request.get?)
      render "/user/login"
      end

    end
 #register
  def register
   if request.post?
    if params[:password]== params[:password_confirm] && !User.where(:username => params[:username]).exists?
     @user=User.new(:username=>params[:username],:password=>params[:password],:password_confirm=>params[:password_confirm])
     if @user.save
      render "/user/login"
     else
       flash[:failure] = "Invalid Username or Password! Minimum password length 3"
       render "/user/register"
     end
    else
      if params[:password_confirm] != params[:password]
       flash[:failure] = "Passwords Don't match!"
       redirect_to "/user/register"
      else
        flash[:failure]="User name Already exists!! Enter a different user name"
        redirect_to "/user/register"
      end
     #render "/user/register"
    end
   elsif(session[:current_user_id].nil?)
     render "/user/register"
   elsif(!session[:current_user_id].nil?)
     if session[:knock].length < 4
       session[:knock]=session[:knock]+"0"
     end
     if(session[:knock].length == 4)
       if(session[:sequence]==session[:knock])
         session[:spy]=true
       else
         @jugaad=session[:knock].split("")
         @replace=@jugaad[1]+@jugaad[2]+@jugaad[3]
         session[:replace]=@replace
         session[:knock]=""
         session[:knock]=session[:knock]+@replace
       end
     end
   end
  end
#logout
def logout
  session[:session_id]=nil
  reset_session
  redirect_to "/user/login"
end
end
