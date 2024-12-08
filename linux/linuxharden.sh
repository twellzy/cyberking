function userAudit(){
    #check which scoring engine is used
    if [ -f '/opt/CyberPatriot/README.desktop' ]; then
        url=$(cat /opt/CyberPatriot/README.desktop | grep -oP 'https?://[^"]+')
    fi

    if [ -f '/opt/aeacus/README.desktop' ]; then
        url=$(cat /opt/aeacus/README.desktop | grep -oP 'https?://[^"]+')
    fi

    #put list of authorized standard users into ./res/authed_standard_users.txt
    curl $url > ./res/readme.html
    awk '/<b>Authorized Users:<\/b>/,/<\/pre>/' ./res/readme.html | grep -oP '^\s*\w+' > './res/authed_standard_users.txt'

    #put list of authorized admins into ./res/authed_admins.txt
    awk ' BEGIN { capture = 0; } /Authorized Administrators/ { capture = 1; next; } /<b>Authorized Users:<\/b>/ { capture = 0; } capture && /^[[:alpha:]]/ { sub(/ \(you\)/, ""); print $1; } ' ./res/readme.html > ./res/authed_admins.txt

    #put list of all authorized users into ./res/authed_users.txt
    cat ./res/authed_standard_users.txt ./res/authed_admins.txt > ./res/authed_users.txt

    #put list of all users authorized or not into ./res/all_users.txt
    getent passwd | awk -F: '($3 >= 1000 && $3 < 3000) { print $1 }' > './res/all_users.txt'


    while read -r user; do
        grep $user ./res/authed_admins
        if [ $? -eq 1 ]; then
            deluser $user adm
            deluser $user sudo
        fi

        grep $user ./res/authed_users.txt
        if [ $? -eq 1 ]; then
            #remove user's cronjobs
            crontab -u $user -r

            #remove user's processes
            killall -u $user

            #delete the user
            userdel -f $user
        fi

        echo -e "Cyb3rP@triot1234!\nCyb3rP@triot1234!" | passwd $user

    done < ./res/all_users.txt
}

userAudit