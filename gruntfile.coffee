module.exports = (grunt)->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    clean:
      bower:
        src: ['bower_components']
      sprites:
        src: ['public_html/assets/sprites']
      tmp:
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
        stamp: '<%= Math.floor(Date.now() / 1000) %>'
      at1x:
        src: 'src/assets/sprites/@1x/*.png'
        cssTemplate: 'src/assets/styles/sprites/1x.mustache'
        destCss: 'src/assets/styles/sprites/1x.styl'
        dest: '.tmp/assets/sprites/1x-<%= sprite.options.stamp %>.png'
        imgPath: '../sprites/1x-<%= sprite.options.stamp %>.png'
      at2x:
        src: 'src/assets/sprites/@2x/*.png'
        cssTemplate: 'src/assets/styles/sprites/2x.mustache'
        destCss: 'src/assets/styles/sprites/2x.styl'
        dest: '.tmp/assets/sprites/2x-<%= sprite.options.stamp %>.png'
        imgPath: '../sprites/2x-<%= sprite.options.stamp %>.png'

    imagemin:
      sprites:
        files: [
          expand: true,
          cwd: '.tmp/assets/sprites/',
          src: ['**/*.png'],
          dest: 'public_html/assets/sprites/'
          ]
      others:
        files: [
          expand: true,
          cwd: 'src/assets/images/',
          src: ['**/*.{png,jpg,gif}'],
          dest: 'public_html/assets/images/'
          ]

    stylus:
      options:
        compress: true
        use: [require('kouto-swiss')]
      compile:
        files: 'public_html/assets/styles/main.css': ['src/assets/styles/main.styl']

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
        files: 'public_html/assets/scripts/main.js': [
          'src/assets/scripts/polyfills/*.js',
          'src/assets/scripts/vendors/*.js',
          '.tmp/assets/scripts/elements/*.js'
          '.tmp/assets/scripts/onloads/*.js'
          '.tmp/assets/scripts/controllers/**/*.js'
          ]

    jade:
      options:
        pretty: false
        basedir: __dirname + '/src'
        data: (filepath)->
          return data:
            relativeRoot: filepath.replace(/[^\/]/g, '').replace(/^\//, '').replace(/\//g, '..\/')
      compile:
        expand: true
        cwd: 'src/'
        src: ['**/*.jade', '!assets/elements/**/*.jade', '!assets/includes/**/*.jade']
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
        tasks: ['coffee', 'jshint', 'uglify', 'clean:tmp']
      jade:
        files: ['**/*.jade']
        tasks: ['jade']

  grunt.registerTask 'default', ['clone', 'image']
  grunt.registerTask 'clone', ['clean:bower', 'bower', 'copy']
  grunt.registerTask 'image', ['clean:sprites', 'sprite', 'imagemin', 'build']
  grunt.registerTask 'build', ['stylus', 'coffee', 'jshint', 'uglify', 'clean:tmp', 'jade', 'serve']
  grunt.registerTask 'serve', ['connect', 'watch']
