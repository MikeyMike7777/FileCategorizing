#!/bin/bash
#
# file: merge.sh
# author: Michael Mathews
# course: CSI 3336
# due date: 2/20/23
#
# date modified: 2/20/23
#       - file created

#    makeDirectory 
# 
#    makes directory if it should be made 
# 
#     Parameters: 3 directories, 2 source, 1 destination              
#                 
# 
#     Output: 
#              return: 1 if error, 0 if good      

makeDirectory(){
#clarifies args is only 3 directories
#checks source directories are made and destination directory not made
    if [[ $# == 3 ]]
    then
        if [[ -e $1 && -e $2 ]]
        then
            if [[ -e $3 ]]
            then
                echo "error: new directory already exists"
                return 1
            else
                mkdir $3
                return 0
            fi
        else
            echo "error: file path does not exist"
            return 1
        fi
    else
        echo "usage: [-keep, -larger] <source> <source> <new path>" 
        return 1
    fi
}


#    optionsHandler 
# 
#    processes options 
# 
#     Parameters: 3 directories, 2 source, 1 destination              
#                 
# 
#     Output: 
#              return: none      
# 
#   options
#   -keep : keep both files, rename older file to .old
#       if already .old, print error
#   -larger : favor larger files in event of name collision
#   -larger -keep : rename smaller file to .small

optionHandler(){
    cp -r $1/* $3
    for file in `ls -aI . -I .. $2`
    do
        if [[ -e $3/$file ]]
        then
#file1 holds the file name
            file1=$file
#file3 holds the file path connected to a
            file3=$1/$file
#file2 holds the file path connected to c
            file2=$3/$file
#file holds the file path connected t b
            file=$2/$file              

#checks options, depending on options, copies accordingly
            if [[ $KEEP == 0 && $LARGER == 0 ]]
            then
                if [[ `stat -c%s $file` -gt `stat -c%s $file2` ]]
                then
                    mv -b -S .small $file $3
                else
                    cp $file $file.small
                    mv $file.small $3
                fi
            elif [[ $KEEP = 0 ]]
            then
                if [[ `stat -c %Y $file` -gt `stat -c %Y $file2` ]]
                then
                    mv -b -S .old $file $3
                else
                    cp $file $file.old
                    mv $file.old $3
                fi
            elif [[ $LARGER = 0 ]]
            then
                if [[ `stat -c%s $file` -gt `stat -c%s $file2` ]]
                then
                    cp $file $3
                fi
            else
                if [[ `stat -c %Y $file` -gt `stat -c %Y $file3` ]]
                then
                    cp $file $3
                fi
            fi
        else
            cp $2/$file $3
        fi
    done
}


#main
if [[ $# -ge 3 && $# -le 5 ]]
then
    KEEP=1
    LARGER=1
    ARGS=''
    while [[ $1 ]]
    do
        if [[ $1 == '-keep' ]]
        then
            KEEP=0
        elif [[ $1 == '-larger' ]]
        then
            LARGER=0
        else
            ARGS+=' '$1
        fi

        shift
    done

    makeDirectory $ARGS
    if [[ $? == 0 ]]
    then
        optionHandler $ARGS
    fi
else
    echo "usage: [-keep, -larger] <source> <source> <new path>"
fi
