module.exports = (grunt) ->

    require('load-grunt-tasks')(grunt)

    grunt.initConfig

        clean:
            before:
                src: ['bower_components', 'public_html/assets/images/sprites']
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
            fastclick:
                src: 'bower_components/fastclick/lib/fastclick.js'
                dest: 'src/assets/scripts/vendors/fastclick.js'
            webkitGradient:
                src: 'bower_components/webkit-gradient.styl/src/webkit-gradient.styl'
                dest: 'src/assets/styles/mixins/webkit-gradient.styl'

        sprite:
            options:
                stamp: '<%= Math.floor(Date.now() / 1000 / 60) %>'
            normal:
                src: 'src/assets/images/sprites/1x/*.png'
                destImg: '.tmp/assets/images/sprites/1x-<%= sprite.options.stamp %>.png'
                destCSS: 'src/assets/styles/sprites/1x.styl'
                cssTemplate: 'src/assets/styles/sprites/1x.mustache'
                imgPath: '../images/sprites/1x-<%= sprite.options.stamp %>.png'
                algorithm: 'binary-tree'
            retina:
                src: 'src/assets/images/sprites/2x/*.png'
                destImg: '.tmp/assets/images/sprites/2x-<%= sprite.options.stamp %>.png'
                destCSS: 'src/assets/styles/sprites/2x.styl'
                cssTemplate: 'src/assets/styles/sprites/2x.mustache'
                imgPath: '../images/sprites/2x-<%= sprite.options.stamp %>.png'
                algorithm: 'binary-tree'

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

    grunt.registerTask 'build', [
        'clean:before',
        'bower', 'copy',
        'sprite', 'image',
        'stylus',
        'coffee', 'jshint', 'uglify',
        'jade',
        'clean:after'
        ]

    grunt.registerTask 'serve', ['connect', 'watch']
