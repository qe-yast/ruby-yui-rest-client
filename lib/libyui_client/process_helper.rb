# frozen_string_literal: true

require 'timeout'
require 'socket'
require 'rainbow'
require 'libyui_client/config_reader'

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient
  # default timeout for process
  DEFAULT_TIMEOUT_PROCESS = 20

  # set the host for the application under control
  def self.set_host
    ENV['YUI_HTTP_HOST'] ||= read_config_value('YUI_HTTP_HOST')
  end

  # set the application introspection port for communication
  def self.set_port
    ENV['YUI_HTTP_PORT'] ||= read_config_value('YUI_HTTP_PORT')
    ENV['YUI_HTTP_PORT']
  end

  # set libyui-rest-api API version
  def self.set_api_version
    ENV['YUI_API_VERSION'] ||= read_config_value('YUI_API_VERSION')
  end

  # is the target port open?
  # @param host [Integer] the host to connect to
  # @param port [Integer] the port number
  # @return [Boolean] true if the port is open, false otherwise
  def self.port_open?(host, port)
    TCPSocket.new(host, port).close
    true
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
    false
  end

  # wait until the specified port is open or until the timeout is reached
  # @param host [Integer] the host to connect to
  # @param port [Integer] the port number
  # @raise Timeout::Error when the port is not opened in time
  def self.wait_for_port(host, port)
    Timeout.timeout(DEFAULT_TIMEOUT_PROCESS) do
      loop do
        sleep(1)
        puts "Waiting for #{host}:#{port}..." if ENV['DEBUG']
        break if port_open?(host, port)
      end
    end
  end

  # start the application in background
  # @param application [String] the command to start
  def self.start_app(application)
    @@app_host = set_host
    @@app_port = set_port
    @@api_version = set_api_version

    # another app already running?
    if port_open?(@@app_host, @@app_port)
      raise "The port #{@@app_host}:#{@@app_port} is already open!"
    end

    puts "Starting #{application}..." if ENV['DEBUG']
    # create a new process group so easily we will be able
    # to kill all its subprocesses
    @@app_pid = spawn(application, pgroup: true)
    wait_for_port(@@app_host, @@app_port)
    puts Rainbow("\tlaunches application '#{application}'").blue
  end

  # attach to an already running application
  # @param host [String] the host name ("localhost" when running on the same machine)
  def self.attach(host, port)
    @@app_host = host
    @@app_port = port

    # is the app running?
    raise "Cannot attach to #{@@app_host}:#{@@app_port}!" unless port_open?(@@app_host, @@app_port)
  end

  def self.wait_finished_app(seconds: 0)
    raise 'Unknown process PID' unless @@app_pid
    timeout = seconds.to_i
    timeout = DEFAULT_TIMEOUT_PROCESS if timeout.zero?
    
    Timeout.timeout(timeout) do
      Process.wait(@@app_pid)
    end
  end

  # kill the testing process if it is still running after finishing a scenario,
  # use the @keep_running tag to avoid killing the process
  def self.kill_app
    return unless @@app_pid
    begin
      (1..5).each do |_i|
        Process.waitpid(@@app_pid, Process::WNOHANG)
        sleep(1)
      end
      Process.waitpid(@@app_pid, Process::WNOHANG)
      puts 'The process is still running, sending TERM signal...'
      # the minus flag sends the signal to the whole process group
      Process.kill('-TERM', @@app_pid)
      sleep(5)
      Process.waitpid(@@app_pid, Process::WNOHANG)
      puts 'The process is still running, sending KILL signal...'
      Process.kill('-KILL', @@app_pid)
    rescue Errno::ECHILD, Errno::ESRCH
      # the process has already exited
      @@app_pid = nil
    end
  end

  # optionally allow a short delay between the steps to watch the UI changes
  def self.add_step_delay
    delay = ENV['STEP_DELAY'].to_f
    sleep(delay) if delay.positive?
  end
end
