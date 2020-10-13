# frozen_string_literal: true

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient
  class LocalProcess
    # default timeout for process
    DEFAULT_TIMEOUT_PROCESS = 2

    # start the application in background
    # @param application [String] the command to start
    def start_app(application)
      @app_host = 'localhost'
      @app_port = port

      # another app already running?
      raise "The port #{@app_host}:#{@app_port} is already open!" if port_open?(@app_host, @app_port)

      LibyuiClient.logger.debug("Starting #{application}...")
      # create a new process group so easily we will be able
      # to kill all its sub-processes
      @app_pid = spawn(application, pgroup: true)
      wait_for_port(@app_host, @app_port)
      LibyuiClient.logger.debug("App started: '#{application}'")
    end

    # kill the process if it is still running after finishing a scenario
    def kill_app
      return unless @app_pid

      Process.waitpid(@app_pid, Process::WNOHANG)
      LibyuiClient.logger.debug("Sending KILL signal for PID #{@app_pid}")
      Process.kill('-KILL', @app_pid)
    rescue Errno::ECHILD, Errno::ESRCH
      # the process has already exited
      @app_pid = nil
    end

    private

    # set the application introspection port for communication
    def port
      ENV['YUI_HTTP_PORT'] ||= '9999'
    end

    # is the target port open?
    # @param host [String] the host to connect to
    # @param port [Integer] the port number
    # @return [Boolean] true if the port is open, false otherwise
    def port_open?(host, port)
      TCPSocket.new(host, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      false
    end

    # wait until the specified port is open or until the timeout is reached
    # @param host [String] the host to connect to
    # @param port [Integer] the port number
    # @raise LibyuiClient::Error::TimeoutError if the port is not opened in time
    def wait_for_port(host, port)
      Wait.until(timeout: LibyuiClient.timeout, interval: LibyuiClient.interval) do
        LibyuiClient.logger.debug("Waiting for #{host}:#{port}...")
        port_open?(host, port)
      end
    end

    # optionally allow a short delay between the steps to watch the UI changes
    def add_step_delay
      delay = ENV['STEP_DELAY'].to_f
      sleep(delay) if delay.positive?
    end
  end
end
