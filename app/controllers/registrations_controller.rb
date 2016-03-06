class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :html, :js, :json
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
