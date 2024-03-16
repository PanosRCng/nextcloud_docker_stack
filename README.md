# nextcloud docker stack (nextcloud / mariadb / redis / nginx)


* start to background
    ```
    docker compose --env-file=env -f nextcloud.yml up -d
    ```

* stop
    ```
    docker compose --env-file=env -f nextcloud.yml down
    ```


### configuration
```
cp env_sample env
```
```
make changes to env
```

### (*) nextcloud cron job issue
fix for  https://github.com/nextcloud/docker/issues/1695
```
*/5 * * * * /usr/bin/docker exec -u 1000:1000 nextcloud_stack_nextcloud php -f /var/www/html/cron.php
```

### (*) Desktop Client issue
fix for Desktop Client is trying to use HTTP instead of HTTPS
```
add to nextcloud_data/app_data/config/config.php
    'overwrite.cli.url' => 'https://nextcloud.mydomain.com',
    'overwriteprotocol' => 'https',
```


### (*) reset_stack.sh
    (!) removes all generated data files 
    (!) data loss
    (!) needs root privileges



### migrate data to new server

* copy data
```
rsync -e 'ssh -p 22 -o "StrictHostKeyChecking no"' -ravzx --delete --numeric-ids /SOURCE/nextcloud/data/USER/files /DESTINATION/nextcloud_stack_docker_compose/stack_data/nextcloud_data/datadir/USER/
```

* run files scan
```
/usr/bin/docker exec -u 1000:1000 nextcloud_stack_nextcloud /var/www/html/occ files:scan --all
```

### update

Updating is done by pulling the new image, throwing away the old container and starting the new one.

* stop the stack
    ```
    docker compose --env-file=env -f nextcloud.yml down
    ```
* remove old nextcloud docker image
    ```
    docker image rm nextcloud:fpm-alpine 
    ```
* start the stack
    ```
    docker compose --env-file=env -f nextcloud.yml up -d
    ```

### System Links

#### nextcloud
```
http://127.0.0.1:8083
```

##### based on https://github.com/nextcloud/docker/blob/master/.examples/docker-compose/insecure/mariadb/fpm/docker-compose.yml

