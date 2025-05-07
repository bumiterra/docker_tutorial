docker image ls
docker image pull redis:latest
docker image rm redis:latest

docker container ls
docker container ls -a
docker container create --name container1 redis:latest
docker container start container1
docker container stop container1
docker container rm container1
docker container logs container1
docker container logs -f container1
docker container exec -it container1 bash
docker container create --name containernginx --publish 8080:80 nginx:latest
docker container create --name containermongo --publish 27017:27017 --env MONGO_INITDB_ROOT_USERNAME=bas --env MONGO_INITDB_ROOT_PASSWORD=bas mongo:latest
docker container stats
docker container create --name smallnginx --publish 8081:80 --memory 100m --cpus 0.5 nginx:latest
docker container create --name mongodata --publish 27018:27017 --env MONGO_INITDB_ROOT_USERNAME=bas --env MONGO_INITDB_ROOT_PASSWORD=bas --mount "type=bind,source=/home/bas/Downloads/mongodata,destination=/data/db" mongo:latest

docker volume ls
docker volume create mongovolume
docker volume rm mongovolume
docker container create --name mongovolume --env MONGO_INITDB_ROOT_USERNAME=bas --env MONGO_INITDB_ROOT_PASSWORD=bas --mount "type=volume,source=mongovolume,destination=/data/db" --publish 27019:27017 mongo:latest

docker container stop mongovolume
docker container create --name nginxbackup --mount "type=volume,source=mongovolume,destination=/tempvolume" --mount "type=bind,source=/home/bas/Downloads/backup,destination=/tempbackup" nginx:latest
docker container start nginxbackup
docker container exec -it nginxbackup bash
cd /tempbackup
tar -czvf /tempbackup/backup.tar.gz /tempvolume
docker container stop nginxbackup
docker container rm nginxbackup
docker container start mongovolume

docker container stop mongovolume
docker container run --rm --name ubuntubackup --mount "type=volume,source=mongovolume,destination=/tempvolume" --mount "type=bind,source=/home/bas/Downloads/backup,destination=/tempbackup" ubuntu:latest tar -czvf /tempbackup/backup.tar.gz -C /tempvolume .
docker container start mongovolume

docker container stop mongovolume
docker volume create mongovolumerestore
docker container run --rm --name ubuntubackup --mount "type=volume,source=mongovolumerestore,destination=/tempvolume" --mount "type=bind,source=/home/bas/Downloads/backup,destination=/tempbackup" ubuntu:latest tar -xzvf /tempbackup/backup.tar.gz -C /tempvolume
docker container create --name mongovolumerestore --env MONGO_INITDB_ROOT_USERNAME=bas --env MONGO_INITDB_ROOT_PASSWORD=bas --mount "type=volume,source=mongovolumerestore,destination=/data/db" --publish 27020:27017 mongo:latest

docker network ls
docker network create --driver bridge mynetwork
docker network rm mynetwork
docker network create --driver bridge mongonetwork
docker container create --name mongodb --env MONGO_INITDB_ROOT_USERNAME=bas --env MONGO_INITDB_ROOT_PASSWORD=bas --network mongonetwork mongo:latest
docker container create --name mongodbexpress --env ME_CONFIG_MONGODB_ADMINUSERNAME=bas --env ME_CONFIG_MONGODB_ADMINPASSWORD=bas --env ME_CONFIG_MONGODB_URL=mongodb://bas:bas@mongodb:27017/ --env ME_CONFIG_BASICAUTH=false --network mongonetwork --publish 8081:8081 mongo-express:latest
docker container start mongodb
docker container start mongodbexpress
docker network disconnect mongonetwork mongodb
docker network connect mongonetwork mongodb
