#!/bin/bash

# substitute for ack-grep. ack-grep does not exist on RHEL, so we reduce to
# grep. Keeping the 'a' alias.

echo $@

grep --color -r "$@" *
