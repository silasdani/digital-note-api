module Api
  module Concerns
    module Base64Converter
      extend ActiveSupport::Concern

      def base64_to_uploaded_file(input, filename)
        encoded_string = input.split(/[:;,]/)[3]
        return unless encoded_string

        tempfile = Tempfile.new(filename)
        tempfile.binmode
        tempfile.write Base64.decode64(encoded_string)
        tempfile.close

        content_type = `file --mime -b #{tempfile.path}`.split(';')[0]
        extension = content_type.match(/gif|jpeg|jpg|pdf|png/).to_s
        filename += ".#{extension}" if extension

        ActionDispatch::Http::UploadedFile.new({
                                                 tempfile: tempfile,
                                                 content_type: content_type,
                                                 filename: filename
                                               })
      end

      def convert_file_params(param_names, params)
        param_names.each do |name|
          if params[name].is_a? String
            if /^data:.*;base64/.match? params[name]
              params[name] = base64_to_uploaded_file(params[name], name.to_s)
            else
              params.delete(name)
            end
          end
        end
        params
      end

      def converted_question_params_from(params)
        questions = params.fetch(:questions)
        converted_questions = []

        questions.each do |question_params|
          next if question_params.is_a?(Array) || question_params.blank?

          file = question_params.fetch(:file, '')
          question = Question.new(
            no: question_params.fetch(:no, nil),
            text_statement: question_params.fetch(:text_statement, nil),
            options: question_params.fetch(:options, nil),
            selects: question_params.fetch(:selects, nil),
            question_type: question_params.fetch(:question_type, nil),
            tag: question_params.fetch(:tag, nil),
            required: question_params.fetch(:required, nil),
            description: question_params.fetch(:description, nil),
            exam_id: question_params.fetch(:exam_id, nil)
          )

          if /^data:.*;base64/.match? file
            question.file = base64_to_uploaded_file(file,
                                                    'file')
          end

          converted_questions << question
        end

        converted_questions
      end

      def converted_answer_params_from(params)
        answers = params.fetch(:question_answers)
        converted_answers = []

        answers.each do |answer_params|
          next if answer_params.is_a?(Array) || answer_params.blank?

          file = answer_params.fetch(:file, '')
          question = QuestionAnswer.new(
            no: answer_params.fetch(:no, nil),
            text: answer_params.fetch(:text, nil),
            option: answer_params.fetch(:option, nil),
            selects: answer_params.fetch(:selects, nil)
          )
          question.file = base64_to_uploaded_file(file, 'file') if /^data:.*;base64/.match? file

          converted_answers << question
        end

        converted_answers
      end
    end
  end
end
