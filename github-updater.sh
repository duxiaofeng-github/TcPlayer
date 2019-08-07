#!/bin/bash
GITHUB_REPO_PATH="$HOME"
README_TEMPLATE=$(cat README_TEMPLATE.md)

function initKey() {
    keyDir="$HOME/.ssh"
    keyPath="$keyDir/tcplayer_rsa"
    sshConfigPath="$keyDir/config"

    if [[ ! -f $keyPath ]] && [[ $adk != "" ]]; then
        echo "$adk" > $keyPath
        chmod og-r $keyPath
        printf "Host github.com\n  IdentityFile $keyPath" >> $sshConfigPath
        ll keyDir
    fi
}

function checkTcPlayerRepo() {
    tcUrl=$(python get-player-script-url.py)

    if [[ $tcUrl == "" ]]; then
        echo 'no url found'
        exit 0
    fi

    nowWithSecond=$(date +%Y\-%m\-%d\ %H\:%M\:%S)

    changedVersion=$(updateTcPlayer $tcUrl)

    if [[ $changedVersion != "" ]]; then
        echo "$nowWithSecond, tags: $changedVersion"
    else
        echo "$nowWithSecond tcplayer not changed"
    fi
}

function updateTcPlayer() {
    TCPLAYER_REPO_PATH="$GITHUB_REPO_PATH/TcPlayer"

    if [[ ! -d $TCPLAYER_REPO_PATH ]]; then
        mkdir -p $GITHUB_REPO_PATH
        cd $GITHUB_REPO_PATH
        git clone -q git@github.com:duxiaofeng-github/TcPlayer.git
    fi

    now=$(date +%Y\-%m\-%d)
    nowWithSecond=$(date +%Y\-%m\-%d\ %H\:%M\:%S)

    cd $TCPLAYER_REPO_PATH
    git fetch -q origin master
    git reset -q --hard origin/master
    
    ls | egrep -v "CHANGELOG.md|LICENSE.md|README.md|package.json" | xargs rm -v | &>/dev/null

    links="\n"

    for url in $@
    do
        wget -q $url
        links=$(printf "$links\n* [$url]($url)")
    done
    
    changed=$(git status --porcelain)

    if [[ $changed != "" ]]; then
        git add .

        changed=$(git status --porcelain | sed $'s/^/\\\n- /')
        
        printf "\n### AUTO UPDATE($nowWithSecond)\n$changed\n" >> CHANGELOG.md
        README_TEMPLATE_COPY=${README_TEMPLATE/ tcplayerUrlPlaceHolder/$links}
        echo "$README_TEMPLATE_COPY" > README.md

        git add .
        git commit -q -m "auto update($now)"
        git push -q

        newVersion=$(npm version patch)
        npm publish | &>/dev/null
        git push -q --tags
        
        echo $newVersion
    fi
}

function main() {
    initKey
    checkTcPlayerRepo
}

main