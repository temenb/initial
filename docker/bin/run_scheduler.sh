#!/bin/bash

docker exec -i initialcode-php sh -c "php artisan schedule:run"
