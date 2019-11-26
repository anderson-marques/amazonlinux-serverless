CURRENT=20191125
build:
	@echo "Building amazonlinux-serverless"
	@docker build -t amazonlinux-serverless:${CURRENT} .
	@docker build -t amazonlinux-serverless:latest .

run:
	@echo "Running the Amazon image"
	docker run --rm -it amazonlinux-serverless:${CURRENT} bash

publish:
	@echo "Publishing Amazon Linux for serverless"
	docker pull amazonlinux-serverless:${CURRENT}
	docker pull amazonlinux-serverless:latest
