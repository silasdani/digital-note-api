module Api
  module V1
    class ContestantsController < Api::V1::ApiController
      before_action :set_contestant, only: %i[show update]
      skip_after_action :verify_authorized, :verify_policy_scoped
      skip_before_action :authenticate_user!, only: %i[show create]

      def index
        @contestants = Contestant.where(access_key: params[:access_key])
        render json: ContestantSerializer.new(@contestants).serialized_json, status: :ok
      end

      def create
        @contestant = Contestant.new contestant_params

        if @contestant.save
          render json: ContestantSerializer.new(@contestant).serialized_json, status: :ok
        else
          render json: { error: @contestant.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @contestant.update! contestant_params
        render json: ContestantSerializer.new(@contestant).serialized_json, status: :ok
      end

      def show
        render json: ContestantSerializer.new(@contestant).serialized_json, status: :ok
      end

      private

      def contestant_params
        params.require(:contestant).permit([:first_name, :last_name, :email, :access_key,
                                            :student_class, { permissions: [] }])
      end

      def set_contestant
        @contestant = Contestant.find(params[:id])
        authorize @contestant
      end
    end
  end
end
