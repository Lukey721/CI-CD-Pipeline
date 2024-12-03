require 'application_insights'

ApplicationInsights.setup do |config|
  config.instrumentation_key = ENV.fetch('3e1c8387-ebe6-432f-bdf3-af4ef9658d98', nil)
end

Rails.logger.info('Application Insights has been configured.')
