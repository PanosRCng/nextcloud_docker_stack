# nextcloud docker stack (nextcloud / mariadb / redis / nginx)


* start to background
    ```
    make start
    ```

* stop
    ```
    make stop
    ```


### configuration
```
cp env_example env
```
```
edit env
```

### (*) nextcloud cron job issue
fix for  https://github.com/nextcloud/docker/issues/1695
```
*/5 * * * * /usr/bin/docker exec -u 1000:1000 nextcloud_stack_nextcloud php -f /var/www/html/cron.php
```


### (*) reset_stack.sh
    (!) removes all generated data files 
    (!) data loss
    (!) needs root privileges



### migrate data to new server

* copy data
```
rsync -e 'ssh -p 22 -o "StrictHostKeyChecking no"' -ravzx --delete --numeric-ids /SOURCE/nextcloud/data/USER/files /DESTINATION/nextcloud_docker_stack/stack_data/nextcloud_data/datadir/USER/
```

* run files scan
```
/usr/bin/docker exec -u 1000:1000 nextcloud_stack_nextcloud /var/www/html/occ files:scan --all
```

### update

Updating is done by pulling the new image, throwing away the old container and starting the new one.

* stop the stack
    ```
    make stop
    ```
* remove old nextcloud docker image
    ```
    docker image rm nextcloud:fpm-alpine 
    ```
* start the stack
    ```
    make start
    ```

### System Links

#### nextcloud
```
http://127.0.0.1:8080
```

##### based on https://github.com/nextcloud/docker/blob/master/.examples/docker-compose/insecure/mariadb/fpm/docker-compose.yml

