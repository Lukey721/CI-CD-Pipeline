SecureHeaders::Configuration.default do |config|
  config.csp = {
    default_src: ["'self'"],# Allows content only from the same origin
    object_src: ["'none'"], # Disallow plugins
    frame_ancestors: ["'none'"] # Disallow embedding
  }
end