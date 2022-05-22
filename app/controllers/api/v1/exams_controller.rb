module Api
  module V1
    class ExamsController < Api::V1::ApiController
      before_action :set_exam, only: %i[show update]
      skip_after_action :verify_authorized, :verify_policy_scoped

      def create
        create_params = exam_params.merge({ questions: question_params })

        @exam = Exam.create(create_params)

        if @exam.persisted?
          render json: ExamSerializer.new(@exam).serialized_json, status: :ok
        else
          render json: { error: 'Invalid exam parameters. Please try again.' },
                 status: :unprocessable_entity
        end
      end

      def index
        @exams = Exam.all
        render json: ExamSerializer.new(@exams).serialized_json, status: :ok
      end

      def show
        render json: ExamSerializer.new(@exam).serialized_json, status: :ok
      end

      def update
        @exam.update exam_params
        render json: ExamSerializer.new(@exam).serialized_json, status: :ok
      end

      private

      def exam_params
        params.require(:exam).permit(:access_key, :name, :start_time, :end_time, :security, :status)
      end

      def question_params
        return [] if params[:questions].blank?

        converted_question_params_from(params)
      end

      def set_exam
        @exam = Exam.find(params[:id])
      end
    end
  end
end
