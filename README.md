# docker-libreoffice-duden

Docker image to get the old and rotten Duden-Rechtschreibprüfung V9 software running.

The build instructions are tracked on [GitHub][this.project_github_url].

The image is manually pushed to [Docker Hub][this.project_docker_hub_url] (Digest: sha256:cc6cc7bf94031e88e46a27543114d9d4c46f13e40e79912917177c6fbc8f3501).

[this.project_docker_hub_url]: https://hub.docker.com/r/ypid/libreoffice_duden/
[this.project_github_url]: https://github.com/ypid/docker-libreoffice-duden

There was a time when [Duden](http://www.duden.de) sold a offline version of there quite advanced and powerful spell checking software for 19.95 € or something like that.

Currently it seems that they only provide a limited\* online version: http://www.duden.de/rechtschreibpruefung-online/

\* The limitation is that you can only check 800 characters at a time. So for normal documents you would have to split your text or write a script which does this for you.
The other limitation is currently that this online tool is only reachable via HTTP. HTTPS answers with 302 Moved Temporarily to http …

The spell checking is implemented as OpenOffice/LibreOffice extension. So far so good. The problem is that this extension is only compatible with LibreOffice < 4 and if that was not enough it only works on i386 platforms. Thats why this Docker image has been created to easily use this old but still useful software.

## How it works

It uses a self build Debian Wheezy i386 Docker base image and prepares it for the use with the Duden extension. On the first start the extension is installed (which is not included in this image).

## Building the base image

Checkout my [docker-makefile](https://github.com/ypid/docker-makefile) repository and `make build-debian-wheezy-i368-base-image`.

Not needed when pulled from Docker Hub.

## Getting the image

```Shell
make build
```

or

```Shell
docker pull ypid/libreoffice_duden
```

## Installing the extension and running it

```Shell
make install
```

You might need to change the owner of the bind mounted directory `mount_volume_user_home` from your host system to match your user. Note that the UID must match with the user inside which is 1000.

The Makefile expects that you saved the extension extracted from the zip file under `~/Downloads/Software/` which is mounted in the container as `~/duden_setup_files`.

```Shell
## In the container
unopkg add duden_setup_files/die-duden-rechtschreibpruefung.oxt
## You only get a: ERROR: You need write permissions to install this extension!
## Does not work with on first try (as said, this software is old …)
unopkg add duden_setup_files/die-duden-rechtschreibpruefung.oxt
unopkg list
```

After that you should see something like this:

    All deployed user extensions:

    Identifier: de.bifab.www.DudenProofFactory-linux_x86
      Version: 9.0.0.2
      URL: vnd.sun.star.expand:$UNO_USER_PACKAGES_CACHE/uno_packages/lu2cr85z.tmp_/die-duden-rechtschreibpruefung.oxt
      is registered: yes
      Media-Type: application/vnd.sun.star.package-bundle
      Description: Mit dem Duden erkennen Sie jeden Fehler. Und Ihr PC auch.

Now you should be able to start LibreOffice with the Duden spell checking extension enabled and German language preselected.
For that just exit out of the container and execute:

```Shell
make run
```

For subsequent starts you can just type `make` which defaults to `make start`. This will start the container created by `make run`.

## License

This project is distributed under [GNU Affero General Public License, Version 3][AGPLv3].

[AGPLv3]: https://github.com/jchaney/owncloud/blob/master/LICENSE
