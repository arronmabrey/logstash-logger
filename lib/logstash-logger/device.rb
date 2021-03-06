require 'logstash-logger/device/base'

module LogStashLogger
  module Device
    DEFAULT_TYPE = :udp

    autoload :Base, 'logstash-logger/device/base'
    autoload :Connectable, 'logstash-logger/device/connectable'
    autoload :Socket, 'logstash-logger/device/socket'
    autoload :UDP, 'logstash-logger/device/udp'
    autoload :TCP, 'logstash-logger/device/tcp'
    autoload :Unix, 'logstash-logger/device/unix'
    autoload :Redis, 'logstash-logger/device/redis'
    autoload :File, 'logstash-logger/device/file'
    autoload :Stdout, 'logstash-logger/device/stdout'

    def self.new(opts)
      type = opts.delete(:type) || DEFAULT_TYPE

      device_klass_for(type).new(opts)
    end

    def self.device_klass_for(type)
      case type
        when :udp then UDP
        when :tcp then TCP
        when :unix then Unix
        when :file then File
        when :redis then Redis
        when :stdout then Stdout
        else fail ArgumentError, 'Invalid type'
      end
    end
  end
end
