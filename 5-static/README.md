Step 5 - Serving static files
=============================

Any good web server needs to be able to serve some static files. In our case we'll
start with a simple css reset.

We need to add `DeriveGeneric` and `TypeOperators` to [todo.cabal](todo.cabal) as `servant`
uses them to specify multiple routes with different paths, which we'll need for a separate
static path.

This functionality is exported from `servant` directly, and not re-exported from
`servant-server`, so we add it as a dependency in [todo.cabal](todo.cabal).

We then also need to add `text` and `hashable` as dependencies so we can hash our css file
and append the hash to the url, for automatic cache busting.

Next we create our [static/base.css](static/base.css) file and fill it in with a simple css
reset.

Now we edit [src/Todo/Web/Server.hs](src/Todo/Web/Server.hs) to expose this static directory
from `/static`.

We do this by adding an `Api` type that contains a new `"static" :> Raw` endpoint which is then
followed by our existing `Urls` type.

This then requires us to split out our server into a `mainServer` which is similar to our
existing server, just with an additional css link and hash parameter, as well as a static
directory server using the helper function provided by servant-server.

We can then combine these two with `genericServe` by filling our `Api` type with the appropriate
servers, after we calculate the base.css file hash and pass it into our `mainServer`.
