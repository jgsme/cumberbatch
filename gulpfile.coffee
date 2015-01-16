gulp       = require 'gulp'
jade       = require 'gulp-jade'
conn       = require 'gulp-connect'
deploy     = require 'gulp-gh-pages'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
uglify     = require 'gulp-uglify'
run        = require 'run-sequence'

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

gulp.task 'compact', ->
  gulp.src 'build/index.js'
    .pipe uglify()
    .pipe gulp.dest(paths.dest)

gulp.task 'CNAME', ->
  gulp.src 'src/CNAME'
    .pipe gulp.dest(paths.dest)

gulp.task 'default', ['jade', 'browserify']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.jade, ['jade']
  gulp.watch paths.coffee, ['browserify']
  conn.server
    root: 'build'

gulp.task 'deploy', (callback)-> run ['default', 'CNAME'], 'compact', 'deploy-main', callback
gulp.task 'deploy-main', ->
  gulp.src './build/*'
    .pipe deploy
      cacheDir: 'tmp'
