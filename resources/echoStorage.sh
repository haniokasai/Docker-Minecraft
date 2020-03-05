#!/bin/bash
used=$(df / | awk 'END{print $5}')
echo "ストレージは${used}使用されています。90％以上だと危険水準で、100％だと起動しなくなります。" >&1