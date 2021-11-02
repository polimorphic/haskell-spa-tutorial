Step 7 - Creating Beautiful UI Views
====================================

Great products begin with beautiful, simple interfaces.

Often this means we need to extend beyond the out of the box styling and fonts that comes with standard html elements.

We start by editing the [Server.hs](Server.hs) file by adding a few linked stylesheets from Google Fonts.

We then add the html elements we wish to style. The first list uses very basic techniques. Each element is written along with simple styling. We use flex boxes to get the checkbox and the descriptions side by side.

We create inline styles using a Map of CSS style attributes to values. As an example if I wanted to create a flex box that vertically aligns all elements, in HTML I would write:
```
<div style="display:flex,align-items:center"></div>
```

In our Miso EDSL we simply write this as:
```
div_ [style_ flexStyle] []

flexStyle :: Map MisoString MisoString
flexStyle =
    [ ("align-items", "center)
    , ("display", "flex")
    ]
```

Easy as pie!

What's nice about this! You can use these Maps/Lists as building blocks.

What if I wanted to create another div that also has element centered, but the font-size is smaller and has a bit of padding. I can now do:
```
div_ [style_ exampleStyle] []

exampleStyle :: Map MisoString MisoString
exampleStyle =
    [ ("font-size", "12px")
    , ("padding", "10px")
    ] <> flexStyle
```

Now the second todo list does a few more fancy things. You'll notice I created a data type I loop over. This is similar to the benefits a more sophisticated front-end framework like React has over vanilla HTML/CSS.

I create my list of entries as follows:
```
...
  where
    entries =
        [ (False, "Give local government it\'s biggest software update")
        , (True, "Start learning the codebase")
        , (True, "Interview for an open position")
        , (True, "Join Polimorphic!")
        , (False, "Build the virtual townhall!")
        ]
```

and now in my html block I can write what used to be:
```
... div_ [style_ todosStyle]
    [ div_ [style_ todoStyle]
        [ input_ [checked_ True, type_ "checkbox"]
        , p_ [style_ $ todoDescriptionStyle True]
            ["Interview for an open position"]
        ]
    ... (3 more entries)
    , div_ [style_ todoStyle]
        [ input_ [checked_ True, type_ "checkbox"]
        , p_ [style_ $ todoDescriptionStyle True]
            ["Start learning the codebase"]
        ]
    ]
...
```

into:
```
...
    div_ [style_ todosStyle] $ (entries) <&> \(active, description) ->
        div_ [style_ todoStyle]
            [ div_ [style_ $ checkStyle active] . pure $
                img_ [src_ checkUrl, style_ checkWhiteStyle]
            , p_ [style_ $ todoDescriptionStyle active] [text description]
            ]
...
```

Wow! Pretty neat. So these are the basics of it, but of course you can have ifs, thens, case statements all in your view. We'll see more of this as we explore `State.hs` files which let us have our data interface with our frontend.