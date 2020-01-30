# virus-copter

Infect other AR drones with this program.

Deploying code to AR drones is annoying. This program makes it more interesting
to deploy software onto AR drones when it works at all.

# payload

The payload virus.tar includes:

* node cross-compiled for the ARM chips running on the drones
* felixge's [ar-drone module](http://npmjs.org/package/ar-drone)
* some iwconfig/iwlist wrappers in lib/iw.js
* open wireless networks in nodes.json (gathered by the deployment computer)

# limitations

`iwlist ath0 scan` doesn't seem to work on the AR drones, but this information
is possibly available through other endpoints

# license

MIT
