# Rails Engine

Rails (Rales?) Engine is a project using Rails and ActiveRecord to build a JSON API. The API is used to expose the SalesEngine data schema.

This project was assigned week 1 of Module 3  at Turing. The stated **learning goals** are as follows:

- Learn how to to build Single-Responsibility controllers to provide a well-designed and versioned API.
- Learn how to use controller tests to drive your design.
- Use Ruby and ActiveRecord to perform more complicated business intelligence.

The original project spec can be found [here](http://backend.turing.io/module3/projects/rails_engine).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

A step by step series of examples that tell you have to get a development env running

Clone the project

```
$ git clone https://github.com/njgheorghita/rails_engine.git
```

Run Bundler to install all dependencies specified in the project Gemfile

```
$ bundle install
```

Setup the test and development databases and add seed data

```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Start the Rails server to access the API endpoints from localhost.

```
$ rails s
```

## Running the tests

To run the test suite, run rspec from the project root directory:

```
$ path/to/project/root rspec
```

To run the spec harness, use the instructions found [here](https://github.com/turingschool/rales_engine_spec_harness). Make sure to start the Rails server before running the tests.


## Contributors

* [Nick Gheorghita](https://github.com/njgheorghita)
* [Molly Brown](https://github.com/mollybrown)

## Built With

* [Factory Girl](https://github.com/thoughtbot/factory_girl)
* [Active Model Serializers](https://github.com/rails-api/active_model_serializers)
