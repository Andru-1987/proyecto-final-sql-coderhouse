#!/bin/bash

until docker compose logs mysql | grep "/usr/sbin/mysqld: ready for connections."; do 
    echo -n .; 
    sleep 1;
done

sleep 5