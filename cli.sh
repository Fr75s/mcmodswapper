#!/bin/bash

#
#   CUSTOMIZATION
#
#   You may customize the script here.
#   You can change which directory minecraft is in,
#   Or you can change the modswap folder.
#
#   By default, minecraft is in ~/.minecraft
#   and modswap is a folder in ~/.minecraft (.minecraft/modswap/)
#

mcdirectory=~/.minecraft
swapfolder=$mcdirectory/modswap

#   Script begins here.
#   Do not modify if you don't know what you're doing.

echo "Minecraft Mod Swap Tool"
echo

while :; do
    case $1 in
        -h|-\?|--help)
            echo "MC Mod Swap Tool"
            echo "Allows you to swap mods"
            echo
            echo "Usage: "
            echo "  -h      || Brings this up"
            echo "  -e      || Edits Minecraft and Swap directories"
            echo "  -l      || Lists current mod directory and mods within"
            echo
            echo " To use this tool, create a directory in your"
            echo ".minecraft folder named [modswap]."
            echo " Once done, create folders within modswap. These"
            echo "are your swap directories, which will replace"
            echo "your mods folder. Name them anything you want,"
            echo "but it is recommended to keep their names short"
            echo "and with no spaces."
            echo " Make sure to backup any existing mods in your"
            echo "preexisting mods folder."
            echo " Run this script again to begin."
            echo
            exit 0
            ;;
        -e|--edit)
            echo "You are editing the minecraft and modswap directories."

            read -r -p "Set your minecraft directory: " mcdirectory
            read -r -p "Set your modswap directory: " swapfolder
            ;;
        -l|--list)
            echo "Listing Mod Directory"
            ls $mcdirectory/mods

            echo "Listing Mods"
            for file in $mcdirectory/mods/*
            do
                echo $file
            done
            exit 0
            ;;
        *)
            break
    esac

    shift
done

echo "Entering modswap folder..."
if [[ -d $swapfolder ]]
then
    cd $swapfolder
else
    echo "No modswap folder found!"
    echo " Run this script again with the flag -h"
    echo "to set up your modswap folder"
    echo " If you have a modswap folder, your"
    echo "minecraft installation may be somewhere"
    echo "other than ~/.minecraft. If so, please"
    echo "modify this script."
    echo
    echo ".minecraft directory: " $mcdirectory
    echo "modswap directory: " $swapfolder
    echo
    echo "Exiting..."
    exit 0
fi

read -r -p "What folder do you wish to swap mods with? " fname

if [[ -d $swapfolder/$fname && -d $mcdirectory ]]
then
    # Swapping

    echo "Removing mods in mods folder..."
    for file in $mcdirectory/mods/*
    do
        rm $file
    done

    echo "Copying modswap mods to mods folder..."
    for file in $swapfolder/$fname/*
    do
        cp $file $mcdirectory/mods/
    done

    echo "Done! Mods should be swapped now :)"

else
    echo "Folder not found!"
    echo "Run this script again"
    echo "Or set the minecraft directory to you installation."
    echo "Exiting..."
    exit 0
fi
