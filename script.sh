#!/bin/bash
exec nc -kl 9000 -c 'echo -e "HTTP/1.1 200 OK\n";echo "I am awesome"'
