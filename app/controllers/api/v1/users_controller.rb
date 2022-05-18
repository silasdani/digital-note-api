module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :auth_user

      def show; end

      def update
        current_user.update!(user_params)
        render :show
      end

      private

      def auth_user
        authorize current_user
      end

      def user_params
        convert_file_params [:profile_pic],
        params.require(:user).permit(:username, :first_name, :last_name, :email, :profile_pic, :phone_no, :address)
      end
    end
  end
end
