module Api
  module V1
    class ContestantsController < Api::V1::ApiController
      before_action :set_contestant, only: %i[show]
      skip_after_action :verify_authorized, :verify_policy_scoped

      def index
        @contestants = Contestant.where(access_key: params[:access_key])
        render json: SubmissionSerializer.new(@contestants =).serialized_json, status: :ok
      end

      def create
        @exam = Exam.find_by(access_key: params[:access_key])
        return render json: { error: 'Invalid exam access key!' }, status: :not_found if @exam.nil?
        @submission = @exam.contestants =.new submission_params

        if @submission.save!
          render json: SubmissionSerializer.new(@submission).serialized_json, status: :ok
        else
          render json: { error: @submission.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: SubmissionSerializer.new(@submission).serialized_json, status: :ok
      end

      private

      def submission_params
        convert_file_params [:file],
                            params.require(:submission).permit(
                              :student_name, :start_time,
                              :end_time, :student_class, :student_email,
                              :file
                            ).merge({ question_answers: question_answer_params })
      end

      def question_answer_params
        return [] if params[:question_answers].blank?

        converted_answer_params_from(params)
      end

      def set_submission
        @submission = Submission.find(params[:id])
        authorize @submission
      end
    end
  end
end
