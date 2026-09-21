# frozen_string_literal: true

require 'faraday'
require 'json'
require 'browserstack/automate/api'

module Browserstack
  module Automate
    # This class encapsulates the JSON returned from the browserstack Status API such as
    #
    # {
    #   "used_time": 458701,
    #   "total_available_time": "Unlimited Testing Time",
    #   "running_sessions": 0,
    #   "sessions_limit": 25
    # }
    # https://api.browserstack.com/5/status.json
    #
    class Status
      attr_reader :used_time, :total_available_time, :running_sessions, :sessions_limit

      def initialize
        connection = Faraday.new(url: "#{API_URL}/#{API_VERSION}/status.json") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        @status = JSON.parse(response.body)

        @used_time = @status['used_time']
        @total_available_time = @status['total_available_time']
        @running_sessions = @status['running_sessions']
        @sessions_limit = @status['sessions_limit']
      end

      def to_s
        output = ''
        output << "used_time: #{@used_time}\n"
        output << "total_available_time: #{@total_available_time}\n"
        output << "running_sessions: #{@running_sessions}\n"
        output << "sessions_limit: #{@sessions_limit}\n"
      end

      def inspect
        @status.inspect
      end
    end # Status
  end # Automate
end # Browserstack
