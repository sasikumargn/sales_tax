##### Prerequisites

The setups steps expect the following tools installed on the system.

- Ruby [2.4.0]
- Rails [5.0.7]

##### 1. Check out the code shared with email (sales_tax)

##### 2. Edit database.yml file with your local configuration

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000