# rm -f log && nohup ./build_docker.sh > log 2>&1 & sleep 2 && tail -f log

# image build instructions:
COMMIT=$(git rev-parse --short HEAD)
echo commit $COMMIT
REPO_TAG="wtsihgi/crispr:$COMMIT"
echo repo tag $REPO_TAG
sudo docker build . -t $REPO_TAG
echo built docker image $REPO_TAG

#docker login --username mercury
#docker push $REPO_TAG
