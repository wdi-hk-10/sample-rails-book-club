# Sample Rails App: Book Club

This is a partial Rails application that has limited features. But use it as a reference.

## Project Setup

Please make these changes to your Rails project **BEFORE** you made any code change. Make sure you **RESTART** your Rails server after making these changes.

### How to use SCSS file?

You can just treat them as regular css files. You can change your Sublime setting at the lower right corner to view the `.scss` files as `CSS`. Then you can enjoy the CSS syntax highlighting.

### Disable CoffeeScript

Do the following:
  1. Comment out `gem 'coffee-rails', '~> 4.1.0'` in your `GemFile`.
  1. Run `bundle install`.
  1. If there are `.coffee` files already generated in your `app/assets/javascripts` folder, you can simply rename them to `.js`.

After you have made these changes, `rails g controller` will generate `.js` files instead of the default `.coffee` for each controller you create.

### How to integrate the twitter-bootstrap-rails gem?

Let's just do the simple installation for now. For more information, please check out [the github page](https://github.com/seyhunak/twitter-bootstrap-rails) of the gem.

  1. Add `gem "twitter-bootstrap-rails"` in your `Gemfile`.
  1. Run `bundle install`.
  1. Run `rails generate bootstrap:install static --no-coffeescript`

The last command will do 3 things:
  1. Update `app/assets/stylesheets/application.css`.
  1. Create `app/assets/stylesheets/bootstrap_and_overrides.css`.
  1. Create `app/javascripts/bootstrap.js`.

### How to integrate the font-awesome-rails gem?

The steps are quite simple. Check out [the github page](https://github.com/bokmann/font-awesome-rails) of the gem if you are interested.

  1. Add `gem "font-awesome-rails"` in your `Gemfile`.
  1. Run `bundle install`.
  1. Add the following line to your `application.css`. Refer to the sample code if you are not sure where you should add this line.
     ```css
      *= require font-awesome
     ```

### How to integrate the momentjs-rails gem?

You should start seeing the pattern by now. This is the gem's [github page](https://github.com/derekprior/momentjs-rails) if you want to take a look.

  1. Add `gem "momentjs-rals"` in your `Gemfile`.
  1. Run `bundle install`.
  1. Add the following line to your `application.js`. Refer to the same code if you are not sure where you should add this line.
     ```javascript
     //= require moment
     ```
### Update ApplicationController to disable authentication

In the `app/controllers/application_controller.rb` file, you can do this to ensure that the **FIRST** user from your `users` table is **always** the current user.

```ruby
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  # Just use default (:null_session) for this super simple app
  protect_from_forgery

  before_action :set_current_user

  private
 
  def set_current_user
    @current_user = User.find(1)
  end
end
```

### How to use jQuery?

In the sample code, if you need to use jQuery in any of the view pages generated for the `HomeController` under the `app/views/home/` folder, you should write the jQuery code in `home.js`.

Likewise, for the views pages generated for the `ReviewsController` under the `app/views/reviews/` folder, you should write the jQuery code in `reviews.js`.

You can refer to these files in the sample:
```
   app/views/home/main.html.erb
   app/assets/javascripts/home.js
   app/views/reviews/index.html.erb
   app/assets/javascripts/reviews.js
```


### Still doesn't work?

Compare these key files to the sample code and see if there are any differences:
  - `app/assets/javascripts/application.js`
  - `app/assets/stylesheets/application.css`
  - `app/assets/stylesheets/bootstrap_and_overrides.css`
  - `app/controllers/application_controller.rb`


