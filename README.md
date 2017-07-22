## [Twacker](https://github.com/danasilver/twacker)
### Serverless Edition

Track your Twitter followers and following.

### What is it?

A simple app to track your Twitter followers and following in detail,
rewritten in TypeScript to run on [AWS Lambda](https://aws.amazon.com/lambda/),
using [Apex](http://apex.run/) to manage functions.

The [original app](http://twacker.danasilver.org) was written in Ruby
and runs on Heroku.

### Develop with Apex

Run through the [Apex installation](http://apex.run/#installation)
instructions to get your `~/.aws/config` and `~/.aws/credentials`
files setup.

* Note: If you don't include the config settings in your `~/.aws/credentials`
  file, you'll need to set `AWS_SDK_LOAD_CONFIG=1` in your shell before
  running `apex(1)`.
