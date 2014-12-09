module.exports = (grunt) ->

    require('load-grunt-tasks')(grunt)

    grunt.initConfig

        clean:
            pre:
                src: ['dist/assets/images/sprites']
            post:
                src: ['.tmp/assets']

        sprite:
            options:
                timestamp: '<%= Math.floor(Date.now() / 1000 / 60) %>'
            legacy:
                src: 'src/assets/images/sprites/1x/*.png'
                destImg: '.tmp/assets/images/sprites/1x-<%= sprite.options.timestamp %>.png'
                destCSS: 'src/assets/styles/bases/sprites/1x.styl'
                cssTemplate: 'src/assets/styles/bases/sprites/1x.mustache'
                imgPath: '../images/sprites/1x-<%= sprite.options.timestamp %>.png'
                algorithm: 'binary-tree'
            retina:
                src: 'src/assets/images/sprites/2x/*.png'
                destImg: '.tmp/assets/images/sprites/2x-<%= sprite.options.timestamp %>.png'
                destCSS: 'src/assets/styles/bases/sprites/2x.styl'
                cssTemplate: 'src/assets/styles/bases/sprites/2x.mustache'
                imgPath: '../images/sprites/2x-<%= sprite.options.timestamp %>.png'
                algorithm: 'binary-tree'

        image:
            sprites:
                files: [
                    expand: true,
                    cwd: '.tmp/assets/images/sprites/',
                    src: ['**/*.png'],
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
                cwd: 'src/assets/scripts/coffee/'
                src: ['**/*.coffee']
                dest: '.tmp/assets/scripts/coffee/'
                ext: (ext)-> return ext.replace(/coffee$/, 'js')

        jshint:
            files: ['.tmp/assets/scripts/coffee/**/*.js']

        min:
            scripts:
                src: ['.tmp/assets/scripts/coffee/global/*.js', '.tmp/assets/scripts/coffee/ready/*.js']
                dest: 'dist/assets/scripts/main.js'

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
                tasks: ['stylus', 'coffee', 'jshint', 'min', 'jade', 'clean:post']

    grunt.registerTask 'default', ['connect', 'watch']
    grunt.registerTask 'build', ['clean:pre', 'sprite', 'image', 'stylus', 'coffee', 'jshint', 'min', 'jade', 'clean:post']
