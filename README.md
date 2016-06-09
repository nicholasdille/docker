## Install docker tools

```
choco install -y docker docker-compose docker-machine
```

## Useful commands

* Remove all containers:

  ```
  docker ps --format "{{.ID}}" -a | % {docker rm $_}
  ```

* Remove all container based on a specific image

  ```  docker ps -f ancestor=windowsservercore -a --format "{{.ID}}" | % {docker rm $_}
  ```

* Remove all untagged (dangling) images

  ```
  docker images -f dangling=true --format "{{.ID}}" | % {docker rmi $_}
  ```