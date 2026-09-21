# frozen_string_literal: true

require 'faraday'
require 'json'
require 'browserstack/automate/api'

module Browserstack
  module Automate
    # This class encapsulates the JSON returned from the browserstack automate plan API such as
    #
    # {
    #   "automate_plan": "Enterprise Plus",
    #   "parallel_sessions_running": 0,
    #   "team_parallel_sessions_max_allowed": 25,
    #   "parallel_sessions_max_allowed": 25,
    #   "queued_sessions": 0,
    #   "queued_sessions_max_allowed": 25
    # }
    # https://api.browserstack.com/automate/plan.json
    class Plan
      attr_reader :automate_plan, :parallel_sessions_running, :team_parallel_sessions_max_allowed
      attr_reader :parallel_sessions_max_allowed, :queued_sessions, :queued_sessions_max_allowed

      def initialize
        connection = Faraday.new(url: "#{API_URL}/automate/plan.json") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        @plan = JSON.parse(response.body)

        @automate_plan = @plan['automate_plan']
        @parallel_sessions_running = @plan['parallel_sessions_running']
        @team_parallel_sessions_max_allowed = @plan['team_parallel_sessions_max_allowed']
        @parallel_sessions_max_allowed = @plan['parallel_sessions_max_allowed']
        @queued_sessions = @plan['queued_sessions']
        @queued_sessions_max_allowed = @plan['queued_sessions_max_allowed']
      end

      def print_all
        @plan.each do |key, value|
          puts "#{key}: #{value}\n"
        end
      end

      def to_s
        output = ''
        output << "automate_plan: #{@automate_plan}\n"
        output << "parallel_sessions_running: #{@parallel_sessions_running}\n"
        output << "team_parallel_sessions_max_allowed: #{@team_parallel_sessions_max_allowed}\n"
        output << "parallel_sessions_max_allowed: #{@parallel_sessions_max_allowed}\n"
        output << "queued_sessions: #{@queued_sessions}\n"
        output << "queued_sessions_max_allowed: #{@queued_sessions_max_allowed}\b"
      end

      def inspect
        @plan.inspect
      end
    end # Plan
  end # Automate
end # Browserstack
