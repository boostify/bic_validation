# BicValidation

[![Build Status](https://travis-ci.org/opahk/bic_validation.png?branch=master)](https://travis-ci.org/opahk/bic_validation)
[![Coverage Status](https://coveralls.io/repos/opahk/bic_validation/badge.png?branch=master)](https://coveralls.io/r/opahk/bic_validation?branch=master)
[![Code Climate](https://codeclimate.com/github/opahk/bic_validation.png)](https://codeclimate.com/github/opahk/bic_validation)

ActiveModel Business Identifier Code (BIC) validator
## Installation

Add this line to your application's Gemfile:

    gem 'bic_validation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bic_validation

## Usage

In your rails model

    validates :bic_attribute, bic: true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
