# RALES ENGINE
by Carrie Walsh

This project was the first individual project in Mod 3 at Turing School of Software & Design.

## Objective

As the focus for this module is creating/consuming API's, Rales Engine is my first instance of creating an API from scratch. The goal is to create clear, RESTful endpoints with an emphasis on TDD and JSON formatting. A simulated online shop is the basis of this app with merchants, customers, items, invoices, and transactions.

## Getting Started

### Requirements

Requires Ruby 2.4.1 and Rails 5.1.7

### Installing

```
$ git clone https://github.com/carriewalsh/rales_engine.git
$ cd rales_engine
$ bundle install
$ rake db:{drop,create,migrate}
```

### Seeding Data
```
$ rake import:{customer,merchant,invoice,item,invoice_item,transaction}
```
### Schema

![Rales Engine Schema](/rales_engine_schema.jpg?raw=true "Rales Engine Schema")

## Running Tests
Controller and Unit tests are run on rspec:

`$ rspec`

Full database testing can be done by cloning:

`$ git clone https://github.com/turingschool/rales_engine_spec_harness.git`

`$ bundle exec rake`

Setup and run Minitest per directions from README in rales_engine_spec_harness or via this <a href="https://github.com/turingschool/rales_engine_spec_harness">link</a>.

## Author

At the time of making this app, I have just started my third module at Turing School of Software & Design. My focus is in back-end engineering. In the future, I'd love to be on a team that works on projects that help others and simplify issues.

Here's a <a href="https://medium.com/@carriewalsh/my-best-first-api-ever-1c4a7d07a304">link</a> to my blog post I wrote while working on this project.
