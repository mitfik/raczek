require 'socket'
require 'vmstat'
require 'active_support'

class SystemParams

  attr_accessor :hostname, :ip_addr, :cpu_cores, :memory_size, :disk_size

  def initialize
    @vmstat = Vmstat.snapshot
    @hostname = fetch_hostname
    @ip_addr = fetch_ip_addr
    @memory_size = fetch_total_memory_size
    @disk_size = fetch_disk_size
    @cpu_cores = fetch_cpu_cores
  end


  def to_hash
    {:hostname => @hostname, :ip_addr => @ip_addr, :cpu_cores => @cpu_cores,
     :memory_size => @memory_size, :disk_size => @disk_size }
  end

  private

    def fetch_hostname
      Socket.gethostname
    end

    def fetch_ip_addr
      Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address
    end

    def fetch_total_memory_size
      number_to_human_size @vmstat.memory.total_bytes
    end

    # sum total size of all available disks
    def fetch_disk_size
      total_size = 0
      total_size = `lsblk -b --output SIZE -d -n | paste -s -d + -  | bc`
      number_to_human_size total_size
    end

    def fetch_cpu_cores
      @vmstat.cpus.count
    end

    def number_to_human_size(number)
      ActiveSupport::NumberHelper.number_to_human_size number
    end
end
