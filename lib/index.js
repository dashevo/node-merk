'use strict'

console.dir(__dirname + '/..');

const { Merk } = module.exports = require('neon-load-or-build')({
  moduleName: '@dashevo/merk',
  dir: __dirname + '/..',
});

module.exports = Merk;
