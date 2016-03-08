# Sample Rails App: Book Club

This is a partial Rails application that has limited features. But use it as a reference.

## Project Setup

Please make these changes to your Rails project **BEFORE** you made any code change. Make sure you **RESTART** your Rails server after making these changes.

### How to use SCSS files?

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
     ```
      *= require font-awesome
     ```

### How to integrate the momentjs-rails gem?

You should start seeing the pattern by now. This is the gem's [github page](https://github.com/derekprior/momentjs-rails) if you want to take a look.

  1. Add `gem "momentjs-rails"` in your `Gemfile`.
  1. Run `bundle install`.
  1. Add the following line to your `application.js`. Refer to the same code if you are not sure where you should add this line.
     ```
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

You can use `@current_user` in **ANY** `html.erb` page, for example:
```
Welcome back, <%=@current_user.first_name%>!!<br/>
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

## Paperclip gem integration

#### 0. Install ImageMagick

Make sure you have [ImageMagick](http://www.imagemagick.org/script/index.php) installed. ImageMagick is a library that allow us to resize images in the server and do different kinds of image processing (black&white, transparencies, etc)

```bash
$ brew install imagemagick
```

#### 1. Add `paperclip` gem

Open `Gemfile` and add this line at the end.

```
gem 'paperclip', '~> 4.3'
```

Then run `bundle install`.

#### 2. Create migration files

Next we need to create a migration to add an `image` attribute to the `Book` model. First we need to generate the migration file:

`$ rails g migration add_image_to_books`

Then we should update the migration file and add one line in the `change` method:

```ruby
class AddImageToBooks < ActiveRecord::Migration
  def change
    add_attachment :books, :image
  end
end
```

And now we can do `rake db:migrate`.

#### 3. Configure Paperclip in `Book` model

In `app/models/book.rb`, add the following the lines of code underneath `### New Code ###`:

```ruby
class Book < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  ### New Code ###

  has_attached_file :image, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
```

#### 4. Allow `image` param in `Books` controller

In the `BooksController`, we need to add `:image` as a whitelisted parameter inside the `book_params` method.

```ruby
class BooksController < ApplicationController
  #
  # Code now shown
  #

  private

  def book_params
    params.require(:book).permit(:title, :url, :author, :isbn, :image)
  end
end
```

#### 5. Add image form field in views

In `app/views/books/_form.html.erb`, update the `form_for` helper like this:

```erb
<%= form_for @book, html: { multipart: true} do |f| %>
```

And then, add a new field to the form:


```erb
  <div class="field">
    <%= f.label :image %><br>
    <%= f.file_field :image %>
  </div>
```

Finally, in `app/views/home/main.html.erb`, change the code that display the book image with these

```erb
  <a href="<%=new_book_review_path(book)%>">
    <img class="thumbnail" src="<%=book.url.empty? ? burl(:medium) : book.url %>">
  </a>
```

#### 6. Restart Rails Server

Before we test the image uploading, please make sure you have restarted your Rails server. 

Have fun!!




