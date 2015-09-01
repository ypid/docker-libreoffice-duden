## For more examples of a Makefile based Docker container deployment see: https://github.com/ypid/docker-makefile

duden_setup_file_directory ?= $(HOME)/Downloads/Software
mount_volume_user_home     ?= $(HOME)/.local/share/libreoffice_duden_user_home

image_libreoffice_duden ?= ypid/libreoffice_duden

default:
	echo 'See Makefile'

build:
	docker build --no-cache=true --tag $(image_libreoffice_duden) .

build-dev:
	docker build --no-cache=false --tag $(image_libreoffice_duden) .

run: libreoffice_duden

libreoffice_duden:
	-@docker rm --force "$@"
	docker run --tty --interactive \
		--name "$@" \
		$(DOCKER_RUN_OPTIONS) \
		--volume $(duden_setup_file_directory):/home/user/duden_setup_files:ro \
		--volume /tmp/.X11-unix:/tmp/.X11-unix \
		--volume $(mount_volume_user_home):/home/user \
		--net=none \
		--env "DISPLAY=unix$$DISPLAY" \
		$(image_libreoffice_duden)
