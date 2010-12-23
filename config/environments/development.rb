# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes     = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils        = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

def log_to(stream)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
end

config.log_level = :debug

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  #paypal_options = {
  #:login = "test2_1286904764_biz@gmail.com",
  #:password = "1286904774",
  #:signature = "Ac9X09CO607fxuEoRltSBk0XhxDhAM8CIXWMcB0hXnS3RZ.ZzApHvHM9"
  #}

  #::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
  #::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
end
