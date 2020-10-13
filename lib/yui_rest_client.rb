# frozen_string_literal: true

require 'date'
require 'json'
require 'net/http'
require 'uri'
require 'timeout'
require 'time'

require 'yui_rest_client/version'
require 'yui_rest_client/local_process'
require 'yui_rest_client/widgets'
require 'yui_rest_client/logger'
require 'yui_rest_client/timer'
require 'yui_rest_client/wait'
require 'yui_rest_client/app'
require 'yui_rest_client/http/http_client'
require 'yui_rest_client/http/response'
require 'yui_rest_client/http/version_controller'
require 'yui_rest_client/http/widget_controller'
require 'yui_rest_client/error'
require 'yui_rest_client/actions'
require 'yui_rest_client/filter_extractor'

# Client to interact with YAST UI rest api framework for integration testing
module YuiRestClient
  class << self
    attr_writer :timeout, :interval

    def timeout
      @timeout ||= 5
    end

    def interval
      @interval ||= 0.5
    end
  end

  def self.logger
    @logger ||= YuiRestClient::Logger.new
  end
end
