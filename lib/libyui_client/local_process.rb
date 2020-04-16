# frozen_string_literal: true

require 'timeout'
require 'socket'

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient
  class LocalProcess
    # default timeout for process
    DEFAULT_TIMEOUT_PROCESS = 20

    # start the application in background
    # @param application [String] the command to start
    def self.start_app(application)
      @app_host = 'localhost'
      @app_port = port

      # another app already running?
      if port_open?(@app_host, @app_port)
        raise "The port #{@app_host}:#{@app_port} is already open!"
      end

      LibyuiClient.logger.debug("Starting #{application}...")
      # create a new process group so easily we will be able
      # to kill all its subprocesses
      @app_pid = spawn(application, pgroup: true)
      wait_for_port(@app_host, @app_port)
      LibyuiClient.logger.debug("\tlaunches application '#{application}'")
    end

    def wait_finished_app(seconds: 0)
      raise 'Unknown process PID' unless @app_pid

      timeout = seconds.to_i
      timeout = DEFAULT_TIMEOUT_PROCESS if timeout.zero?

      Timeout.timeout(timeout) do
        Process.wait(@app_pid)
      end
    end

    # kill the testing process if it is still running after finishing a scenario,
    # use the @keep_running tag to avoid killing the process
    def kill_app
      return unless @app_pid

      begin
        (1..5).each do |_i|
          Process.waitpid(@app_pid, Process::WNOHANG)
          sleep(1)
        end
        Process.waitpid(@app_pid, Process::WNOHANG)
        puts 'The process is still running, sending TERM signal...'
        # the minus flag sends the signal to the whole process group
        Process.kill('-TERM', @app_pid)
        sleep(5)
        Process.waitpid(@app_pid, Process::WNOHANG)
        puts 'The process is still running, sending KILL signal...'
        Process.kill('-KILL', @app_pid)
      rescue Errno::ECHILD, Errno::ESRCH
        # the process has already exited
        @app_pid = nil
      end
    end

    private

    # set the application introspection port for communication
    def port
      ENV['YUI_HTTP_PORT'] ||= '9999'
    end

    # is the target port open?
    # @param host [Integer] the host to connect to
    # @param port [Integer] the port number
    # @return [Boolean] true if the port is open, false otherwise
    def port_open?(host, port)
      TCPSocket.new(host, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      false
    end

    # wait until the specified port is open or until the timeout is reached
    # @param host [Integer] the host to connect to
    # @param port [Integer] the port number
    # @raise Timeout::Error when the port is not opened in time
    def wait_for_port(host, port)
      wait = Wait.new(DEFAULT_TIMEOUT_PROCESS, 1)
      wait.timed_retry do
        loop do
          LibyuiClient.logger.debug("Waiting for #{host}:#{port}...")
          break if port_open?(host, port)
        end
      end
    end

    # optionally allow a short delay between the steps to watch the UI changes
    def add_step_delay
      delay = ENV['STEP_DELAY'].to_f
      sleep(delay) if delay.positive?
    end
  end
end
