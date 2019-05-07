class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ActionController::MimeResponds
end
