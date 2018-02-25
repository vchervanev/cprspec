require 'cprspec/version'
require 'cprspec/runner'
require 'listen'
require 'cprspec/interruptable'

module CPRSpec
  extend Interruptable

  def self.watch
    puts "Watching for changes, use CTRL+C to exit"
    interruptable do
      callback = -> (modified, added, removed) do
        changed = (modified + added).uniq
        env = ''
        opts = ''
        if changed.grep(/\.rb$/).empty?
          env = "TESTS=" + changed.map(&File.method(:basename)).map(&Runner::GET_TEST_NAME_PROC).join(',')
          opts = '-t cprspec_input_tests'
        end
        command = "#{env} rspec *.rb #{opts}"
        puts "Executing #{command}..."
        system command
      end

      Listen.to('.', only: [Runner::DATA_FILE_REGEXP, /\.rb$/], &callback).start
      sleep
    end
  end

  def self.once
    Runner.once
  end
end
