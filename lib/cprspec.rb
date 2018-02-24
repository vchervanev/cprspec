require 'cprspec/version'
require 'cprspec/runner'
require 'listen'
require 'cprspec/interruptable'

module CPRSpec
  extend Interruptable

  def self.watch
    interruptable do
      callback = -> (modified, added, removed) do
        # TODO analyze modified files
        %x{rspec *.rb}
      end

      Listen.to('.', &callback).start
      sleep
    end
  end

  def self.once
    Runner.once
  end
end
