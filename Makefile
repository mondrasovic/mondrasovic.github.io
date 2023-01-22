IMAGE_NAME = mond/github-pages-blog
SRC_DIR = /mondrasovic.github.io

docker_build:
	docker build --build-arg SRC_DIR=${SRC_DIR} -t ${IMAGE_NAME} -f Dockerfile .

docker_run:
	docker run -it -v ${shell pwd}:${SRC_DIR} -p 127.0.0.1:4000:4000 ${IMAGE_NAME} bash
