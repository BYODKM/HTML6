module.exports = (grunt)->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    clean:
      bower:
        src: ['bower_components']
      sprites:
        src: ['html6/sprites']
      tmp:
        src: ['.tmp/*']

    bower:
      install:
        options:
          copy: false

    copy:
      normalize:
        src: 'bower_components/normalize.css/normalize.css'
        dest: 'src/html6/styles/scaffolds/normalize.styl'
      nondestructiveReset:
        src: 'bower_components/nondestructive-reset.css/src/nondestructive-reset.styl'
        dest: 'src/html6/styles/scaffolds/nondestructive-reset.styl'
      nondestructiveResetJade:
        src: 'bower_components/nondestructive-reset.css/helper/nondestructive-reset.jade'
        dest: 'src/html6/elements/resets/nondestructive-reset.jade'
      legacyGradient:
        src: 'bower_components/legacy-gradient.styl/legacy-gradient.styl'
        dest: 'src/html6/styles/mixins/legacy-gradient.styl'
      globalize:
        src: 'bower_components/globalize.css/dist/globalize.styl'
        dest: 'src/html6/styles/utilities/globalize.styl'
      fastclick:
        src: 'bower_components/fastclick/lib/fastclick.js'
        dest: 'src/html6/scripts/vendors/fastclick.js'

    sprite:
      options:
        stamp: '<%= Math.floor(Date.now() / 1000) %>'
      at1x:
        src: 'src/html6/sprites/@1x/*.png'
        cssTemplate: 'src/html6/styles/sprites/1x.mustache'
        destCss: 'src/html6/styles/sprites/1x.styl'
        dest: '.tmp/html6/sprites/1x-<%= sprite.options.stamp %>.png'
        imgPath: '../sprites/1x-<%= sprite.options.stamp %>.png'
      at2x:
        src: 'src/html6/sprites/@2x/*.png'
        cssTemplate: 'src/html6/styles/sprites/2x.mustache'
        destCss: 'src/html6/styles/sprites/2x.styl'
        dest: '.tmp/html6/sprites/2x-<%= sprite.options.stamp %>.png'
        imgPath: '../sprites/2x-<%= sprite.options.stamp %>.png'

    imagemin:
      sprites:
        files: [
          expand: true,
          cwd: '.tmp/html6/sprites/',
          src: ['**/*.png'],
          dest: 'html6/sprites/'
          ]
      others:
        files: [
          expand: true,
          cwd: 'src/html6/images/',
          src: ['**/*.{png,jpg,gif}'],
          dest: 'html6/images/'
          ]

    stylus:
      options:
        compress: true
        use: [require('kouto-swiss')]
      compile:
        files: 'html6/styles/main.css': ['src/html6/styles/main.styl']

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
        files: 'html6/scripts/main.js': [
          'src/html6/scripts/polyfills/*.js',
          'src/html6/scripts/vendors/*.js',
          '.tmp/html6/scripts/elements/*.js'
          '.tmp/html6/scripts/onloads/*.js'
          '.tmp/html6/scripts/controllers/**/*.js'
          ]

    jade:
      options:
        pretty: false
        basedir: __dirname + '/src'
        data: (filepath)->
          return data:
            relativeRoot: filepath.replace(/[^\/]/g, '').replace(/\//g, '..\/')
      compile:
        expand: true
        cwd: 'src/'
        src: ['**/*.jade', '!html6/elements/**/*.jade', '!html6/partials/**/*.jade']
        dest: ''
        ext: '.html'

    connect:
      server:
        options:
          port: '3000'
          open:
            target: 'http://localhost:<%= connect.server.options.port %>/html6/tests/'

    watch:
      options:
        livereload: true
      stylus:
        files: ['src/**/*.styl']
        tasks: ['stylus']
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee', 'jshint', 'uglify', 'clean:tmp']
      jade:
        files: ['src/**/*.jade']
        tasks: ['jade']

  grunt.registerTask 'default', ['clone', 'image']
  grunt.registerTask 'clone', ['clean:bower', 'bower', 'copy']
  grunt.registerTask 'image', ['clean:sprites', 'sprite', 'imagemin', 'build']
  grunt.registerTask 'build', ['stylus', 'coffee', 'jshint', 'uglify', 'clean:tmp', 'jade', 'serve']
  grunt.registerTask 'serve', ['connect', 'watch']
