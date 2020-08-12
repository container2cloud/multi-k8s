docker build -t container2cloud/multi-client:latest -t container2cloud/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t container2cloud/multi-server:latest -t container2cloud/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t container2cloud/multi-worker:latest -t container2cloud/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push container2cloud/multi-client:latest
docker push container2cloud/multi-server:latest
docker push container2cloud/multi-worker:latest

docker push container2cloud/multi-client:$SHA
docker push container2cloud/multi-server:$SHA
docker push container2cloud/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=container2cloud/multi-server:$SHA
kubectl set image deployment/client-deployment client=container2cloud/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=container2cloud/multi-worker:$SHA
