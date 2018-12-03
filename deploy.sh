docker build -t sidnarang/multi-client:latest -t sidnarang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sidnarang/multi-server:latest -t sidnarang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sidnarang/multi-worker:latest -t sidnarang/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sidnarang/multi-client:latest
docker push sidnarang/multi-server:latest
docker push sidnarang/multi-worker:latest

docker push sidnarang/multi-client:$SHA
docker push sidnarang/multi-server:$SHA
docker push sidnarang/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sidnarang/multi-server:$SHA
kubectl set image deployments/client-deployment client=sidnarang/multi-client:$SHA
