#!/bin/bash

# The on-exit event is triggered once, after all processing is complete.
# This hook script has no effect on processing.

# Input:
# - line of JSON for each modified task

# Output:
# - Optional feedback/error.

TASK_BIN=/usr/bin/task
NEED_LEV=`task _get rc.needlevel`
if [[ "$NEED_LEVEL" =~ "[1-6]+" ]]; then
echo "Need-level filterring set to $NEED_LEV or lower"
exit 0
fi

# Status:
# - 0:     Non-JSON is feedback.
# - non-0: Non-JSON is error.
exit 0
