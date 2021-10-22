Step 6 - Building with GHCJS
============================

For deployment purposes we need to use GHCJS instead of jsaddle.

We start by editing the [nix](nix) directory and [default.nix](default.nix) as well as
adding [shell-ghcjs.nix](shell-ghcjs.nix), but we will again gloss over this for now.

We also break up our dependencies and modules into server/ghc-only and shared sections, so
that ghcjs doesn't have to build server-side code, particularly code that depends on C.

There is one package that we specify as ghcjs-only, and that is `ghcjs-base`. When compiled
with ghc, `jsaddle` will provide the same modules that it provides.

Next we replace `main :: IO ()` with `server :: Html () -> IO Application` in
[src/Todo/Web/Server.hs](src/Todo/Web/Server.hs) and remove the `jsaddleOr` and `jsaddleJs`.

We then create [src/Todo/Web/Server/JSaddle](src/Todo/Web/Server/JSaddle.hs) which calls
`server` and uses `jsaddleJs` and `jsaddleOr` to replicate the old behavior.

This allows us to then create [src/Todo/Web/Server/GHCJS.hs](src/Todo/Web/Server/GHCJS.hs)
which passes in a link to `/static/all.js` instead of the `jsaddleJs` and skips the
`jsaddleOr` part.

Now we make [app/Main.hs](app/Main.hs) to `Todo.Web.Server.GHCJS` as it's our proper
production app, and add [app/Dev.hs](app/Dev.hs) to point to `Todo.Web.Server.JSaddle`, as
well as [app/JS.hs](app/JS.hs) that points to `Todo.Web.Client` for ghcjs to compile.

Finally we reference these new apps in our [todo.cabal](todo.cabal) file, as well as flag
which ones we want to build with each compiler.

You can now run `result/bin/todo-dev` to run the previous jsaddle server+client binary,
or run `result/bin/todo` to run solely the server and serve the client via a js file. Note
that without a symlink you need to cd into `result` before running so that `static` is in
your current directory.
