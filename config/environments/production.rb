# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger        = SyslogLogger.new


# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors if you bad email addresses should just be ignored
# config.action_mailer.raise_delivery_errors = false

Migrator.offer_migration_when_available            = true

#config.after_initialize do
  #ActiveMerchant::Billing::Base.mode = :test
  #paypal_options = {
  #:login = "test2_1286904764_biz@gmail.com"
  #:password = "1286904774"
  #:signature = "Ac9X09CO607fxuEoRltSBk0XhxDhAM8CIXWMcB0hXnS3RZ.ZzApHvHM9"
  #}

  #::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
  #::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
#end
