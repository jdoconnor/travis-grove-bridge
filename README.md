travis-grove-bridge
===================

Service that will accept posts from Travis CI and post them to Grove.io

To Use
===================

Set a few environment variables
```
GROVE_POST_URI=<GET THIS FROM YOUR GROVE CHANNEL SETTINGS>
GROVE_SERVICE_NAME=<NAME THAT THE MESSAGES ARE POSTED AS IN IRC>

```

and optionally
```
SERVICE_NAME=travis-grove-bridge
GROVE_ICON_URL=<ICON OF THE GROVE USER>
```