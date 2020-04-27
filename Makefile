.PHONY: build run clean shell
SRCS:=Dockerfile requirements.in app.py
IMAGE:=docker_flask
PORT:=5000:5000
DARGS:=-it --rm -v $(CURDIR):/app

all: requirements.txt run

build: .build
.build: $(SRCS)
	docker build -t $(IMAGE) .
	echo > $@

run: build
	docker run $(DARGS) -p $(PORT) $(IMAGE)

shell: build
	docker run $(DARGS) --entrypoint /bin/bash $(IMAGE)

requirements.txt: build
	docker run -it --rm $(IMAGE) -m pip freeze > $@

clean:
#$(info $(SHELL))
#rm .build
# rm throws an error on windows, so using del for now.
	- del /Q /F .build
	- docker rmi $(IMAGE)