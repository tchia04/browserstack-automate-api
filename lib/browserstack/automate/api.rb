# frozen_string_literal: true

# require 'browserstack/automate/api/version'
# require 'browserstack/automate/api/projects'
# require 'browserstack/automate/api/builds'
# require 'browserstack/automate/api/status'
require 'faraday'
require 'json'
require 'yajl'

API_URL = "https://api.browserstack.com"
API_VERSION = "5"

def http_response_code_check(res) # rubocop:disable Metrics/CyclomaticComplexity
  case res.status.to_i
  when 200
    res
  when 400
    raise RuntimeError, "BadRequestError", encode(status: res.status, body: res.body)
  when 401
    raise RuntimeError, "AuthenticationError", encode(status: res.status, body: res.body)
  when 403
    raise RuntimeError, "ForbiddenError", encode(status: res.status, body: res.body)
  when 404
    raise RuntimeError, "NotFoundError", encode(status: res.status)
  when 500
    raise RuntimeError, "Internal Server Error", encode(status: res.status, body: res.body)
  else
    raise RuntimeError, "UnexpectedError", encode(status: res.status, body: res.body)
  end
end

def encode(hash)
  Yajl::Encoder.encode(hash)
end
