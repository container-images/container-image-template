#!/bin/bash

#!/bin/bash

set -x
EC=0
echo "Initialize module"
# Set up environment
moduleframework-cmd -v setUp
moduleframework-cmd -v start

echo "Start testing"
echo "Test getting response with curl"

RES=`curl http://localhost:9000`
if [ "$RES" != "I am awesome" ]; then
  exit 1
fi

echo "Destroy module"
moduleframework-cmd -v tearDown
exit $EC
