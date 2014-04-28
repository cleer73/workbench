fs = require 'fs'

module.exports =
  package: JSON.parse fs.readFileSync("#{__dirname}/../package.json")
  modules: JSON.parse fs.readFileSync("#{__dirname}/../etc/modules.json")
