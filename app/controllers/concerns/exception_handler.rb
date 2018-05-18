module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      respond_to do |format|
        format.html { redirect_to root_path, alert: I18n.t('expense.record_not_found') }
        format.json { render json: { message: e.message }, status: :not_found }
      end
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      respond_to do |format|
        format.json { render json: { message: e.message }, status: :unprocessable_entity }
      end
    end
  end
end
