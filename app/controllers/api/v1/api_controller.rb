module Api
  module V1
    class ApiController < ActionController::API
      include Api::Concerns::ActAsApiRequest
      include Pundit::Authorization
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Api::Concerns::Base64Converter

      after_action :verify_authorized, except: :index
      after_action :verify_policy_scoped, only: [:index]

      before_action :authenticate_user!, except: :status
      skip_after_action :verify_authorized, only: %i[status]

      rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing

      def status
        render json: { online: true }
      end

      private

      def render_not_found(exception)
        logger.info { exception } # for logging
        render json: { error: I18n.t('api.errors.not_found') }, status: :not_found
      end

      def render_record_invalid(exception)
        logger.info { exception } # for logging
        render json: { errors: exception.record.errors.as_json }, status: :bad_request
      end

      def render_parameter_missing(exception)
        logger.info { exception } # for logging
        render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
      end

      rescue_from Pundit::NotAuthorizedError do |exception|
        policy = exception.policy
        policy_name = exception.policy.class.to_s.underscore

        error_key = if policy.respond_to?(:policy_error_key) && policy.policy_error_key
                      policy.policy_error_message
                    else
                      exception.query
                    end

        render json: { error: I18n.t("#{policy_name}.#{error_key}", scope: 'pundit',
                                                                    default: :default) }
      end
    end
  end
end
