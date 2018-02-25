# CPRSpec

Emergency spec runner for Competitive Programming in Ruby [early Beta version]

## How it works

CPRSpec expects the following file structure:

* A single `.rb` including RSpec unit tests guarded via `defined? RSpec` inside
* A set of `*.in.txt` and `*.out.txt` files with test data and expected output inside
* `CPRSpec.once` call from RSpec scope (to test solutions using provided input/output files)

During local development `$ rspec <problem.rb>` will run its unit tests and custom test suite as

```bash
cat <input-file> | ruby <solution-file`
```

and compare produced output vs expected output from `<output-file>`

## Watch mode

Executable command `cprspec` listens for changes in `*.rb`, `*.in.txt` and `*.out.txt` files and runs `rspec`.
If only a data (input/output) file is updated then only that file will be tested.

```bash
$ [bundle exec] cprspec
```

## WHY?

[TBD]

## Example

> problem.rb

```ruby
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
```

> 0-simplest-test.in.txt

```txt
12
34
```

> 0-simplest-test.out.txt

```txt
21
43
```

And then
> $ bundle exec rspec test.rb

```
my unit test
  is here

test suite
  0-syntax.in.txt

Finished in 0.25272 seconds (files took 0.73232 seconds to load)
2 examples, 0 failures
```

## Installation

Installation via RubyGems is not supported yet.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bundle console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vchervanev/cprspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cprspec project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cprspec/blob/master/CODE_OF_CONDUCT.md).
