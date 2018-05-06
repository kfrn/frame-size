# [frame size](https://kfrn.github.io/frame-size/)

Want an easy way to get a video frame size for a specific aspect ratio? Look no further than this calculator!

This is just something I made for fun - mainly to practice getting CSS transitions to work in Elm.

**frame size** is a sister project to my other projects [**reel time**](https://kfrn.github.io/reel-time) and [**film figures**](https://kfrn.github.io/film-figures).

Suggestions and contributions are welcome! I'm happy to receive feature requests, bug reports, code changes, general comments, etc. You can submit a github issue (or pull request), or [email me](mailto:kfnagels@gmail.com) directly.

### Local setup

Dependencies:
* [Elm](https://guide.elm-lang.org/install.html)
* [Node](https://nodejs.org/en/download/)

To run locally:
```
git clone git@github.com:kfrn/frame-size.git
cd frame-size/
elm-package install
npm install -g create-elm-app
elm-app start
```

To run tests:
```
elm-app test
```

<!-- To deploy to github pages:
```
elm-app build
gh-pages -d build
``` -->

### Acknowledgements

This web app was scaffolded using [`create-elm-app`](https://www.npmjs.com/package/create-elm-app) and styled with assistance from [Bulma](https://bulma.io/).
