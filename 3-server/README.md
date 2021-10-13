Step 3 - Creating a simple web server
=====================================

To start things off we will build a basic web server that will serve a simple html file
on a desired localhost post.

We are going to need a few dependencies to do this, which we will add to [todo.cabal](todo.cabal):

* lucid: for html creation

* servant-server: to define our web application

* servant-lucid: to use our `lucid` html in `servant`

* warp: to run our web server

We also enable `DataKinds` as `servant` uses it, and `OverloadedStrigns` and
`TypeApplications` to make our code cleaner.

Next we move `src/Todo.hs` to [src/Todo/Web/Server.hs](src/Todo/Web/Server.hs) and define our
basic web server.

The pseudo-html `Lucid` code allows us to define the html we want to render in a
programmable way.

We then pass that code into `serve` along with a URL endpoint (in our case simply `/`) to
create our web application.

Finally we call `run` and specify a port to actually run that application.

The final change is then pointing [app/Main.hs](app/Main.hs) to our new module.
