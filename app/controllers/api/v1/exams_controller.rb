module Api
  module V1
    class ExamsController < Api::V1::ApiController
      before_action :set_exam, only: %i[show update]
      # after_action :verify_policy_scoped, except: :index

      def index
        @exams = Exam.all
        render json: ExamSerializer.new(@exams).serialized_json, status: :ok
      end

      def show; end

      def update
        render json: ExamSerializer.new(@exam).serialized_json, status: :ok
      end

      private

      def exam_params
        params.require(:exam).permit(:access_key, :name, :start_time, :end_time, :security, :status)
      end

      def set_exam
        @exam = Exam.find(params[:id])
      end
    end
  end
end
