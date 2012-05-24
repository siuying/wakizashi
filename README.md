# wakizashi - HTML/XML Parser for RubyMoton

HTML/XML parser for RubyMotion, based on [GDataXML-HTML](https://github.com/graetzer/GDataXML-HTML).

Goal: Nokogiri style interface HTML parsing and building for RubyMotion.

Status: basic search, read and write working

## Install

Install the gem

``` ruby
gem install wakizashi
```

Add the gem to your RubyMotion Rakefile

``` ruby
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'
require 'wakizashi'

Motion::Project::App.setup do |app|
  app.name = 'myapp'

  # Only needed if you have not already specifying a pods dependency
  app.pods do
    dependency 'GDataXML-HTML'
  end
end
```

## Usage

### Parsing

Search nodes with XPath

```ruby
doc = Wakizashi::HTML("<html><body><h1>Hello World</h1><p>Welcome</p><p>Foo</p><a href='http://www.google.com'>Google</a></body></html>")
doc.xpath("//p")
```

Modify nodes

```ruby
link = doc.xpath("//a").first
link["href"] # => "http://www.google.com"
link["href"] = "http://wikipedia.org"
link.stringValue = "Wiki"
link.to_html => # "<html><body><h1>Hello World</h1><p>Welcome</p><p>Foo</p><a href='http://wikipedia.org'>Wiki</a></body></html>"
```