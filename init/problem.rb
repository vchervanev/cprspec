# create a solution for your problem like this
def solve_problem
  while line = gets do
    puts line.chomp.reverse
  end
end

if defined? RSpec
  # Create your own unit tests using RSpec
  # RSpec.describe 'my unit test' do
  #   it 'is here' do
  #
  #   end
  # end

  # Run tests using *.in.txt files as input
  # and compare output with *.out.txt
  CPRSpec.once if defined? CPRSpec
else
  # that's not a test, solve it now
  solve_problem
end