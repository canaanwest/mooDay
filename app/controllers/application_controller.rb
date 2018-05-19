class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

def render_404
  # DPR: supposedly this will actually render a 404 page in production
  raise ActionController::RoutingError.new('Not Found')
end

end
