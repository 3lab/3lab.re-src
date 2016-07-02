3lab.re homepage
==============
### About
We are using [Middleman](https://middlemanapp.com/) to generate static HTML and CSS, however the site itself is written in **erb**, **Ruby** (and enhanced with couple of gems you can see in the **Gemfile**).

### Development, testing

1. You need Ruby (2.3.0 would be perfect.)
2. You need Bundler:
```
gem install bundler
```
3. You need to bundle.
```
bundle install
```
4. Then you can proceed to start Middleman server.
```
middleman server
```

### Building up (generating static files)
1. Everything from _Development, testing_ category is required.
2. Generate static files.
```
middleman build
```
3. Static files can be found in `build/` directory.

