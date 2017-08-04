#!/bin/sh

gpio_d="/sys/class/gpio/gpio113/"

usage() {
    echo "crt_pwr.sh [on | off]"
}

if [ "$1" = "" ]; then
    usage
    exit
fi

set_pwr() {
    pval=$1
    if [ `cat ${gpio_d}direction` = "in" ]; then
        echo "Setting up pindir..."
        echo 0 >${gpio_d}value
        echo out >${gpio_d}direction
    else
        echo "Pindir already in output mode."
    fi
    echo "Setting pin value to $pval..."
    echo $pval >${gpio_d}value
}

case $1 in 
    on )
        set_pwr 1
        ;;
    off )
        set_pwr 0
        ;;
    *)
        usage
        ;;
esac

