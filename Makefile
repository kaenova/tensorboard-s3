build:
	docker build -t tb-s3-test:latest .

run:
	docker run --rm --env-file .env --network host tb-s3-test:latest

delete:
	docker image rm tb-s3-test