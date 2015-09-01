

You might need to change the owner of the bind mounted directory `mount_volume_user_home` from your host system to match your user. Note that the UID must match with the user in the inside which is 1000.

```Shell
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
