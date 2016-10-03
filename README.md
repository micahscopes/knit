## Installation

First...

    $ gem install knit

...then:

```ruby
require 'knit'
```

## Usage

For example:
``` ruby
{:aardvark=>{:soup=>2}}.knit({:aardvark=>{:beans=>:fluff}})

# => {:aardvark=>{:soup=>2, :beans=>:fluff}}
```

## Contributing

Do you have a better way?  Objections even?  Fork away!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
