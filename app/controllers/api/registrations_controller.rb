class Api::RegistrationsController < Devise::RegistrationsController
    #skip_before_filter :verify_authenticity_token
    respond_to :json

    def create
        @user = User.new(:first_name => params[:first_name],
                         :last_name => params[:last_name],
                         :email => params[:email], 
                         :password => params[:password],
                         :password_confirmation => params[:password_confirmation])

        if @user.save
            render :status => 200, :json => @user.to_json
        else
            logger.info("Unable to create user #{params[:email]}")
            render :status => 500, :json => { :message => "Unable to register user",
                :validation_errors => @user.errors.full_messages }
        end
    end

    def update
        super
    end
end