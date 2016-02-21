class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
