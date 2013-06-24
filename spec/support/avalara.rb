# encoding: UTF-8

require 'pathname'

path = Pathname.new(File.expand_path('../../avalara.yml', __FILE__))

if path.exist?
  begin
    AVALARA_CONFIGURATION = YAML.load_file(path)
    Avalara.configure do |config|
      ['username','password'].each do |attr|
        config.send("#{attr}=", AVALARA_CONFIGURATION[attr])
        abort("Avalara configuration file (#{path}) is missing the #{attr} value.") if config.send(attr).nil?
      end

      ['version','endpoint','company_code'].each do |attr|
        config.send("#{attr}=", AVALARA_CONFIGURATION[attr]) if AVALARA_CONFIGURATION[attr]
      end
    end
  rescue NoMethodError
    abort "Avalara configuration file (#{path}) is malformatted or unreadable."
  end
else
  abort "Avalara test configuration (#{path}) not found."
end

module ConfigurationSpecHelpers
  def maintain_contactology_configuration
    before(:each) do
      @_isolated_configuration = Avalara.configuration
      Avalara.configuration = @_isolated_configuration.dup
    end

    after(:each) do
      Avalara.configuration = @_isolated_configuration
    end
  end
end

RSpec.configure do |config|
  config.extend ConfigurationSpecHelpers
end
