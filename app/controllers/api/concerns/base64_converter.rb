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
    end
  end
end
