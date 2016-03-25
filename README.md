# spacewalk

##Development

Please read CONTRIBUTING.md before contributing.

###Testing

Make sure you have:

* bundler
* vagrant

Install the necessary gems:

    bundle install

Run the tests from the root of the source code:

    bundle exec rake validate
    bundle exec rake lint
    bundle exec rake spec

If you have Vagrant installed you can run the acceptance tests:

    bundle exec rake beaker
