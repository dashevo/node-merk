'use strict'

const { Merk } = require('neon-load-or-build')({
  moduleName: '@dashevo/merk',
  dir: __dirname + '/..',
});

module.exports = Merk;
