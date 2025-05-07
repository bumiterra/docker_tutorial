docker build -t bastianhs/from from
docker image ls -a

docker build -t bastianhs/run run
docker build -t bastianhs/run --progress=plain --no-cache run
docker image ls -a | grep bastianhs

docker build -t bastianhs/command command
docker image inspect bastianhs/command
docker container create --name command bastianhs/command
docker container start command
docker container ls -a | grep command
docker container logs command

docker build -t bastianhs/label label
docker image inspect bastianhs/label

docker build -t bastianhs/add add
docker container create --name add bastianhs/add
docker container start add
docker container logs add

docker build -t bastianhs/copy copy
docker container create --name copy bastianhs/copy
docker container start copy
docker container logs copy

docker build -t bastianhs/ignore ignore
docker container create --name ignore bastianhs/ignore
docker container start ignore
docker container logs ignore

docker build -t bastianhs/expose expose
docker image inspect bastianhs/expose
docker container create --name expose -p 8080:8080 bastianhs/expose
docker container start expose
docker container ls
docker container stop expose

docker build -t bastianhs/env env
docker image inspect bastianhs/env
docker container create --name env --env APP_PORT=9090 -p 9090:9090 bastianhs/env
docker container start env
docker container ls
curl localhost:8080
curl localhost:9090
docker container logs env
docker container stop env

docker build -t bastianhs/volume volume
docker image inspect bastianhs/volume
docker container create --name volume -p 8080:8080 bastianhs/volume
docker container start volume
docker container ls
curl localhost:8080
docker container logs volume
docker volume ls
docker container stop volume

docker build -t bastianhs/workdir workdir
docker container create --name workdir -p 8080:8080 bastianhs/workdir
docker container start workdir
curl localhost:8080
docker container exec -it workdir sh
pwd
docker container stop workdir

docker build -t bastianhs/user user
docker container create --name user -p 8080:8080 bastianhs/user
docker container start user
curl localhost:8080
docker container exec -it user sh
whoami
exit
docker container stop user

docker build -t bastianhs/arg --build-arg app=bas arg
docker container create --name arg -p 8080:8080 bastianhs/arg
docker container start arg
curl localhost:8080
docker container exec -it arg sh
docker container logs arg
docker container stop arg

docker build -t bastianhs/health health
docker container create --name health -p 8080:8080 bastianhs/health
docker container start health
docker container ls
docker container inspect health
docker container stop health

docker build -t bastianhs/entrypoint entrypoint
docker image inspect bastianhs/entrypoint
docker container create --name entrypoint -p 8080:8080 bastianhs/entrypoint
docker container start entrypoint
curl localhost:8080
docker container stop entrypoint

docker build -t bastianhs/multi multi
docker image ls
docker container create --name multi -p 8080:8080 bastianhs/multi
docker container start multi
curl localhost:8080
docker container stop multi
