module CPRSpec
  class Runner
    DATA_FILE_REGEXP = /\.(in|out).txt$/
    INPUT_FILE_TEMPLATE = '*.in.txt'

    def self.once(input_files = nil)
      new(input_files).once
    end

    attr_reader :ruby_file, :input_files

    def initialize(input_files)
      @ruby_file = Dir.glob('*.rb').first

      @input_files = (
        input_files&.grep(DATA_FILE_REGEXP) || Dir.glob(INPUT_FILE_TEMPLATE)
      ).sort
    end

    def once
      runner = self
      RSpec.describe 'test suite' do
        runner.input_files.map(&File.method(:basename)).each do |filename|
          it filename do
            input = filename.sub(DATA_FILE_REGEXP, '.in.txt')
            output = filename.sub(DATA_FILE_REGEXP, '.out.txt')
            raise "Unable to find output file for #{input}" if input == output

            result = %x{cat #{input} | ruby #{runner.ruby_file}}
            expect(File.read(output)).to eql(result)
          end
        end
      end
    end
  end
end
