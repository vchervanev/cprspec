module Interruptable
  def interruptable
      yield
  rescue Interrupt
    puts 'Interrupted'
  end
end