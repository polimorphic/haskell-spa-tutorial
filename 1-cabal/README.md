Step 1 - Initial cabal setup
============================

We start by creating a [src](src) directory that will contain almost all of our code.

Within that directory we create [Todo.hs](src/Todo.hs) with a `main` function that simply
prints "todo" to the console and exits.

Next we create an [app](app) directory that will contain all our executables, which are
really just thin wrappers over functions we define in [src](src).

Within that directory we create [Main.hs](app/Main.hs) that simply imports `Todo` and
implicitly re-exports the `main` function.

Now we must fill out our [todo.cabal](todo.cabal) file and point it to these directories
and modules, so that `cabal` knows how to build our program.

You should be able to run this project with `cabal new-run` if you have the right
version of ghc installed (8.6), but if you don't you may just want to skip to the next
step, where we manage compiler versions more directly.

You can also interact with the program in `cabal new-repl` instead, since our important
code is in the library section, and thus visible to the repl.
