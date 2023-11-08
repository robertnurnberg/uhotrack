#!/bin/bash

tempdir="/tmp/uhotrack"
gitdir="$HOME/git"
concurrency=16
bulkconcurrency=8
depthlimit=10
user="unknown"

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c <value>     Concurrency (default: $concurrency)"
    echo "  -b <value>     Bulk Concurrency (default: $bulkconcurrency)"
    echo "  -d <value>     Depth Limit (default: $depthlimit)"
    echo "  -u <str>       User Name (default: $user)"
    exit 1
}

while getopts "c:b:d:u:" opt; do
    case $opt in
    c)
        concurrency=$OPTARG
        ;;
    b)
        bulkconcurrency=$OPTARG
        ;;
    d)
        depthlimit=$OPTARG
        ;;
    u)
        user=$OPTARG
        ;;
    \?)
        echo "Invalid option: -$OPTARG"
        usage
        ;;
    esac
done

for dir in "$tempdir" "$gitdir"; do
    if [ ! -d "$dir" ]; then
        mkdir "$dir"
    fi
done
cd "$gitdir"
for repo in "cdbexplore" "uhotrack"; do
    if [ ! -d "$gitdir/$repo" ]; then
        git clone "https://github.com/robertnurnberg/$repo"
    fi
    cd $repo && git pull >&pull.log
    cd ..
done

python3 "$gitdir"/cdbexplore/cdbbulksearch.py "$gitdir"/uhotrack/uho_daily_shortest.epd --concurrency $concurrency --bulkConcurrency $bulkconcurrency --user $user --forever --reload --maxDepthLimit $depthlimit >&"$tempdir"/uho_daily_shortest.log &
