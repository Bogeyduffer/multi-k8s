
docker build -t bogeyduffer/multi-client:latest -t bogeyduffer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bogeyduffer/multi-server:latest -t bogeyduffer/multi-server:$SHA-f ./server/Dockerfile ./server
docker build -t bogeyduffer/multi-worker:latest -t bogeyduffer/multi-worker:$SHA-f ./worker/Dockerfile ./worker

docker push bogeyduffer/multi-client:latest
docker push bogeyduffer/multi-server:latest
docker push bogeyduffer/multi-worker:latest
docker push bogeyduffer/multi-client:$SHA
docker push bogeyduffer/multi-server:$SHA
docker push bogeyduffer/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-development server=bogeyduffer/multi-server:$SHA
kubectl set image deployments/client-development client=bogeyduffer/multi-client:$SHA
kubectl set image deployments/worker-development worker=bogeyduffer/multi-worker:$SHA
