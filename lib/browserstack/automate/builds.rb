# frozen_string_literal: true

require 'faraday'
require 'json'
require 'browserstack/automate/api'

module Browserstack
  module Automate
    # This class encapsulates the JSON returned from the browserstack build API such as
    #
    # [
    #     {
    #         "automation_build": {
    #             "name": "MB184-TChia.local_2019-07-12_15-52-03-03",
    #             "duration": 29,
    #             "status": "done",
    #             "hashed_id": "09c633cc41b04976307906fce73787fca4611626"
    #         }
    #     },
    #     {
    #         "automation_build": {
    #             "name": "browserstack_login_desktop-112",
    #             "duration": 119,
    #             "status": "done",
    #             "hashed_id": "885e4d1b2b3e71d009c9475c688a740105a79277"
    #         }
    #     }
    # ]
    # https://api.browserstack.com/automate/builds.json
    class Builds
      # def get_all_builds()
      def initialize
        connection = Faraday.new(url: "#{API_URL}/automate/builds.json?limit=999") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        http_response_code_check response
        @all_builds = JSON.parse(response.body)
      end

      def get_build_id_by_name(build_name)
        found_build_id = ''
        @all_builds.each do |build|
          found_build_id = build['automation_build']['hashed_id'] if build['automation_build']['name'] == build_name
        end
        found_build_id
      end

      # This is similar to the following URL but using build name
      # curl -u "username:accesskey" https://api.browserstack.com/automate/builds/<build-id>.json
      def get_build_by_name(build_name)
        found_build = {}
        # @all_builds=self.get_all_builds
        @all_builds.each do |build|
          # if build['automation_build']['name'] == "#{build_name}"
          found_build = build['automation_build'] if build['automation_build']['name'] == build_name
        end
        found_build
      end

      # Sample build session JSON returned
      # {
      #     "build": {
      #         "automation_build": {
      #             "name": "browserstack_login_mobile-20",
      #             "duration": 107,
      #             "status": "done",
      #             "hashed_id": "bc789ec4115f343fb7d4a59e691b6d3bf85c0e36"
      #         },
      #         "sessions": [
      #             {
      #                 "automation_session": {
      #                     "name": "login_via_username_password_spec",
      #                     "duration": 30,
      #                     "os": "ios",
      #                     "os_version": "12.1",
      #                     "browser_version": null,
      #                     "browser": null,
      #                     "device": "iPhone XS",
      #                     "status": "done",
      #                     "hashed_id": "b87221e7c87b29cb0b121b5f97b321a01d4ca20e",
      #                     "reason": "CLIENT_STOPPED_SESSION",
      #                     "build_name": "browserstack_login_mobile-20",
      #                     "project_name": "spike"
      #                 }
      #             }
      #         ]
      #     }
      # }
      def get_build_sessions_by_name(build_name:)
        build_id = get_build_id_by_name(build_name)
        # print 'build_id=', build_id # when build_name is invalid, "HTTP Basic: Access denied." is returned
        return if build_id.empty?

        connection = Faraday.new(url: "#{API_URL}/automate/builds/#{build_id}.json") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        http_response_code_check response
        @build_session = JSON.parse(response.body)['build']['sessions']
      end

      def get_running_builds # rubocop:disable Naming/AccessorMethodName
        connection = Faraday.new(url: "#{API_URL}/automate/builds.json?limit=999&status=running") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        http_response_code_check response
        @all_running_builds = JSON.parse(response.body)
      end

      def get_failed_builds # rubocop:disable Naming/AccessorMethodName
        connection = Faraday.new(url: "#{API_URL}/automate/builds.json?limit=999&status=failed") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        http_response_code_check response
        @all_failed_builds = JSON.parse(response.body)
      end

      def get_done_builds # rubocop:disable Naming/AccessorMethodName
        connection = Faraday.new(url: "#{API_URL}/automate/builds.json?limit=999&status=done") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        http_response_code_check response
        @all_done_builds = JSON.parse(response.body)
      end

      def get_timeout_builds # rubocop:disable Naming/AccessorMethodName
        connection = Faraday.new(url: "#{API_URL}/automate/builds.json?limit=999&status=timeout") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        http_response_code_check response
        @all_timeout_builds = JSON.parse(response.body)
      end
    end # Builds
  end # Automate
end # Browserstack
