docker build -t dickyardiaia/multi-client:latest -t dickyardiaia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dickyardiaia/multi-server:latest -t dickyardiaia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dickyardiaia/multi-worker:latest -t dickyardiaia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dickyardiaia/multi-client:latest
docker push dickyardiaia/multi-server:latest
docker push dickyardiaia/multi-worker:latest

docker push dickyardiaia/multi-client:$SHA
docker push dickyardiaia/multi-server:$SHA
docker push dickyardiaia/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dickyardiaia/multi-server:$SHA
kubectl set image deployments/client-deployment client=dickyardiaia/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dickyardiaia/multi-worker:$SHA