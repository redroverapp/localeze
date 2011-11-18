class ApplicationController < ActionController::Base
  include ActionControllerMixin
  ActionView::Base.default_form_builder = ScaffoldLogic::FormBuilder
  before_filter :authenticate_user!
  protect_from_forgery
end