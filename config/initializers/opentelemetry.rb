require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'

# Configure OpenTelemetry SDK
OpenTelemetry::SDK.configure do |c|
  # Automatically enable default instrumentation, such as Rails, HTTP, and more.
  c.use_all

  # Add the OTLP exporter to send telemetry data
  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(
        endpoint: ENV.fetch('https://otlp-gateway-prod-eu-west-2.grafana.net/otlp', nil), # URL of the OTLP endpoint
        headers: { 'x-api-key' => ENV.fetch('glc_eyJvIjoiMTI4NTU0OSIsIm4iOiJzdGFjay0xMTA1MzY5LW90bHAtd3JpdGUtdGVsZSIsImsiOiI4TW03bjNzWDFadjVMOVRwTkdoNjU3TzQiLCJtIjp7InIiOiJwcm9kLWV1LXdlc3QtMiJ9fQ==',
                                            nil) }
      )
    )
  )
end
