#!/bin/bash

GITHUB_REPO_PATH="$HOME/code"

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

    if [ ! -d $TCPLAYER_REPO_PATH ]; then
        mkdir -p $GITHUB_REPO_PATH
        cd $GITHUB_REPO_PATH
        git clone -q git@github.com:duxiaofeng-github/TcPlayer.git
    fi

    now=$(date +%Y\-%m\-%d)
    nowWithSecond=$(date +%Y\-%m\-%d\ %H\:%M\:%S)

    cd $TCPLAYER_REPO_PATH
    git fetch -q origin master
    git reset -q --hard origin/master
    
    ls | egrep -v "CHANGELOG.md|LICENSE.md|README_TEMPLATE.md|README.md|package.json" | xargs rm -v | &>/dev/null

    links=""

    for url in $@
    do
        wget -q $url
        links=$(printf "$links\n*[$url]($url)")
    done
    
    changed=$(git status --porcelain)

    if [[ $changed != "" ]]; then
        git add .

        changed=$(git status --porcelain)

        printf "### AUTO UPDATE($nowWithSecond)\n$changed\n\n" >> CHANGELOG.md
        README_TEMPLATE=$(cat README_TEMPLATE.md)
        README_TEMPLATE=${README_TEMPLATE/tcplayerUrlPlaceHolder/$links}
        echo $README_TEMPLATE > README.md

        git add .
        git commit -q -m "auto update($now)"
        # git push -q

        # npm version patch | &>/dev/null
        # npm publish
        # git push -q --tags
        
        newVersion=$(git tag -l | tail -n 1)
        echo $newVersion
    fi
}

function main() {
    checkTcPlayerRepo
}

main
