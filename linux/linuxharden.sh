function userAudit(){
    #check which scoring engine is used
    if [ -e '/opt/CyberPatriot/README.desktop' ]; then
        url=$(cat /opt/CyberPatriot/README.desktop | grep -oP 'https?://[^"]+')
        curl $url > ./res/readme.html
    fi

    if [ -e '/opt/aeacus/assets/ReadMe.html' ]; then
        cat /opt/aeacus/assets/ReadMe.html > ./res/readme.html
    fi

    #put list of authorized standard users into ./res/authed_standard_users.txt
    awk '/<b>Authorized Users:<\/b>/,/<\/pre>/' ./res/readme.html | grep -oP '^\s*\w+' > './res/authed_standard_users.txt'

    #put list of authorized admins into ./res/authed_admins.txt
    awk '/<b>Authorized Administrators:/,/^$/ { if ($1 ~ /^[A-Za-z]+$/) print $1 }' ./res/readme.html > ./res/authed_admins.txt

    #put list of all authorized users into ./res/authed_users.txt
    cat ./res/authed_standard_users.txt ./res/authed_admins.txt > ./res/authed_users.txt

    #put list of all users authorized or not into ./res/all_users.txt
    getent passwd | awk -F: '($3 == 0 && $1 != "root") || ($3 >= 1000 && $3 < 3000) { print $1 }' > './res/all_users.txt'



    while read -r user; do
        grep $user ./res/authed_admins.txt > /dev/null
        if [ $? -eq 1 ]; then
            deluser $user adm
            deluser $user sudo
            deluser $user shadow
        fi

        grep $user ./res/authed_users.txt > /dev/null
        if [ $? -eq 1 ]; then
            #remove user's cronjobs
            crontab -u $user -r

            #delete the user
            userdel -f $user

        else
            echo -e "$user:Cyb3rP@triot1234!" >> ./res/passwords.txt
        fi

    done < ./res/all_users.txt

    #chpasswd < ./res/passwords.txt
}



function removeBadPackages(){
    apt-get purge --auto-remove netcat -qq
    apt-get purge --auto-remove netcat-openbsd -qq
    apt-get purge --auto-remove netcat-traditional -qq
    apt-get purge --auto-remove ncat -qq
    apt-get purge --auto-remove pnetcat -qq
    apt-get purge --auto-remove socat -qq
    apt-get purge --auto-remove sock -qq
    apt-get purge --auto-remove socket -qq
    apt-get purge --auto-remove sbd -qq
    apt-get purge --auto-remove john -qq
    apt-get purge --auto-remove john-data -qq
    apt-get purge --auto-remove hydra -qq
    apt-get purge --auto-remove hydra-gtk -qq
    apt-get purge --auto-remove aircrack-ng -qq
    apt-get purge --auto-remove fcrackzip -qq
    apt-get purge --auto-remove lcrack -qq
    apt-get purge --auto-remove ophcrack -qq
    apt-get purge --auto-remove ophcrack-cli -qq
    apt-get purge --auto-remove pdfcrack -qq
    apt-get purge --auto-remove pyrit -qq
    apt-get purge --auto-remove rarcrack -qq
    apt-get purge --auto-remove sipcrack -qq
    apt-get purge --auto-remove irpas -qq
    apt-get purge --auto-remove logkeys -qq
    apt-get purge --auto-remove zeitgeist-core -qq
    apt-get purge --auto-remove zeitgeist-datahub -qq
    apt-get purge --auto-remove python-zeitgeist -qq
    apt-get purge --auto-remove rhythmbox-plugin-zeitgeist -qq
    apt-get purge --auto-remove zeitgeist -qq
    apt-get purge --auto-remove nfs-kernel-server -qq
    apt-get purge --auto-remove nfs-common -qq
    apt-get purge --auto-remove portmap -qq
    apt-get purge --auto-remove rpcbind -qq
    apt-get purge --auto-remove autofs -qq
    apt-get purge --auto-remove inetd -qq
    apt-get purge --auto-remove openbsd-inetd -qq
    apt-get purge --auto-remove xinetd -qq
    apt-get purge --auto-remove inetutils-ftp -qq
    apt-get purge --auto-remove inetutils-ftpd -qq
    apt-get purge --auto-remove inetutils-inetd -qq
    apt-get purge --auto-remove inetutils-ping -qq
    apt-get purge --auto-remove inetutils-syslogd -qq
    apt-get purge --auto-remove inetutils-talk -qq
    apt-get purge --auto-remove inetutils-talkd -qq
    apt-get purge --auto-remove inetutils-telnet -qq
    apt-get purge --auto-remove inetutils-telnetd -qq
    apt-get purge --auto-remove inetutils-tools -qq
    apt-get purge --auto-remove inetutils-traceroute -qq
    apt-get purge --auto-remove vnc4server -qq
    apt-get purge --auto-remove vncsnapshot -qq
    apt-get purge --auto-remove vtgrab -qq
    apt-get purge --auto-remove snmp -qq
    apt-get purge --auto-remove nmapsi4 -qq
    apt-get purge --auto-remove amule -qq
    apt-get purge --auto-remove zangband -qq
    apt-get purge --auto-remove pumpa -qq
    apt-get purge --auto-remove pompem -qq
    apt-get purge --auto-remove goldeneye -qq
    apt-get purge --auto-remove themole -qq
    apt-get purge --auto-remove ftpscan -qq
    apt-get purge --auto-remove ftpsearch -qq
    apt-get purge --auto-remove 4g8 -qq
	apt-get purge --auto-remove inetutils-telnetd -y -qq
    apt-get purge --auto-remove dsniff -y -qq
    apt-get purge --auto-remove linuxdcpp -y -qq
    apt-get purge --auto-remove rfdump -y -qq
    apt-get purge --auto-remove heartbleeder -y -qq
    apt-get purge --auto-remove cupp3 -y -qq
    apt-get purge --auto-remove cmospwd -y -qq
    apt-get purge --auto-remove fcrackzip -y -qq
    apt-get purge --auto-remove freeciv -qq
    apt-get purge --auto-remove nmap -qq
    apt-get purge --auto-remove tcpspray -qq
    apt-get purge --auto-remove dsniff -qq
    apt-get purge --auto-remove wireshark -qq
    apt-get purge --auto-remove endless-sky -qq
    apt-get purge --auto-remove hunt -qq
    apt-get purge --auto-remove ettercap-common -qq
    apt-get purge --auto-remove chntpw -qq
    apt-get purge --auto-remove wapiti -qq
    apt-get purge --auto-remove zenmap -qq
    apt-get purge --auto-remove openvpn -qq
    apt-get purge --auto-remove vuze -qq
    apt-get purge --auto-remove frostwire -qq
    apt-get purge --auto-remove medusa -qq
    apt-get purge --auto-remove remmina -qq
    apt-get purge --auto-remove rdesktop -qq
    apt-get purge --auto-remove tightvncserver -qq
    apt-get purge --auto-remove vino -qq
    apt-get purge --auto-remove vinagre -qq
    apt-get purge --auto-remove knocker -qq
    apt-get purge --auto-remove minetest -qq
}



