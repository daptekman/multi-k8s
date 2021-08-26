docker build -t danielaptekman/multi-client:latest -t danielaptekman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danielaptekman/multi-server:latest -t danielaptekman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danielaptekman/multi-worker:latest -t danielaptekman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danielaptekman/multi-client:latest
docker push danielaptekman/multi-client:$SHA

docker push danielaptekman/multi-server:latest
docker push danielaptekman/multi-server:$SHA

docker push danielaptekman/multi-worker:latest
docker push danielaptekman/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danielaptekman/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=danielaptekman/multi-worker:$SHA
kubectl set image deployments/client-deployment client=danielaptekman/multi-client:$SHA