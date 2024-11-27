# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    # As ZAP report recommended generate a cryptographically secure random nonce
    nonce = SecureRandom.base64(16)
    policy.default_src :self, :https
    policy.font_src    :self, :https
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https, :unsafe_inline, "'nonce-#{nonce}'"
    policy.style_src   :self, :https, :unsafe_inline, "'nonce-#{nonce}'"
    policy.report_uri '/csp-violation-report-endpoint'

    # If using nonces for inline scripts/styles
    config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
    config.content_security_policy_nonce_directives = %w[script-src style-src]
  end
  #   # Report violations without enforcing the policy.
  #   # config.content_security_policy_report_only = true
end
