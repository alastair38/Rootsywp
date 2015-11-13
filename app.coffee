axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
dynamic_content = require 'dynamic-content'
records = require('roots-records')

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl'),
    dynamic_content(),
    records(
      posts:
        url: 'http://sandbox.alastaircox.com/wp-json/wp/v2/posts?_embed',
        template: "views/_post.jade",
        out: (post) -> "/post/#{(post.slug)}"
      pages:
        url: 'http://sandbox.alastaircox.com/wp-json/wp/v2/pages',
        template: "views/_post.jade",
        out: (post) -> "/#{(post.slug)}"
    )
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  server:
    clean_urls: true
