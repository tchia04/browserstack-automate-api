# frozen_string_literal: true

require 'faraday'
require 'json'
require 'browserstack/automate/api'

module Browserstack
  module Automate
    #
    # This class encapsulates the JSON returned from the browserstack projects API such as
    #
    # [
    #    {
    #        "id": 722651,
    #        "name": "Untitled Project",
    #        "group_id": 3294070,
    #        "user_id": 3505496,
    #        "created_at": "2018-10-25T00:12:17.000Z",
    #        "updated_at": "2019-07-09T21:10:56.000Z"
    #    }
    # ]
    # https://api.browserstack.com/automate/projects.json
    #
    class Projects
      # attr_reader :id, :name, :group_id, :user_id, :created_at, :updated_at

      def initialize
        connection = Faraday.new(url: "#{API_URL}/automate/projects.json") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        @all_projects = JSON.parse(response.body)
      end

      def get_project_id_by_name(project_name:)
        found_project_id = ''
        @all_projects.each do |project|
          found_project_id = project['id'] if project['name'] == project_name
        end
        found_project_id
      end

      # This is similar to the following URL but searching the project name in the hash
      # curl -u "username:accesskey" https://api.browserstack.com/automate/projects/<project-id>.json
      def get_project_by_name(project_name:)
        found_project = {}
        @all_projects.each do |project|
          found_project = project if project['name'] == project_name
        end
        found_project
      end

      # This is similar to the following URL but using project name by making another API call
      # https://api.browserstack.com/automate/projects/788634.json
      def get_builds_by_name(project_name:)
        project_id = get_project_id_by_name(project_name: project_name)
        connection = Faraday.new(url: "#{API_URL}/automate/projects/#{project_id}.json") do |conn|
          conn.adapter Faraday.default_adapter # make requests with Net::HTTP
          conn.basic_auth(ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY'])
        end
        response = connection.get
        @project_builds = JSON.parse(response.body)
      end
    end # Projects
  end # Automate
end # Browserstack
