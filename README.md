# System Extension Demo
This is a small test app that configures a system network extension on MacOS.

There are many gotchas when creating a System Extension. For example, you need to use Developer ID to distribute outside and App Store *and* you need to notarize your app (create an archive and notarize it), or the signature will be considered invalid. The documentation for things like that is basically non-existent.
