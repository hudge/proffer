Proffer [![Build Status](https://secure.travis-ci.org/hudge/proffer.png?branch=master)](http://travis-ci.org/hudge/proffer)
=======

A module to stop Action Controller from copying every instance variable available
to an action to the view by default. Instead, use an explicit API to expose
variables as local variables within views.

Usage
-----

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

```erb
<%= form_for(post) do |f| %>
  ...
<% end %>
```

