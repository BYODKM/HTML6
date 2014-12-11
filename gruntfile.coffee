module.exports = (grunt) ->

    require('load-grunt-tasks')(grunt)

    grunt.initConfig

        clean:
            pre:
                src: ['dist/assets/images/sprites']
            post:
                src: ['.tmp/*']

        bower:
            install:
                options:
                    copy: false

        copy:
            normalize:
                src: 'bower_components/normalize.css/normalize.css'
                dest: 'src/assets/styles/scaffolds/normalize.styl'

        sprite:
            options:
                timestamp: '<%= Math.floor(Date.now() / 1000 / 60) %>'
            legacy:
                src: 'src/assets/images/sprites/1x/*.png'
                destImg: '.tmp/assets/images/sprites/1x-<%= sprite.options.timestamp %>.png'
                destCSS: 'src/assets/styles/sprites/1x.styl'
                cssTemplate: 'src/assets/styles/sprites/1x.mustache'
                imgPath: '../images/sprites/1x-<%= sprite.options.timestamp %>.png'
                algorithm: 'binary-tree'
            retina:
                src: 'src/assets/images/sprites/2x/*.png'
                destImg: '.tmp/assets/images/sprites/2x-<%= sprite.options.timestamp %>.png'
                destCSS: 'src/assets/styles/sprites/2x.styl'
                cssTemplate: 'src/assets/styles/sprites/2x.mustache'
                imgPath: '../images/sprites/2x-<%= sprite.options.timestamp %>.png'
                algorithm: 'binary-tree'

        image:
            sprites:
                files: [
                    expand: true,
                    cwd: '.tmp/assets/images/sprites/',
                    src: ['*.png'],
                    dest: 'dist/assets/images/sprites/'
                    ]
            others:
                files: [
                    expand: true,
                    cwd: 'src/assets/images/others/',
                    src: ['**/*.{png,jpg,gif,svg}'],
                    dest: 'dist/assets/images/others/'
                    ]

        stylus:
            compile:
                files:
                    'dist/assets/styles/main.css': ['src/assets/styles/main.styl']

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
            assets:
                files: 'dist/assets/scripts/main.js' : ['.tmp/assets/scripts/coffee/global/*.js', '.tmp/assets/scripts/coffee/ready/*.js']
            controllers:
                files: [
                    expand: true,
                    cwd: '.tmp/',
                    src: ['**/*.js', '!assets/**/*.js'],
                    dest: 'dist/'
                    ]

        jade:
            options:
                data: (filepath)-> return filepath: filepath
                basedir: __dirname + '/src'
                pretty: true
            compile:
                expand: true
                cwd: 'src/'
                src: ['**/*.jade', '!assets/**/*.jade']
                dest: 'dist/'
                ext: '.html'

        connect:
            server:
                options:
                    port: '3000'
                    base: 'dist/'

        watch:
            options:
                livereload: true
            default:
                files: ['**/*.jade', '**/*.styl', '**/*.coffee']
                tasks: ['stylus', 'coffee', 'jshint', 'uglify', 'jade', 'clean:post']

    grunt.registerTask 'serve', ['connect', 'watch']
    grunt.registerTask 'build', ['clean:pre', 'bower', 'copy', 'sprite', 'image', 'stylus', 'coffee', 'jshint', 'uglify', 'jade', 'clean:post']
