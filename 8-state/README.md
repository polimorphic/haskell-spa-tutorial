Step 8 - More Than Just a View
====================================

Our View already tells our data model that we have a list of checkboxes. Now when we interact with it we need it to tell us when a box has been checked or unchecked. This is where State comes in. 

We need to do a few things with our State to accomplish this. 
1. Need to initialize a State
    i. We do this by setting a variable, `window.state`, in [src/Todo/Web/Server.hs](src/Todo/Web/Server.hs). When we edit things this state will update
    ii. Create a `mkState` method in [src/Todo/Web/Types.hs](src/Todo/Web/Types.hs) to initialize the values. 
2. Need to have the ability to use the State for rendering 
    i. We use the `Control.Lens` library to automatically have getters and setters, which we can do be calling the `makeLenses` function in [src/Todo/Web/Types.hs](src/Todo/Web/Types.hs). 
    ii. In [src/Todo/Web/View.hs](src/Todo/Web/View.hs), use these getters and interface them with the HTML we are writing. In the example below, we use `itoList` to loop through the list we retrieve from the `sTodos` via the `^.` with an index.
    ```
    div_ [style_ todosStyle] $ itoList (s ^. sTodos) <&> \(i, (active, description)) -> div_
        [style_ todoStyle]
        [ ... 
        , p_ [style_ $ todoDescriptionStyle active] [text description]
        ]
    ```
3. Need to have the ability to modify the State. 
    i. We can create a handler, [src/Todo/Web/Handler.hs](src/Todo/Web/Handler.hs), in which we define the actions `Modify` and `NoOp`. We could also define more complicated actions in our handler that then use some combination of the `Modify` and `NoOp` functions.
        a. `Modify` function takes in a function and modifies the state (type state -> state)
        b. `NoOp` -> returns you the state
    ii. We can then use the `Modify` action to update our state from [src/Todo/Web/View.hs](src/Todo/Web/View.hs). For example, in the following code: 
    `[ input_ [type_ "number", onInput $ \x -> Modify $ sInventory . ix i ._1 .~ fromMaybe 0 (readMaybe $ fromMisoString x)] `
    We take the input value and use it to update the data stored in `sInventory`. Along the way we must adjust the types to be able to use the proper functions, for example the `value` is of type MisoString, so we must call `fromMisoString` to use the `readMaybe` function. The `readMaybe` function allows us to access the Int value of the String x, if it exists. 
    
