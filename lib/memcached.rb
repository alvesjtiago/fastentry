require 'net/telnet'

module Memcached
  def self.items(*_servers)
    servers = _servers.collect {|s| s.split(':')}
    all_rows = servers.collect do |server|
      server_rows = server_items(*server) do |slab_id, expires_time, bytes, cache_key, cache_key_length, host, port|
        {:id=>slab_id, :expires=>expires_time, :bytes=>bytes, :name=>cache_key, :server=>[host,port].join(':')}
      end
      server_rows
    end.flatten(1)

    return all_rows
  end

  def self.server_items(_host='host', _port=11211)
    keys = []
    host = Net::Telnet::new("Host" => _host, "Port" => _port, "Timeout" => 1)

    host.cmd("String" => "lru_crawler metadump all", "Match" => /^END/) do |row|
      row.scan(/key=(\S*)/) do |key|
        keys << key
      end
    end
    host.close
  rescue Exception
    puts "Could not get memcache items from #{_host}:#{_port}"
  ensure
    return keys
  end

  def self.keys(*_servers)
    items = self.items(*_servers)
    items.collect { |i| CGI.unescape(i[0]) }.sort
  end
end
