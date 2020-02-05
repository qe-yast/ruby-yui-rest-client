# frozen_string_literal: true

require 'yaml'

# Client to interact with YAST UI rest api framework for integration testing
module LibyuiClient

  def self.read_config_value(key)
    YAML.load_file(File.join(__dir__, 'config.yaml'))[key]
  end

end
