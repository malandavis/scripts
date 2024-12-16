#!/usr/bin/env bash
#

# To Use:
# Pass no arguments and it will just return branches and commits
# Pass any argument and it will git fetch and ask for confirmation before git pull on repos with a branch checked out

# Replace with absolute directory to folder tracked by git
rn="/home/mdavis/folder/"

# Repositories and submodules (relative paths from $rn)
dirs=("submodule1" "submodule1/other_sub")

declare -i num=1

echo ""
for dir in ${dirs[@]}
do
    cd "$rn$dir"
    status=$(git status)
    arrIN=(${status//changes/ })
    if [[ $status == *"HEAD detached"* ]]; then
        echo -e "$dir : \033[32m${arrIN[3]}\033[0m"
    else
        if [[ "$#" -eq 1 ]]; then
            git fetch
            status=$(git status)
        fi
        if [[ $status != *"up to date"* ]]; then
            echo -e "$dir : \033[31m${arrIN[2]} -> NEEDS UPDATED\033[0m"
            if [[ "$#" -eq 1 ]]; then
                echo "Do you wish pull this submodule?"
                select yn in "Yes" "No"; do
                    case $yn in
                        Yes ) git pull; break;; #git submodule update --init --recursive; break;;
                        No ) echo "Not pulling"; break;;
                    esac
                done
            fi
        else
            hash=$(git log -n 1 --pretty=format:"%H" | cut -c 1-7)
            echo -e "$dir : \033[33m${arrIN[2]}\033[0m at commit \033[32m${hash}\033[0m"
        fi
    fi

    # Change to seprate individual repos if desired
    if [[ $num -eq 1 ]]; then
        echo ""
        echo "------------------------------------------------------------------------------------------------------"
        echo ""
    fi
    ((num++))
done
echo ""

