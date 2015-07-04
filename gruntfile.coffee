module.exports = (grunt)->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    clean:
      bower:
        src: ['bower_components']
      sprites:
        src: ['html6/images/_sprites/*.png']
      tmp:
        src: ['.tmp/*']

    bower:
      install:
        options:
          copy: false

    copy:
      normalize:
        src: 'bower_components/normalize.css/normalize.css'
        dest: 'html6/styles/scaffolds/normalize.styl'
      nondestructiveReset:
        src: 'bower_components/nondestructive-reset.css/src/nondestructive-reset.styl'
        dest: 'html6/styles/scaffolds/nondestructive-reset.styl'
      nondestructiveResetJade:
        src: 'bower_components/nondestructive-reset.css/helper/nondestructive-reset.jade'
        dest: 'html6/elements/resets/nondestructive-reset.jade'
      legacyGradient:
        src: 'bower_components/legacy-gradient.styl/legacy-gradient.styl'
        dest: 'html6/styles/mixins/legacy-gradient.styl'
      globalize:
        src: 'bower_components/globalize.css/dist/globalize.styl'
        dest: 'html6/styles/utilities/globalize.styl'
      fastclick:
        src: 'bower_components/fastclick/lib/fastclick.js'
        dest: 'html6/scripts/vendors/fastclick.js'

    sprite:
      options:
        stamp: '<%= Math.floor(Date.now() / 1000) %>'
      at1x:
        src: 'html6/images/_sprites/@1x/*.png'
        dest: '.tmp/html6/images/_sprites/1x-<%= sprite.options.stamp %>.png'
        cssTemplate: 'html6/styles/sprites/1x.mustache'
        destCss: 'html6/styles/sprites/1x.styl'
        imgPath: '../images/_sprites/1x-<%= sprite.options.stamp %>.png'
      at2x:
        src: 'html6/images/_sprites/@2x/*.png'
        dest: '.tmp/html6/images/_sprites/2x-<%= sprite.options.stamp %>.png'
        cssTemplate: 'html6/styles/sprites/2x.mustache'
        destCss: 'html6/styles/sprites/2x.styl'
        imgPath: '../images/_sprites/2x-<%= sprite.options.stamp %>.png'

    imagemin:
      sprites:
        files: [
          expand: true,
          cwd: '.tmp/html6/images/_sprites/',
          src: ['**/*.png'],
          dest: 'html6/images/_sprites/'
          ]
      others:
        files: [
          expand: true,
          cwd: 'html6/images/_uncompressed/',
          src: ['**/*.{png, gif, jpg, jpeg}'],
          dest: 'html6/images/'
          ]

    stylus:
      options:
        compress: true
        use: [require('kouto-swiss')]
      compile:
        files: 'html6/styles/main.css': ['html6/styles/main.styl']

    coffee:
      compile:
        expand: true
        src: [
          '**/*.coffee',
          '!bower_components/**/*.coffee'
          '!node_modules/**/*.coffee'
          ]
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
          'html6/scripts/polyfills/*.js'
          'html6/scripts/vendors/*.js'
          '.tmp/html6/scripts/elements/*.js'
          '.tmp/html6/scripts/onloads/*.js'
          '.tmp/html6/scripts/controllers/**/*.js'
          ]

    jade:
      options:
        pretty: false
        basedir: __dirname
        data: (filepath)->
          return data:
            relativeRoot: filepath.replace(/[^\/]/g, '').replace(/\//g, '..\/')
      compile:
        expand: true
        src: [
          '**/*.jade',
          '!bower_components/**/*.jade'
          '!html6/elements/**/*.jade'
          '!node_modules/**/*.jade'
          ]
        ext: '.html'

    connect:
      server:
        options:
          port: '3000'
          open:
            target: 'http://localhost:<%= connect.server.options.port %>'

    watch:
      options:
        livereload: true
      stylus:
        tasks: ['stylus']
        files: ['html6/**/*.styl']
      coffee:
        tasks: ['coffee', 'jshint', 'uglify', 'clean:tmp']
        files: ['html6/**/*.coffee']
      jade:
        tasks: ['jade']
        files: ['**/*.jade', '!bower_components/**/*.jade', '!node_modules/**/*.jade']

  grunt.registerTask 'default', ['install', 'image']
  grunt.registerTask 'install', ['clean:bower', 'bower', 'copy']
  grunt.registerTask 'image', ['clean:sprites', 'sprite', 'imagemin', 'build']
  grunt.registerTask 'build', ['stylus', 'coffee', 'jshint', 'uglify', 'clean:tmp', 'jade', 'serve']
  grunt.registerTask 'serve', ['connect', 'watch']
