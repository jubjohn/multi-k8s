docker build -t jubinjohn/multi-client:latest -t jubinjohn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jubinjohn/multi-server:latest -t jubinjohn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jubinjohn/multi-worker:latest -t jubinjohn/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jubinjohn/multi-client:latest
docker push jubinjohn/multi-server:latest
docker push jubinjohn/multi-worker:latest
docker push jubinjohn/multi-client:$SHA
docker push jubinjohn/multi-server:$SHA
docker push jubinjohn/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jubinjohn/multi-server:$SHA
kubectl set image deployments/client-deployment client=jubinjohn/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jubinjohn/multi-worker:$SHA
