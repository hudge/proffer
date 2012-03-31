Proffer [![Build Status](https://secure.travis-ci.org/hudge/proffer.png?branch=master)](http://travis-ci.org/hudge/proffer)
=======

A module to stop Action Controller from copying every instance variable available
to an action to the view by default. Instead, Proffer provides a way to explicitly
expose values as local variables within views.

Rationale
---------

By default, Action Controller will make any instance variables present during an
action available to its views (including partials). This effectively makes them
global variables and can obscure their origin when maintaining views. Partials
that exploit this behaviour can be particularly difficult to maintain as they
may inherit state from their caller implicitly.

We want to see if removing this default behaviour changes the way views are
written. By forcing explicit declaration of dependencies, will better, more
encapsulated design result?

Usage
-----

Add the following to your `Gemfile`:

```ruby
gem 'proffer'
```

Include the `Proffer` module into any controllers you wish (include into
`ApplicationController` to enforce this behaviour throughout your application):

```ruby
class PostsController < ApplicationController
  include Proffer

  # This will make a new Post object available as post in the view but
  # @heading will be nil.
  def new
    @heading = "New Post"
    proffer :post => Post.new
  end
end
```

Any proffered values will then be available to your views by their key:

```erb
<%= form_for(post) do |f| %>
  ...
<% end %>
```

Compatibility
-------------

As we rely on `ActionController#view_assigns`, this will only work with versions
of Rails 3.0 or later. It is currently tested against Rails 3.2.

Disclaimer
----------

We have not yet tried this in production so proceed with caution. This gem
overrides `ActionController#view_assigns` and extends `ActionController#render`,
so it may be incompatible with other gems that override these methods.

License
-------

See LICENSE.txt

