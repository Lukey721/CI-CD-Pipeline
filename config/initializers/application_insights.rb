# frozen_string_literal: true

require 'application_insights'

ApplicationInsights::TelemetryClient.new(
  ENV.fetch('3e1c8387-ebe6-432f-bdf3-af4ef9658d98', nil)
)
