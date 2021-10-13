Step 2 - Initial nix setup
==========================

We want to tightly and safely manage our compilers and packages and ensure reliable builds,
so we use nix as our package manager.

This is particularly important due to our need to use both ghc and ghcjs simultaneously,
as well as non-haskell tools like the closure compiler.

We add a variety of files in the [nix](nix) directory, as well as [default.nix](default.nix)
and [shell.nix](shell.nix), in order to give nix everything it needs to build our project.

You can now build this project by installing `nix` and running `nix-build`, and the binary
will be outputted at `result/bin/todo`.

You can alternatively run `nix-shell` to be put into a shell with all the required
dependencies, so you can run `cabal` commands like before without worrying about ghc
versions.

You can just copy this setup and replace instances of `todo` with your own project name
without having to understand it too deeply.

However in future more information will be added for those that need or want to know.
