Step 4 - Creating a simple web client
=====================================

Now that we have a working server, we need to also create a web client.

We are again going to need a few more dependencies to do this, as before added to
[todo.cabal](todo.cabal):

* jsaddle: javascript EDSL that works with both GHC and GHCJS

* jsaddle-warp: connects to the browser to run GHC-compiled frontend code

* miso: our frontend web framework

* websockets: `jsaddle-warp` interacts with the browser using websockets

We then create [src/Todo/Web/View.hs](src/Todo/Web/View.hs) and define our view, for now
a simple view that just prints "Todo", that will be used by both the server and the client.

Now we create our [src/Todo/Web/Client.hs](src/Todo/Web/Client.hs) client file, and fill
out a minimal miso `App` object that uses our `view`.

Finally we adjust our [src/Todo/Web/Server.hs](src/Todo/Web/Server.hs) file to weave in
the client.
