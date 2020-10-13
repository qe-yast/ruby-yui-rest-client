# frozen_string_literal: true

require 'forwardable'
require 'logger'

module LibyuiClient
  class Logger
    extend Forwardable

    def_delegators :@logger, :debug, :debug?,
                   :info, :info?,
                   :warn, :warn?,
                   :error, :error?,
                   :fatal, :fatal?,
                   :level

    def initialize
      @logger = create_logger($stdout)
    end

    def create_logger(output)
      logger = ::Logger.new(output)
      logger.progname = 'LibyuiClient'
      logger.level = default_level
      logger
    end

    def default_level
      ENV['DEBUG'] ? :debug : :info
    end
  end
end
