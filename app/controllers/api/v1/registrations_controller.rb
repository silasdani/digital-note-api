module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception, unless: :json_request?
      include Api::Concerns::ActAsApiRequest
      include Api::Concerns::Base64Converter

      private

      def sign_up_params
        convert_file_params [:profile_pic],
        params.require(:user).permit(:email, :password, :password_confirmation,
                                     :username, :first_name, :last_name, :profile_pic,
                                     :phone_no, :address)
      end

      def render_create_success
        render :create
      end
    end
  end
end
