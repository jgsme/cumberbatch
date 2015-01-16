gulp = require 'gulp'
jade = require 'gulp-jade'
conn = require 'gulp-connect'
deploy = require 'gulp-gh-pages'
browserify = require 'browserify'
source = require 'vinyl-source-stream'

paths =
  jade: 'src/*.jade'
  coffee: 'src/*.coffee'
  dest: 'build/'

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe jade()
    .pipe gulp.dest(paths.dest)

gulp.task 'browserify', ->
  browserify
    entries: ['./src/index.coffee']
    extensions: ['.coffee']
  .bundle()
  .pipe source('index.js')
  .pipe gulp.dest(paths.dest)

gulp.task 'default', ['jade', 'browserify']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.jade, ['jade']
  gulp.watch paths.coffee, ['browserify']
  conn.server
    root: 'build'

gulp.task 'deploy', ['default'], ->
  gulp.src './build/*'
    .pipe deploy
      cacheDir: 'tmp'
