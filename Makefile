## For more examples of a Makefile based Docker container deployment see: https://github.com/ypid/docker-makefile

DOCKER_RUN_OPTIONS ?= --env "TZ=Europe/Berlin"

duden_setup_file_directory ?= $(HOME)/Downloads/Software
mount_volume_user_home     ?= $(HOME)/.local/share/libreoffice_duden_user_home

image_libreoffice_duden ?= ypid/libreoffice_duden

libreoffice_duden_container_name ?= libreoffice_duden

.PHONY: default build build-dev install run desktop-entry


default: run

build:
	docker build --no-cache=true --tag $(image_libreoffice_duden) .

build-dev:
	docker build --no-cache=false --tag $(image_libreoffice_duden) .

install:
	-@docker rm --force "$(libreoffice_duden_container_name)"
	docker run --tty --interactive \
		--name "$(libreoffice_duden_container_name)" \
		$(DOCKER_RUN_OPTIONS) \
		--env "DISPLAY=unix$$DISPLAY" \
		--volume /tmp/.X11-unix:/tmp/.X11-unix \
		--volume $(duden_setup_file_directory):/home/user/duden_setup_files:ro \
		--volume $(mount_volume_user_home):/home/user \
		--net=none \
		$(image_libreoffice_duden)
		# --user=root \

run:
	-@docker rm --force "$(libreoffice_duden_container_name)"
	docker run --tty --interactive \
		--name "$(libreoffice_duden_container_name)" \
		$(DOCKER_RUN_OPTIONS) \
		--env "DISPLAY=unix$$DISPLAY" \
		--volume /tmp/.X11-unix:/tmp/.X11-unix \
		--volume $(duden_setup_file_directory):/home/user/duden_setup_files:ro \
		--volume $(mount_volume_user_home):/home/user \
		--net=none \
		$(image_libreoffice_duden) \
		libreoffice

## Not working?? `make run is executed but Docker fails?
desktop-entry:
	@(echo "[Desktop Entry]"; \
	echo "Encoding=UTF-8"; \
	echo "Version=1.0"; \
	echo "Type=Application"; \
	echo "NoDisplay=false"; \
	echo "Exec=sh -c 'cd $(PWD) && make run >> /tmp/.duden-libreoffice.log'"; \
	echo "Name=Duden LibreOffice (Docker)") > "$(HOME)/.local/share/applications/userapp-duden-libreoffice.desktop"
