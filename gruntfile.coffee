module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    clean:
      bower:
        src: ['bower_components']
      before:
        src: ['public_html/assets/images/sprites']
      after:
        src: ['.tmp/*']

    bower:
      install:
        options:
          copy: false

    copy:
      normalize:
        src: 'bower_components/normalize.css/normalize.css'
        dest: 'src/assets/styles/scaffolds/normalize.styl'
      nondestructiveReset:
        src: 'bower_components/nondestructive-reset.css/src/nondestructive-reset.styl'
        dest: 'src/assets/styles/scaffolds/nondestructive-reset.styl'
      nondestructiveResetJade:
        src: 'bower_components/nondestructive-reset.css/helper/nondestructive-reset.jade'
        dest: 'src/assets/elements/resets/nondestructive-reset.jade'
      legacyGradient:
        src: 'bower_components/legacy-gradient.styl/legacy-gradient.styl'
        dest: 'src/assets/styles/mixins/legacy-gradient.styl'
      globalize:
        src: 'bower_components/globalize.css/dist/globalize.styl'
        dest: 'src/assets/styles/utilities/globalize.styl'
      fastclick:
        src: 'bower_components/fastclick/lib/fastclick.js'
        dest: 'src/assets/scripts/vendors/fastclick.js'

    sprite:
      options:
        stamp: '<%= Math.floor(Date.now() / 1000 / 60) %>'
      normal:
        src: 'src/assets/images/sprites/1x/*.png'
        cssTemplate: 'src/assets/styles/sprites/1x.mustache'
        algorithm: 'binary-tree'
        destCSS: 'src/assets/styles/sprites/1x.styl'
        destImg: '.tmp/assets/images/sprites/1x-<%= sprite.options.stamp %>.png'
        imgPath: '../images/sprites/1x-<%= sprite.options.stamp %>.png'
      retina:
        src: 'src/assets/images/sprites/2x/*.png'
        cssTemplate: 'src/assets/styles/sprites/2x.mustache'
        algorithm: 'binary-tree'
        destCSS: 'src/assets/styles/sprites/2x.styl'
        destImg: '.tmp/assets/images/sprites/2x-<%= sprite.options.stamp %>.png'
        imgPath: '../images/sprites/2x-<%= sprite.options.stamp %>.png'

    image:
      sprites:
        files: [
          expand: true,
          cwd: '.tmp/assets/images/sprites/',
          src: ['*.png'],
          dest: 'public_html/assets/images/sprites/'
          ]
      others:
        files: [
          expand: true,
          cwd: 'src/assets/images/others/',
          src: ['**/*.{png,jpg,gif,svg}'],
          dest: 'public_html/assets/images/others/'
          ]

    stylus:
      options:
        compress: true
      compile:
        files:
          'public_html/assets/styles/main.css': ['src/assets/styles/main.styl']

    coffee:
      compile:
        expand: true
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: '.tmp/'
        ext: (ext)-> return ext.replace(/coffee$/, 'js')

    jshint:
      files: ['.tmp/**/*.js']

    uglify:
      options:
        mangle: true
        compress: true
        beautify: false
      main:
        files: 'public_html/assets/scripts/main.js' : [
          'src/assets/scripts/vendors/*.js',
          '.tmp/assets/scripts/coffee/*.js'
          ]
      controllers:
        files: [
          expand: true,
          cwd: '.tmp/',
          src: ['**/*.js', '!assets/**/*.js'],
          dest: 'public_html/'
          ]

    jade:
      options:
        data: (filepath)-> return filepath: filepath
        basedir: __dirname + '/src'
        pretty: false
      html:
        expand: true
        cwd: 'src/'
        src: ['**/*.jade', '!assets/**/*.jade']
        dest: 'public_html/'
        ext: '.html'

    connect:
      server:
        options:
          port: '3000'
          base: 'public_html/'
          open:
            target: 'http://localhost:<%= connect.server.options.port %>'

    watch:
      options:
        livereload: true
      stylus:
        files: ['**/*.styl']
        tasks: ['stylus']
      coffee:
        files: ['**/*.coffee']
        tasks: ['coffee', 'jshint', 'uglify', 'clean:after']
      jade:
        files: ['**/*.jade']
        tasks: ['jade']

  grunt.registerTask 'clone', ['clean:bower', 'bower', 'copy']

  grunt.registerTask 'build', [
    'clean:before',
    'sprite', 'image',
    'stylus',
    'coffee', 'jshint', 'uglify',
    'jade',
    'clean:after'
    ]

  grunt.registerTask 'serve', ['connect', 'watch']
