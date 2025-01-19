General Vulnerabilites:
[ ] - ensure no override config files in /lib/systemd/system/ssh.service or /etc/systemd/system/ssh.service.d
[ ] - check /etc/default ssh file

Stigs:
[ ] - secure/encrypt transmitted information - V-260524
[ ] - disable x11 forwarding - V-260529
[ ] - no automatic logins - V-250526
[ ] - use only FIPS validated key exchanges - V-260533
[ ] - must use message authentication codes MACs with FIPS approved hashes - V-250532
[ ] - generate logs for ssh-keysign command - V-260621
[ ] - generate logs for ssh-agent command - V-260620
[ ] - all connections are terminated after 10 minutes of inactivity - V-260528
[ ] - disallow authentication using known host's authentication - V-230290
[ ] - no authentication with empty password - V-71939
[ ] - no environment variable override - V-71957
[ ] - don't allow non-certificate trusted host ssh logon - v-71959