function disableBadServices(){
    systemctl stop smtp
    systemctl disable smtp

    systemctl stop popa3d
    systemctl disable popa3d
}



function fixFilePerms(){
    chmod 0644 /etc/passwd
    chmod 0640 /etc/shadow
    chmod 0640 /etc/shadow-

    chmod 0644 /etc/group
    chmod 0640 /etc/gshadow
    chmod 0640 /etc/gshadow-

    chmod 0640 /etc/pam.d/common-password
    chmod 0640 /etc/pam.d/common-auth

    chmod 0644 /etc/vsftpd.conf
    chmod 0644 /etc/pam.conf
}



function enableUFW(){
    apt install ufw

    ufw enable
    ufw logging high
}



function startSSH(){
    ufw allow ssh

    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
    cp ./configs/OpenSSH/sshd_config /etc/ssh/sshd_config

    cp /etc/pam.d/sshd /etc/pam.d/sshd.bak
    cp ./configs/OpenSSH/sshd /etc/pam.d/sshd

    systemctl restart ssh
    systemctl enable ssh
}



function startFTP(){
    ufw allow vsftpd

    cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
    cp ./configs/vsftpd/vsftpd.conf /etc/vsftpd.conf

    systemctl restart vsftpd
    systemctl enable vsftpd
}



