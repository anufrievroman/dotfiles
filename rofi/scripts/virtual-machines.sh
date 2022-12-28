#!/usr/bin/env bash

# rofi-virtualbox: manage virtualbox machines with rofi
# Originally by Oliver Kraitschy <okraits@arcor.de> (https://github.com/okraits/rofi-tools)
# With modifications by Alexander Pushkov <hey@ale.sh>

OPTIONS="Start machine\nStart headless\nSend ACPI shutdown signal\nClone machine\nDelete machine"

kb_start="Control-Return"

args=(
    -dmenu
    -kb-custom-1 "${kb_start}"
    -kb-accept-custom ""
)

while true; do
    # select machine to control
    vm=$(vboxmanage list vms | awk -F '"' '{print $2}' | rofi "${args[@]}" 'Select machine:')
    rofi_exit=$?
    if [[ $rofi_exit -eq 1 ]]; then
        exit
    fi

    case "${rofi_exit}" in
    0) # default
        # just pass through to the menu
        ;;
    10) # -kb-custom-1
        vboxmanage startvm "$vm"
        exit
        ;;
    esac

    # select action to be executed
    option=$(echo -e $OPTIONS | rofi "${args[@]}" 'Select action:')
    rofi_exit=$?
    if [[ $rofi_exit -eq 1 ]]; then
        exit
    fi

    case "$option" in
    "Start machine")
        vboxmanage startvm "$vm"
        exit
        ;;
    "Start headless")
        vboxmanage startvm "$vm" --type headless
        ;;
    "Send ACPI shutdown signal")
        vboxmanage controlvm "$vm" acpipowerbutton --type headless
        ;;
    "Clone machine")
        vboxmanage clonevm "$vm" --mode machine --register --options keepallmacs
        ;;
    "Delete machine")
        vboxmanage unregistervm "$vm" --delete
        ;;
    *)
        exit 1
        ;;
    esac
done
