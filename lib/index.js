'use strict'

const { Merk } = require('../native')

module.exports = function createMerk (path) {
  const merk = new Merk(path);
  return merk;
}