function startNginx(){
    systemctl stop nginx

    tar -czvf nginx_$(date +'%F_%H-%M-%S').tar.gz /etc/nginx/*
    apt install --reinstall nginx -yqq

    mv ./configs/nginx/nginxconfig.io-example.com.tar.gz /etc
    tar -xzvf ./configs/nginx/nginxconfig.io-example.com.tar.gz -C /etc | xargs chmod 0644
    mv /etc/nginxconfig.io-example.com /etc/nginx

    systemctl restart nginx
    systemctl enable nginx
}



function startApache2(){
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    cp ./configs/apache2/apache2.conf /etc/apache2/apache2.conf

    systemctl restart apache2
    systemctl enable apache2
}



function securePAM(){
    cp /etc/login.defs /etc/login.defs.bak
    cp ./configs/pam/login.defs /etc/login.defs

    cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak
    cp ./configs/pam/common-auth /etc/pam.d/common-auth

    cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
    cp ./configs/pam/common-password /etc/pam.d/common-password

    if [ -e '/etc/pam.d/system-auth' ]; then
        cp /etc/pam.d/system-auth /etc/pam.d/system-auth.bak
        cp ./configs/pam/system-auth /etc/pam.d/system-auth
    fi
}



function secureLightDM(){
    if [ -e /etc/lightdm/lightdm ]; then
        cp /etc/lightdm/lightdm /etc/lightdm/lightdm.bak
        cp ./configs/lightDM/lightdm.conf /etc/lightdm/lightdm
    fi
}



function secureGDM3(){
    cp /etc/gdm3/custom.conf /etc/gdm3/custom.conf.bak
    cp ./configs/gdm3/gdm3 /etc/gdm3/custom.conf
}



function startAudits(){
    cp /etc/audit/audit.rules /etc/audit/audit.rules.bak
    cp ./configs/audit/audit.rules /etc/audit/audit.rules
}



function disableRootLogin(){
    passwd -l root
}



function secureSysctl(){
    cp /etc/sysctl.d/10-console-messages.conf /etc/sysctl.d/10-console-messages.conf.bak
    cp ./configs/sysctl/10-console-messages.conf /etc/sysctl.d/10-console-messages.conf

    cp /etc/sysctl.d/10-ipv6-privacy.conf /etc/sysctl.d/10-ipv6-privacy.conf.bak
    cp ./configs/sysctl/10-ipv6-privacy.conf /etc/sysctl.d/10-ipv6-privacy.conf

    cp /etc/sysctl.d/10-kernel-hardening.conf /etc/sysctl.d/10-kernel-hardening.conf.bak
    cp ./configs/sysctl/10-kernel-hardening.conf /etc/sysctl.d/10-kernel-hardening.conf

    cp /etc/sysctl.d/10-link-restrictions.conf /etc/sysctl.d/10-link-restrictions.conf.bak
    cp ./configs/sysctl/10-link-restrictions.conf /etc/sysctl.d/10-link-restrictions.conf

    cp /etc/sysctl.d/10-magic-sysrq.conf /etc/sysctl.d/10-magic-sysrq.conf.bak
    cp ./configs/sysctl/10-magic-sysrq.conf /etc/sysctl.d/10-magic-sysrq.conf

    cp /etc/sysctl.d/10-network-security.conf /etc/sysctl.d/10-network-security.conf.bak
    cp ./configs/sysctl/10-network-security.conf /etc/sysctl.d/10-network-security.conf

    cp /etc/sysctl.d/10-ptrace.conf /etc/sysctl.d/10-ptrace.conf.bak
    cp ./configs/sysctl/10-ptrace.conf /etc/sysctl.d/10-ptrace.conf

    cp /etc/sysctl.d/10-zeropage.conf /etc/sysctl.d/10-zeropage.conf.bak
    cp ./configs/sysctl/10-zeropage.conf /etc/sysctl.d/10-zeropage.conf
    
    cp /etc/sysctl.d/99-sysctl.conf /etc/sysctl.d/99-sysctl.conf.bak
    cp ./configs/sysctl/99-sysctl.conf /etc/sysctl.d/99-sysctl.conf
}



echo "[+] Auditing Users"
userAudit

echo "[+] Removing Bad Packages"
removeBadPackages

echo "[+] Fixing shadow and config file perms"
fixFilePerms

echo "[+] Enabling UFW"
enableUFW

echo "[+] Disabling bad services"
disableBadServices


read -p "Is SSH a critical service (Y/N)" action
if [ $action = 'y' -o $action = 'Y' ]; then
    echo "[+] Starting SSH"
    startSSH

else
    systemctl disable ssh
    systemctl stop ssh
fi


read -p "Is vsftpd a critical service (Y/N)" action
if [ $action = 'y' -o $action = 'Y' ]; then
    echo "[+] Starting vsftpd"
    startFTP

else
    systemctl disable vsftpd
    systemctl stop vsftpd
fi


read -p "Is Nginx a critical service (Y/N)" action
if [ $action = 'y' -o $action = 'Y' ]; then
    echo "[+] Starting Nginx"
    startNginx

else
    systemctl disable nginx
    systemctl stop nginx
fi


read -p "Is Apache2 a critical service (Y/N)" action
if [ $action = 'y' -o $action = 'Y' ]; then
    echo "[+] starting Apache2"
    startApache2
else
    systemctl disable apache2
    systemctl stop apache2
fi


echo "[+] Securing PAM"
securePAM

echo "[+] Disabling root login"
disableRootLogin

echo "[+] Securing Lightdm"
secureLightDM

echo "[+] Securing gdm3"
secureGDM3

echo "[+] Configuring audit"
startAudits

echo "[+] Securing sysctl.d"
secureSysctl