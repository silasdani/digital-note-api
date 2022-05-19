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

      def converted_credential_params_from(params, user_id = nil)
        credentials = params.fetch(:credentials)
        keys = credentials.values.select { |v| v && !v.is_a?(Array) }.pluck(:type)

        credential_type_map = CredentialType.where(name: keys).to_h do |type|
          [type.name, type.id]
        end

        converted_credentials = []

        credentials.each do |key, cred_params|
          next if cred_params.is_a?(Array)
          next if cred_params.blank?

          type = cred_params[:type]
          type = key.underscore if type.blank?

          credential = Credential.new(
            user_id: user_id,
            credential_type_id: credential_type_map[type],
            valid_through: cred_params.fetch(:valid_through, nil),
            states_valid: cred_params.fetch(:states_valid, nil),
            license_number: cred_params.fetch(:license_number, nil),
            role: cred_params.fetch(:role, nil),
            license_type: cred_params.fetch(:license_type, nil),
            certification: cred_params.fetch(:certification, nil),
            institution: cred_params.fetch(:institution, nil),
            specialty_type: cred_params.fetch(:specialty_type, nil)
          )

          converted_credentials << credential if credential.document.attached?
        end

        converted_credentials
      end
    end
  end
end
