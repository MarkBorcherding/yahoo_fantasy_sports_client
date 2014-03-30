require 'oauth'
require 'fileutils'
require 'active_support/concern'

module YahooFantasySportsClient
  module Resource
    extend ActiveSupport::Concern

    module ClassMethods
      def access_token=(value)
        @access_token = value
      end

      def access_token
        @access_token
      end

      def all(resource_url, klass = self)
        klass.parse get(resource_url)
      end

      def single(resource_url, klass = self)
        klass.parse resource_url, single: true
      end

      def get(resource_url)
        response = access_token.get "#{base_url}#{resource_url}"
        response.body
      rescue OAuth::Problem => e
        puts e
        FileUtils.rm '.access_token', force: true
        FileUtils.rm '.access_secret', force: true
        exit
      rescue
        puts 'who knows'
        exit
      end

      def base_url
        "http://fantasysports.yahooapis.com/fantasy/v2/"
      end
    end
  end
end
