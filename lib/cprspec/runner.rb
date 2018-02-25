module CPRSpec
  class Runner
    DATA_FILE_REGEXP = /\.(in|out).txt$/
    TEST_NAME_REGEXP =  /(.+)\.(in|out)\.txt$/
    GET_TEST_NAME_PROC = -> (filename) { filename.match(TEST_NAME_REGEXP)&.send(:[], 1) }
    INPUT_FILE_TEMPLATE = '*.in.txt'

    attr_reader :ruby_file, :tests

    def self.once
      new(ENV.fetch('TESTS', '').split(',')).once
    end

    def initialize(tests)
      # FIXME check for ambiguous ruby file
      @ruby_file = Dir.glob('*.rb').first
      @tests = tests.any? ? tests : all_tests

      @tests.sort!
    end

    def once
      runner = self
      RSpec.describe 'test suite', :cprspec_input_tests do
        runner.tests.each do |test_name|
          it test_name do
            input = "#{test_name}.in.txt"
            output = "#{test_name}.out.txt"
            raise "Unable to find input file #{input} in #{Dir.pwd}" unless File.exists?(input)
            raise "Unable to find output file #{output} in #{Dir.pwd}" unless File.exists?(output)

            # FIXME remove platform dependency via Open3
            result = %x{cat #{input} | ruby #{runner.ruby_file}}
            expect(File.read(output)).to eql(result)
          end
        end
      end
    end

    private

    def all_tests
      Dir.glob(INPUT_FILE_TEMPLATE).map(&GET_TEST_NAME_PROC)
    end
  end
end
