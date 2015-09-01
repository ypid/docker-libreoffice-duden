# docker-libreoffie-duden

Docker image to get the old and rotten Duden-Rechtschreibprüfung V9 software running.

There was a time when [Duden](http://www.duden.de) sold a offline version of there quite advanced and powerful spell checking software for 19.95 € or something like that.

Currently it seems that they only provide an limited online version: http://www.duden.de/rechtschreibpruefung-online/

The spell checking is implemented as OpenOffice/LibreOffice extension. So far so good. The problem is that this extension is only compatible with LibreOffice < 4 and if that was not enough it only works on i386 platforms. Thats why this Docker has been created to easily use this old but still useful software.

## How it works

It uses a self build Debian Wheezy i386 Docker base image and prepares it for the use with the Duden extension. On the first start the extension is installed.

## Building the base image

Checkout my [docker-makefile](https://github.com/ypid/docker-makefile) repository and `make build-debian-wheezy-i368-base-image`.

## Installing the extension

```Shell
make run
```

You might need to change the owner of the bind mounted directory `mount_volume_user_home` from your host system to match your user. Note that the UID must match with the user in the inside which is 1000.

```Shell
## In the container
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

## License

This project is distributed under [GNU Affero General Public License, Version 3][AGPLv3].
[AGPLv3]: https://github.com/jchaney/owncloud/blob/master/LICENSE
