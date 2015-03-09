class MessageController < ApplicationController
  def add
     if request.post? && session[:spy].nil? && !session[:current_user_id].nil?
       @message=Message.new(:title=>params[:title],:message=>params[:message])
        if @message.save
          render "/message/add"
        else
           flash[:failure]="Enter valid inputs"
          render "/message/add"
        end
     end


      if request.get? && !session[:current_user_id].nil?
        if session[:knock].nil?
           session[:knock]=""
           session[:knock]= session[:knock]+"2"
        else
           if(session[:knock].length < 4)
             session[:knock]= session[:knock]+"2"
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

        if request.post? && !session[:spy].nil?
          @message=Secret.new(:title=>params[:title],:message=>params[:message])
          if @message.save
           render "/message/add"
          else
            flash[:failure]="Enter valid inputs"
            render "/message/add"
          end
        end
     if request.get? && session[:current_user_id].nil?
      redirect_to welcome_index_path
     end
  end


  def list
    if !session[:current_user_id].nil? && session[:spy].nil?
      #@user = User.find(session[:user_id)
      @message = Message.all
      render "/message/list"
      if(session[:knock].nil?)
        session[:knock]=""
        session[:knock]=session[:knock]+"3"
      else
        if(session[:knock].length < 4)
            session[:knock]=session[:knock]+"3"
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
    elsif !session[:current_user_id].nil? && !session[:spy].nil?
      @message=Secret.all
    else
      redirect_to welcome_index_path
    end
  end

end
