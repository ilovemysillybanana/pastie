class SessionsController < Devise::SessionsController
    respond_to :html, :js, :json
end
