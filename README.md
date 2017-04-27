# RD Test by José Pedro

There are two applications and the javascript library in project root.

## Dependencies
- Postgresql
- New version of ruby
- New version of rails

## Application 1 - Client_App
After cloned repository, run these commands to execute this application:
1 - $ cd Client_App
2 - $ bundle install
3 - $ rake db:create
4 - $ rake db:migrate
5 - $ rails s

## Application 2 - RD_Station
After cloned repository, run these commands to execute this application:
1 - $ cd RD_Station
2 - $ bundle install
3 - $ rake db:create
4 - $ rake db:migrate
5 - $ rails s -p 3001

## Automated tests
To run automated tests enter in project RD_Station and execute this command:
$ bundle exec rspec 
Results => Finished in 0.30146 seconds (files took 4.47 seconds to load)
16 examples, 0 failures
