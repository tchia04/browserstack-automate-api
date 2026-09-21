# frozen_string_literal: true

require 'faraday'
require 'json'
require 'yaml'
require 'browserstack/automate/api'
require 'browserstack/automate/builds'

module Browserstack
  module Automate
    # This class encapsulates the JSON returned from the browserstack Session API such as
    class Sessions
      # rubocop:disable Metrics/LineLength
      # https://api.browserstack.com/automate/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0.json
      # {
      #     "automation_session": {
      #         "name": "login_via_username_password_spec",
      #         "duration": 36,
      #         "os": "OS X",
      #         "os_version": "Mojave",
      #         "browser_version": "69.0",
      #         "browser": "chrome",
      #         "device": null,
      #         "status": "failed",
      #         "hashed_id": "6067a0c82671094ce1ea8ba4e6c1f451722daca0",
      #         "reason": "completed",
      #         "build_name": "MB184-TChia.local_2019-07-10_15-38-25-25",
      #         "project_name": "spike",
      #         "logs": "https://automate.browserstack.com/builds/219054a7ba1350b613da5bb39a25c8ea9e1310c2/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0/logs",
      #         "browser_url": "https://automate.browserstack.com/builds/219054a7ba1350b613da5bb39a25c8ea9e1310c2/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0",
      #         "public_url": "https://automate.browserstack.com/builds/219054a7ba1350b613da5bb39a25c8ea9e1310c2/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0?auth_token=7348e1cb8eeacb8bb3b770d63a34d3238359f68cf4750abc536e4fc4811cfde5",
      #         "appium_logs_url": "https://api.browserstack.com/automate/builds/219054a7ba1350b613da5bb39a25c8ea9e1310c2/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0/appiumlogs",
      #         "video_url": "https://automate.browserstack.com/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0/video?token=cldiRENRTlRPK2ptNnh1OGQya1NPeVJkV2pscXhxVXhMcFRrVHp1c09xVjdHR2hYcmJiL3ljT2tBZW9RNHVnZWJ1WDJYMTZPWTlOSWJQZE5zUWx5TGc9PS0tbTF0SXN4M0lPTHlDY3FDS3NyTHg5Zz09--53c3ca44b6c1a17629312c7bca44f289e6736de6&source=rest_api&diff=512514.458711372",
      #         "browser_console_logs_url": "https://automate.browserstack.com/s3-upload/bs-selenium-logs-usw/s3.us-west-1/6067a0c82671094ce1ea8ba4e6c1f451722daca0/6067a0c82671094ce1ea8ba4e6c1f451722daca0-console-logs.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2XUQHUQMB2AUQQUB%2F20190716%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Date=20190716T210056Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d9c481c8a075e8aa756587c598221799bc5a63934556b6c5a4b19e170afc813b",
      #         "har_logs_url": "https://automate.browserstack.com/s3-upload/bs-video-logs-usw/s3.us-west-1/6067a0c82671094ce1ea8ba4e6c1f451722daca0/6067a0c82671094ce1ea8ba4e6c1f451722daca0-har-logs.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2XUQHUQMK3HVSF4L%2F20190716%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Date=20190716T210056Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b3bf2a0de44d946a0c3343e21ab28d6b79568965fb7adac145547aab4be0de47",
      #         "selenium_logs_url": "https://automate.browserstack.com/s3-upload/bs-video-logs-usw/s3.us-west-1/6067a0c82671094ce1ea8ba4e6c1f451722daca0/6067a0c82671094ce1ea8ba4e6c1f451722daca0-selenium-logs.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2XUQHUQMK3HVSF4L%2F20190716%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Date=20190716T210056Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ea730c2b05d3e3e91fd5b307f1607be60ea30d99fa4be92dfd4219ea730f6ac6"
      #     }
      # }
      #
      # rubocop:enable Metrics/LineLength
      attr_reader :name, :duration, :os, :os_version, :browser_version, :browser, :device
      attr_reader :status, :hashed_id, :reason, :build_name, :project_name, :logs, :browser_url
      attr_reader :public_url, :appium_logs_url, :video_url, :browser_console_logs_url, :har_logs_url, :selenium_logs_url

      def get_sessions_by_build_name(build_name)
        builds = Browserstack::Automate::Builds.new
        build_id = builds.get_build_id_by_name(build_name)
        # puts "build_id=#{build_id}"
        if !build_id.empty? # rubocop:disable Style/GuardClause
          connection = Faraday.new(url: "#{API_URL}/automate/builds/#{build_id}.json") do |conn|
            conn.adapter Faraday.default_adapter # make requests with Net::HTTP
            conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
          end
          response = connection.get
          http_response_code_check response
          @build_session = JSON.parse(response.body)['build']['sessions']
        else
          raise "Unable to find Build ID for Build Name: #{build_name}"
        end
      end

      # query a particular session is by using the session ID directly.
      # Use this method to lookup session info such as test status, build id and browser configurations, etc
      # Usage: session_info=Browserstack::Automate::Sessions.new.get_session_info_by_id('3b3ac82334f5450d04eb72dd0e4ee602087efc36')
      # puts session_info.status
      def get_session_info_by_id(session_id)
        if !session_id.empty?
          connection = Faraday.new(url: "#{API_URL}/automate/sessions/#{session_id}.json") do |conn|
            conn.adapter Faraday.default_adapter # make requests with Net::HTTP
            conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
          end
          response = connection.get
          http_response_code_check response
          @session = JSON.parse(response.body)

          @name = @session['automation_session']['name']
          @duration = @session['automation_session']['duration']
          @os = @session['automation_session']['os']
          @os_version = @session['automation_session']['os_version']
          @browser_version = @session['automation_session']['browser_version']
          @browser = @session['automation_session']['browser']
          @device = @session['automation_session']['device']
          @status = @session['automation_session']['status']
          @hashed_id = @session['automation_session']['hashed_id']
          @reason = @session['automation_session']['reason']
          @build_name = @session['automation_session']['build_name']
          @project_name = @session['automation_session']['project_name']
          @logs = @session['automation_session']['logs']
          @browser_url = @session['automation_session']['browser_url']
          @public_url = @session['automation_session']['public_url']
          @appium_logs_url = @session['automation_session']['appium_logs_url']
          @video_url = @session['automation_session']['video_url']
          @browser_console_logs_url = @session['automation_session']['browser_console_logs_url']
          @har_logs_url = @session['automation_session']['har_logs_url']
          @selenium_logs_url = @session['automation_session']['selenium_logs_url']
          self
        else
          "Invalid Session ID: #{session_id}"
        end
      end

      # returns the build_id given a session id
      def get_build_id(session_id:)
        build_id_session = Browserstack::Automate::Sessions.new.get_session_info_by_id(session_id.to_s)
        build_id = build_id_session.logs.split('/')[4]
        build_id
      end

      # https://automate.browserstack.com/dashboard/v2/builds/6c713a62c109fdb22328a2eccb7da61ed130a42e
      def get_browserstack_build_url(session_id:)
        build_id = get_build_id(session_id: session_id.to_s)
        build_url = "https://automate.browserstack.com/dashboard/v2/builds/#{build_id}"
        build_url
      end

      # https://automate.browserstack.com/dashboard/v2/builds/6c713a62c109fdb22328a2eccb7da61ed130a42e/sessions/3b3ac82334f5450d04eb72dd0e4ee602087efc36
      def get_browserstack_session_url(session_id:)
        build_id = get_build_id(session_id: session_id.to_s)
        session_url = "https://automate.browserstack.com/dashboard/v2/builds/#{build_id}/sessions/#{session_id}"
        session_url
      end

      # https://api.browserstack.com/automate/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0.json
      def update_test_result(session_id:, test_result_status:, reason:)
        conn = Faraday.new(url: API_URL.to_s)
        conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        if !session_id.empty? # rubocop:disable Style/GuardClause
          # post payload as JSON instead of "www-form-urlencoded" encoding:
          response = conn.put do |req|
            req.url "/automate/sessions/#{session_id}.json"
            # response connection = Faraday.new(url: "#{API_URL}/automate/sessions/#{session_id}.json") do | req |
            req.headers['Content-Type'] = 'application/json'
            req.body = "{\"status\": \"#{test_result_status}\", \"reason\": \"#{reason}\"}"
            # req.body = '{"status": "failed", "reason": "some_reason"}'
          end
          http_response_code_check response
          response.body
        else
          raise 'Session ID should NOT be empty'
        end
      end

      # session_eg.get_session_info_by_id('2a94ee7370d9a0f1583097823b99540769298b95').status
      def update_test_result_example_group(session_id:, test_result_status:, reason:)
        session = Browserstack::Automate::Sessions.new
        session_info = session.get_session_info_by_id(session_id.to_s)
        current_session_status = session_info.status
        # if ['done', 'running'].include?(current_session_status)
        if %w[done running timeout].include?(current_session_status)
          # if current_session_status == 'done' || current_session_status == 'running'
          # puts "Changing  to #{test_result_status}"
          session.update_test_result(session_id: session_id.to_s,
                                     test_result_status: test_result_status.to_s,
                                     reason: reason.to_s)
        elsif (current_session_status == 'passed') && (test_result_status == 'failed')
          # puts 'Changing to failed'
          session.update_test_result(session_id: session_id.to_s,
                                     test_result_status: 'failed',
                                     reason: 'failed reason')
          # else
          # puts 'No need to change'
        end
      end
    end # Sessions
  end # Automate
end # Browserstack
