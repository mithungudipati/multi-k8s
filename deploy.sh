  
docker build -t mithungudipati/multi-client:latest -t mithungudipati/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mithungudipati/multi-server:latest -t mithungudipati/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mithungudipati/multi-worker:latest -t mithungudipati/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mithungudipati/multi-client:latest
docker push mithungudipati/multi-server:latest
docker push mithungudipati/multi-worker:latest

docker push mithungudipati/multi-client:$SHA
docker push mithungudipati/multi-server:$SHA
docker push mithungudipati/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mithungudipati/multi-server:$SHA
kubectl set image deployments/client-deployment client=mithungudipati/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mithungudipati/multi-worker:$SHA
