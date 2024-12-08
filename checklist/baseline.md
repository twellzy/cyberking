// outline for baseline script
// goal is to obtain an "untampered" OS and compare it with the current OS to see all created attack vectors

?? ?? -- research best possible method or verify functionality

outline:
1. Grab current version of the OS either from the user or from commands
2. Store a fresh OS's filesystem on the image
3. Parse README for the authorized userlist   // cat /opt/CyberPatriot/README.desktop
4. Get critical services from userinput
    4a. ?? Make multiple functions for each critical service depending on functionality ?? 
    4b. ?? Store most secure versions of critical services config files and insert them in image ??
5. Compare fresh OS and image's OS
    5a. ?? Use meld MANUALLY to compare the differences and easily observe odd/malicious added files ?? -- easier to read
    5b. ?? It may be more efficient or controllable to write a script to compare the two OSes ?? -- could be easier in scripting
6. Determine the deadliness of changed files
    6a. Remove new apt packages
    6b. Remove odd binaries or scripts
    6c. Sort out simple differences between the challenge OS and the fresh OS


primary:
[ ]  ?? disable listeners on all ports above 1023 ?? -- could mess up critical services
[ ]  run rootkits and filter false positives
[ ]  secure config files (/etc/pam.d/, /etc/sshd)
[ ]  secure critical services
[ ]  disable insecure or unnecessary services



secondary: 
[ ]  check for script source files 
[ ]  find and delete user media files
[ ]  check for 'hacking tools' (ophcrack, ??openvpn??, hydra, john) and games (freeciv)
[ ]  run rootkits and filter false positives
[ ]  

