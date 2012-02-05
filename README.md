# Mongoid::UPK

Mongoid::UPK generates more unique `_id` by using UUID.

UPK stands for "unique primary key" or "uuid primary key".



## Install

```bash
gem install mongoid_upk
```

**Gemfile**

```ruby
gem "mongoid_upk"
```



## Usage

**Basic**

```ruby
class MyModel
  include Mongoid::Document
  include Mongoid::UPK
end
```

or:

```ruby
class MyModel
  include Mongoid::Document
  include Mongoid::UPK
  uuid_pk # you can leave this out, because it's the default generator
end
```


Will use `UUID` ([uuid gem](https://github.com/assaf/uuid) by assaf), `:compact` mode per default.

**Pretty UUID**

```ruby
class MyModel
  include Mongoid::Document
  include Mongoid::UPK
  pretty_uuid_pk
end
```

Almost same as above but with hyphens in it.
(Example: `c1b457b0-3214-012f-316d-10e6baa29f2c`)

**Mixed ID**

```ruby
class MyModel
  include Mongoid::Document
  include Mongoid::UPK
  bson_uuid_pk
end
```

Very long `_id` with both BSON::ObjectId **and** UUID.
(Example: `4f2e55a2ee911332c4000001-95faf560320f012f315510e6baa29f2c`)

**Own pk generator**

```ruby
class MyModel
  include Mongoid::Document
  include Mongoid::UPK
  unique_pk do
    # code goes here
    # result must be a string
    # example:
    Digest::MD5.hexdigest(Time.now.to_f.to_s)
  end
end
```

Example is self-describing.



## Motivation

While writing very fast to MongoDB it is possible to take a BSON::ObjectId twice.
This will lead to big troubles because you never know which document will be returned.

This gem utilizes the `key` method and overwrites the automatically given default id with the choosen generator on save.
So the real id can be read first after a successful save (I don't want to hack deeper here, because saves are more important than getting a unique id on instance initialization).

UUID is in most cases more reliable, especially if the app instances are set up correctly (and/or running on different machines).

Read more about the [UUID gem and how to set up your project (e.g. using unicorn or other threaded webservers)](https://github.com/assaf/uuid).



## License

MIT/X11

2012 — [Christoph 'asaaki' Grabo](https://github.com/asaaki)
