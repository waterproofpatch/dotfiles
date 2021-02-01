all:
	docker build -t devenv .

run:
	docker run -it devenv
