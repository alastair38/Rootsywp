axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
dynamic_content = require 'dynamic-content'
records = require('roots-records')
roots_config = require('roots-config')

api_url = 'http://sandbox.alastaircox.com'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    dynamic_content(),
    roots_config(
      api_url: api_url,
      static_items: 3,
      site_name: 'Rootsy WP',
      site_description: 'DESCRIPTION OF YOUR SITE FOR SEARCH ENGINES',
      site_owner: 'Alastair Cox',
      site_email: 'alastair@alastaircox.com',
      site_twitter: 'dementiaMap'
    ),
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl'),
    records(
      posts:
        url: api_url + '/wp-json/wp/v2/posts?_embed',
        template: "views/_post.jade",
        out: (post) -> "/post/#{(post.slug)}"
      pages:
        url: api_url + '/wp-json/wp/v2/pages',
        template: "views/_page.jade",
        out: (post) -> "/#{(post.slug)}"
      tags:
        url: api_url + '/wp-json/wp/v2/terms/tag?per_page=25',
        template: "views/_tags.jade",
        out: (post) -> "/tag/#{(post.slug)}"
      users:
        url: api_url + '/wp-json/wp/v2/users',
        template: "views/_users.jade",
        out: (post) -> "/user/#{(post.slug)}"
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
