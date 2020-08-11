# frozen_string_literal: true

require 'date'
require 'json'
require 'net/http'
require 'uri'
require 'timeout'
require 'time'

require 'libyui_client/version'
require 'libyui_client/local_process'
require 'libyui_client/widgets'
require 'libyui_client/logger'
require 'libyui_client/timer'
require 'libyui_client/wait'
require 'libyui_client/app'
require 'libyui_client/http/http_client'
require 'libyui_client/http/response'
require 'libyui_client/http/version_controller'
require 'libyui_client/http/widget_controller'
require 'libyui_client/error'
require 'libyui_client/actions'
require 'libyui_client/filter_extractor'

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient
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
    @logger ||= LibyuiClient::Logger.new
  end
end
