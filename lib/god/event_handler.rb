module God
  class EventHandler
    @@actions = {}
    @@handler = nil
    
    def self.handler=(value)
      @@handler = value
    end
    
    def self.register(pid, event, &block)
      @@actions[pid] ||= {}
      @@actions[pid][event] = block
      @@handler.register_process(pid, @@actions[pid].keys)
    end
    
    def self.call(pid, event)
      @@actions[pid][event].call
    end
    
    def self.watching_pid?(pid)
      @@actions[pid]
    end
    
    def self.run_event_thread
      Thread.new do
        loop do
          @@handler.handle_events
        end
      end
    end
    
  end
end