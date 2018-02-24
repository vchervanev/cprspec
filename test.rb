if defined? RSpec
  RSpec.describe 'my unit test' do
    it 'is here' do
      //
    end
  end
  CPRSpec.once
else
  while line = gets do
    puts line.chomp.reverse
  end
end