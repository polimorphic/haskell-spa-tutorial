module Todo.Web.State
    ( Action(..)
    , State(..)
    , sTodos
    , mkState
    ) where

import Control.Lens
import Data.Aeson
import GHC.Generics (Generic)
import Miso.String

type Todo = (Bool, MisoString)

data Action
    = Modify (State -> State)
    | NoOp

data State = State
    { _sTodos :: [Todo]
    } deriving (Eq, Generic, FromJSON, ToJSON)

makeLenses ''State

mkState :: State
mkState = State
    { _sTodos =
        [ (False, "Give local government it\'s biggest software update")
        , (True, "Start learning the codebase")
        , (True, "Interview for an open position")
        , (True, "Join Polimorphic!")
        , (False, "Build the virtual townhall!")
        ]
    }