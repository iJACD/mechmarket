# mechmarket
iOS app made to browse the subreddit r/mechmarket.

This app supports dark mode, for favored results use dark mode.

In order to run the app you will need to generate a client_id and 
client_secret by going to https://www.reddit.com/prefs/apps and creating an app.

Once you have these two string values you will create a file named "Secrets.swift"
and add it to the directory mechmarket/Constants/.

The Secrets object is an enum that should be structured as follows:
```
import Foundation
enum Secrets {
  case CLIENT_ID
  case CLIENT_SECRET
  var key: String {
    switch self {
    case .CLIENT_ID: return "Client-ID <-Your Client ID Here->"
    case .CLIENT_SECRET: return "<-Your Client Secret Here->"
    }
  }
}```

*Note: Be sure to prefix your client id with "Client-ID" followed by a space.

Lastly, build project and run.
