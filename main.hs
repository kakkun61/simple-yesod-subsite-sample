{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import           HelloSub
import           Yesod

-- And let's create a master site that calls it.
data Master = Master
    { getHelloSub :: HelloSub
    }

mkYesod "Master" [parseRoutes|
/ HomeR GET
/subsite SubsiteR HelloSub getHelloSub
|]

instance Yesod Master

-- Spelling out type signature again.
getHomeR :: HandlerT Master IO Html
getHomeR = defaultLayout
    [whamlet|
        <h1>Welcome to the homepage
        <p>
            Feel free to visit the #
            <a href=@{SubsiteR SubHomeR}>subsite
            \ as well.
    |]

main = warp 3000 $ Master HelloSub
