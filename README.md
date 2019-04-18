# Modl::Parser

This Ruby gem can be used as the base for a MODL interpreter. It contains the Lexer, Parser, and other supporting classes generated by the ANTLR4 Ruby language target.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'modl'
```

And then execute:

    $ bundle install

Or clone the repository and build and install it yourself as:

    $ gem build modl.gemspec
    $ gem install modl-0.1.0.gem
    
    or if that fails:
    
    $ sudo gem install modl-0.1.0.gem

You will also need to install the antlr4-ruby-runtime gem that this depends on. See https://github.com/MODLanguage/antlr4-ruby-runtime
## Usage

```ruby
require 'modl/interpreter'

result = Modl::Interpreter.interpret
or
result = Modl::Interpreter.interpret, true
```
where `str` is the modl to be interpreted. The result will be a JSON string. If the second parameter is `true` then the JSON will be pretty-printed.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MODLanguage/ruby-interpreter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Modl::Parser project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/modl-parser/blob/master/CODE_OF_CONDUCT.md).
