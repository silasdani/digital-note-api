module Api
  module V1
    class ExamsController < Api::V1::ApiController
      before_action :set_exam, only: %i[show update]
      skip_after_action :verify_authorized, :verify_policy_scoped
      skip_before_action :authenticate_user!, only: %i[view_exam]

      def create
        @exam = Exam.create(exam_params.merge({ user_id: current_user.id }))

        if @exam.persisted?
          render json: ExamSerializer.new(@exam).serialized_json, status: :ok
        else
          render json: { error: @exam.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        @exams = policy_scope(Exam.includes(%i[submissions file_attachment]))

        @exams = @exams.active if params[:active] == "1"
        @exams = @exams.draft if params[:draft] == "1"
        @exams = @exams.archived if params[:archived] == "1"
        @exams = @exams.completed if params[:completed] == "1"

        render json: ExamSerializer.new(@exams).serialized_json, status: :ok
      end

      def show
        render json: ExamSerializer.new(@exam).serialized_json, status: :ok
      end

      def update
        if @exam.update exam_params
          render json: ExamSerializer.new(@exam).serialized_json, status: :ok
        else
          render json: { error: @exam.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def view_exam
        @exam = Exam.find_by(access_key: params[:access_key])

        render json: ExamSerializer.new(@exam).serialized_json, status: :ok
      end

      private

      def exam_params
        convert_file_params([:file],
                            params.require(:exam).permit(
          :access_key, :name, :start_time,
          :end_time, :security,
          :status, :file, :description, :exam_type
        )).merge({ questions: question_params })
      end

      def question_params
        return [] if params[:questions].blank?

        converted_question_params_from(params)
      end

      def set_exam
        @exam = Exam.find(params[:id])
        authorize @exam
      end
    end
  end
end
