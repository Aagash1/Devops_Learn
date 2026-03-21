#!/bin/bash

STATUS=$(docker inspect -f '{{.State.Status}}' jenkins_container)

if [ "$STATUS" = "running" ]; then
    echo "<h1>Jenkins is running</h1>" > status.html
else
    echo "<h1>Jenkins is NOT running</h1>" > status.html
fi

docker cp status.html httpd_container:/usr/local/apache2/htdocs/index.html
