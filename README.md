# DNS Black Hole :: Generate hosts file to block any DNS request

Author: Loan Lassalle
***

## Purpose

This repository provides an easy way to generate host files from [StevenBlack's hosts repository](https://github.com/StevenBlack/hosts).  
StevenBlack's hosts repository consolidates several reputable hosts files, and merges them into a unified hosts file with duplicates removed. A variety of tailored hosts files are provided.

If you need more details or explanations about this repository, feel free to explore source code of this repository and read [StevenBlack's hosts repository](https://github.com/StevenBlack/hosts).

## Prerequisites

* macOS Mojave 10.14.6 (18G84) or later
* Docker Desktop 2.1.0.1 (37199) or later

## Usage

Before running `run-app` script, you must create and fill with your own values the following files:
* .conf file based on .conf.example file
* blacklist file based on blacklist.example file
* myhosts file based on myhosts.example file
* whitelist files based on whitelist.example file

Then you can ran the `run-app` script.

```sh
sh -u run-app
```

The above command allows you to start a Docker container with all source files of [StevenBlack's hosts repository](https://github.com/StevenBlack/hosts) and generate a hosts file through a Docker volume.

Here are the steps of `run-app` script:
1. Running `pre-run` script
   1. Checking for updates, if there is a new version of source files of [StevenBlack's hosts repository](https://github.com/StevenBlack/hosts), the script continues. It stops otherwise.
2. Running `run-app` script
   1. Start Docker if it is not running
   2. Build the Docker container
   3. Start the Docker container with all Docker volumes
      1. The following python command is ran:  
      `python3 updateHostsFile.py --auto --extensions fakenews gambling porn social --output /dns-black-hole/etc`
   4. Stop the Docker container
   5. Kill the Docker container
   6. Remove the Docker container
   7. Remove Docker volumes unsued
   8. Remove Docker images unsued
   9. Stop Docker if it was not running before the launch of the script
3. Running `post-run` script
   1. Creation of hard link between /etc/hosts and `$WORKING_DIRECTORY`/dns-black-hole/src/hosts (variable in the configuration file .conf)
   2. Flushing of local DNS cache

**Note:** `pre-run` and `post-run` scripts are present to allow you to add processes before and after the hosts file is generated.

The following output shows you how to use `run-app` script, all its options and their utility.

```sh
Usage: run-app [--interactive [--extension <extension_name> ...] | --detach --force [--extension <extension_name> ...] [--verbosity (0 | 1 | 2)] | --prune [--verbosity (0 | 1 | 2)] | --wipe [--verbosity (0 | 1 | 2)]]

Manage the dns-black-hole app

Version: 1.0.0, build deadbeef

Author:
  Loan Lassalle - <https://github.com/lassalleloan>

Options:
  -i, --interactive               Keep stdin open even if not attached and allocate a pseudo-tty
  -d, --detach                    Leave the container running in the background (default processing mode)
  -e, --extension                 Enable additional category-specific
  -f, --force                     Force the application to run, bypass any prior checking
  -p, --prune                     Remove all unused Docker data
  -w, --wipe                      Remove all Docker data
  -v, --verbosity (0 | 1 | 2)     Level of verbosity: no ouput, step information (default), all information
  -h, --help                      Help on how to use this script
```

## How to block domains

The domains you list in the blacklist file are included from the final hosts file.

The contents of this file (containing a listing of additional domains in hosts file format) are appended to the unified hosts file during the update process. A sample blacklist is included, and may be modified as you desire.

The blacklist is not tracked by git, so any changes you make won't be overridden when you git pull this repo from origin in the future.

## How to include your own custom domain mappings

If you have custom hosts records, place them in file myhosts. The contents of this file are prepended to the unified hosts file during the update process.

The myhosts file is not tracked by git, so any changes you make won't be overridden when you git pull this repo from origin in the future.

## How to unblock domains

The domains you list in the whitelist file are excluded from the final hosts file.

The whitelist uses partial matching. Therefore if you whitelist google-analytics.com, that domain and all its subdomains won't be merged into the final hosts file.

The whitelist is not tracked by git, so any changes you make won't be overridden when you git pull this repo from origin in the future.

## How to temporarily unblock DNS requests for a category-specific of domains

To temporarily unblock DNS requests for a category-specific of domains, it is recommended to run `run-app` script with [--extension <extension_name> ...] option.  
It allows you to access to certain category-specific domains without having to edit the .conf configuration file.

When you want to cancel the previous change, you just have to execute the `run-app` script with [--force] option.

**Example:** You want to temporarily unblock DNS requests for social category-specific of domains.

```sh
sh -u run-app --extension fakenews --extension gambling --extension porn
```

Now you can access to the social category-specific of domains.  
When you want to cancel the previous change.

```sh
sh -u run-app --force
```

## How to temporarily unblock DNS requests for a specific domain

To temporarily unblock DNS requests for a specific domain, it is recommended to comment all lines related to that specific domain in the hosts file. To do this, you must add a hashtag or # at the beginning of lines.  
Due to multiple subdomains for a specific domain, you can use the following regex to find a domain and all its subdomains.

```regex
^(0[.]0[.]0[.]0 ([a-zA-Z0-9_-]+:\/\/)?(([a-zA-Z0-9_-]+[.])*)(reddit[.][a-zA-Z0-9_-]+))$
```

Then, you can use the replace function of your text editor to add # at the beginning of lines using the previous regex and the next string.

```replace-text
# $1
```

After these changes, you must flush your DNS cache. To do this, you must execute the following commands in a terminal. These commands only works on a macOS.

```sh
killall -HUP mDNSResponder
```

**Note:** It may be necessary to close all tabs of your web browsers accessing this domain and its subdomains. In addition, some web browsers need to be restarted to clear their local DNS cache.

When you want to reverse previous actions and block DNS requests for a specific domain and subdomains, simply use the following regex to remove the hashtag or # at the beginning of lines.

```regex
^# (0[.]0[.]0[.]0 ([a-zA-Z0-9_-]+:\/\/)?(([a-zA-Z0-9_-]+[.])*)(reddit[.][a-zA-Z0-9_-]+))$
```

Then, you can use the replace function of your text editor to remove # at the beginning of lines using the previous regex and the next string.

```replace-text
$1
```

After these changes, you must flush your DNS cache. To do this, you must execute the following commands in a terminal. These commands only works on a macOS.

```sh
killall -HUP mDNSResponder
```

**Note:** It may be necessary to close all tabs of your web browsers accessing this domain and its subdomains. In addition, some web browsers need to be restarted to clear their local DNS cache.

### Domains associated with a string

It is not unusual for a website to use other legitimate domains, other than subdomains. That is why you can use the following regex to find other domains that contain the same string.

```regex
^(0[.]0[.]0[.]0 ([a-zA-Z0-9_-]+:\/\/)?(([a-zA-Z0-9_-]+[.])*)([a-zA-Z0-9_-]+reddit[a-zA-Z0-9_-]+[.][a-zA-Z0-9_-]+))$
```

**Note:** Beware, this regex could allow you to unblock DNS requests to illegitimate or malicious domains.

## Location of your hosts file

To modify your current hosts file, look for it in the following places and modify it with a text editor.

macOS: /etc/hosts file.

## Reloading hosts file

Your operating system will cache DNS lookups. You can either reboot or run the following commands to manually flush your DNS cache once the new hosts file is in place.

| The Google Chrome browser may require manually cleaning up its DNS Cache on `chrome://net-internals/#dns` page to thereafter see the changes in your hosts file. See: https://superuser.com/questions/723703
:-----------------------------------------------------------------------------------------

### macOS

Open a Terminal and run:

```
killall -HUP mDNSResponder
```

## Miscellaneous

### How to automate the update of the hosts file

It may be interesting for you to automate the update of the hosts file. To do this, you must create an agent which will execute the `run-app` script. To simplify configuration, you can use the `agent/set-agent` script.

Here are the steps of `agent/set-agent` script:
1. Creation of the property list file to specify the behavior of the agent
   1. Copy the property list file from plist.example
   2. Edit the working directory in property list file
   2. Edit the debugging ouputs in property list file
2. Copying of the property list file to `~/Library/LaunchAgents`
3. Loading the property list file

After running the `agent/set-agent` script, the `com.loanlassalle.dns-black-hole.update` agent is ready to run automatically according to calendar intervals.  
The agent will perform every hour.

**Note:** If the system is asleep, the job will be started the next time the computer wakes up. If multiple intervals transpire before the computer is woken, those events will be coalesced into one event upon wake from sleep.

**Note:** It is possible to change the execution interval. To do this, please follow instructions on [this website](https://www.launchd.info) at Configuration/StartCalendarInterval section.

If you want to reverse all these actions produced by the `agent/set-agent` script, you can use the `agent/unset-agent` script. It will delete all files created and clean up the User-provided agent directory.

### How to know domains contacted while web browsing

It may be interesting for you to add other domains that are contacted during your web browsing. The first solution is to inspect Web page elements and retrieve contacted domains. To know how to do it, [let me Google that for you](https://lmgtfy.com/?q=inspect+web+page+elements).

The second solution consists to extract domains from DNS logs. The first thing to do is to enable the showing of private data. Since DNS queries may be sensitive, these are hidden by default.

```sh
sudo log config --mode "private_data:on"
```

Then, you can extract domains contacted while web browsing from logs. To do this, you can use the following command. This command streams information log data from mDNSResponder process, extract domains and save to dns-requests.log file.

```sh
log stream --level info --process mDNSResponder --type log | sudo sed -En 's/^.*GetServerForQuestion.*for (([a-zA-Z0-9_-]+:\/\/)?(([a-zA-Z0-9_-]+[.])*)([a-zA-Z0-9_-]+[.][a-zA-Z0-9_-]+))[.] \((AAAA|Addr)\)$/\1/w'`date -u +%FT%TZ`_dns-requests.log
```

When you want to stop the domains extraction, you just need to stop the command with interruption signal or `CTRL + C` and disable the showing of private data with the follwoing command.

```sh
sudo log config --mode "private_data:off"
```

**Note:** All the above commands must be executed by a user account with administrator rights.

### How to reverse changes made to macOS system files

The only file affected by scripts is /etc/hosts. They create a hard link between /etc/hosts and `$WORKING_DIRECTORY`/dns-black-hole/src/hosts variable in the configuration file .conf.  
The creation of this hard link will change rights of the original file /etc/hosts because this hard link must be readable and writable by the current user without administrator rights.  
If you need to reverse these changes, you need to run following commands on /etc/hosts.

```sh
rm dns-black-hole/src/hosts
sudo cp -f dns-black-hole/backup/hosts.bk /etc/hosts
sudo chown root:wheel /etc/hosts
```

The following outout is the status of files related to the hosts file before changes.
```
ls -l /etc/hosts*
-rw-r--r--  1 root          wheel      213 24 jul 19:25 /etc/hosts
-rw-r--r--  1 root          wheel      213 24 jul 19:25 /etc/hosts.bk
-rw-r--r--  1 root          wheel        0 17 aoû  2018 /etc/hosts.equiv
-rw-r--r--  1 root          wheel      213 17 aoû  2018 /etc/hosts~orig
```

### References

* [StevenBlack's hosts repository](https://github.com/StevenBlack/hosts)
* [Apple - Daemons and Services Programming Guide](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html)
* [man page launchd(8)](https://www.manpagez.com/man/8/launchd/)
* [man page launchd.plist(5)](https://www.manpagez.com/man/5/launchd.plist/)
* [A launchd Tutorial](https://www.launchd.info)
* [Logging DNS requests with internet sharing on macOS](https://www.sjoerdlangkemper.nl/2019/05/22/logging-dns-requests-with-internet-sharing-on-macos/)
