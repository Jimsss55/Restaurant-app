class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def record_not_found
    respond_to do |format|
      format.html { redirect_to root_path, alert: "Record not found" }
      format.json { render json: { error: "Record not found" }, status: :not_found }
    end
  end
end
