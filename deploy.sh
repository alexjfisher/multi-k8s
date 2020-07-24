docker build -t alexjfisher/multi-client:latest -t alexjfisher/multi-client:${SHA} -f ./client/Dockerfile ./client
docker build -t alexjfisher/multi-server:latest -t alexjfisher/multi-server:${SHA} -f ./server/Dockerfile ./server
docker build -t alexjfisher/multi-worker:latest -t alexjfisher/multi-worker:${SHA} -f ./worker/Dockerfile ./worker

docker push alexjfisher/multi-client:latest
docker push alexjfisher/multi-server:latest
docker push alexjfisher/multi-worker:latest

docker push alexjfisher/multi-client:${SHA}
docker push alexjfisher/multi-server:${SHA}
docker push alexjfisher/multi-worker:${SHA}

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexjfisher/multi-server:${SHA}
kubectl set image deployments/client-deployment client=alexjfisher/multi-client:${SHA}
kubectl set image deployments/worker-deployment worker=alexjfisher/multi-worker:${SHA}
