module.exports = (grunt) ->

    require('load-grunt-tasks')(grunt)

    grunt.initConfig

        clean: ['public_html/assets/images/sprites/*.png', 'src/assets/images/sprites/*.png']

        sprite:
            options:
                timestamp: '<%= Math.floor(Date.now() / 1000 / 60) %>'
            standard:
                src: 'src/assets/images/sources/1x/*.png'
                destImg: 'src/assets/images/sprites/1x-<%= sprite.options.timestamp %>.png'
                destCSS: 'src/assets/styles/sprites/1x.styl'
                imgPath: '../images/sprites/1x-<%= sprite.options.timestamp %>.png'
                algorithm: 'binary-tree'
                cssTemplate: 'src/assets/styles/sprites/1x.mustache'
            retina:
                src: 'src/assets/images/sources/2x/*.png'
                destImg: 'src/assets/images/sprites/2x-<%= sprite.options.timestamp %>.png'
                destCSS: 'src/assets/styles/sprites/2x.styl'
                imgPath: '../images/sprites/2x-<%= sprite.options.timestamp %>.png'
                algorithm: 'binary-tree'
                cssTemplate: 'src/assets/styles/sprites/2x.mustache'

        image:
            dynamic:
                files: [
                    expand: true,
                    cwd: 'src/',
                    src: ['**/*.{png,jpg,gif,svg}', '!src/assets/images/sources/**/*.png'],
                    dest: 'public_html/'
                    ]

        coffee:
            compile:
                expand: true
                cwd: 'src/assets/scripts/src'
                src: ['**/*.coffee']
                dest: 'src/assets/scripts/build'
                ext: (ext)-> return ext.replace(/coffee$/, 'js')

        jshint:
            files: ['src/assets/scripts/build/**/*.js']

        min:
            mixins:
                src: ['src/assets/scripts/build/global/*.js', 'src/assets/scripts/build/onload/*.js']
                dest: 'public_html/assets/scripts/main.js'

        stylus:
            options:
                compress: true
            compile:
                files:
                    'public_html/assets/styles/main.css': ['src/assets/styles/main.styl']

        jade:
            options:
                data: (filepath)-> return filepath: filepath
                basedir: __dirname + '/src'
                pretty: true
            compile:
                expand: true
                cwd: 'src'
                src: ['**/*.jade', '!assets/**/*.jade']
                dest: 'public_html'
                ext: '.html'

        connect:
            open:
                options:
                    port: '3000'
                    useAvailablePort: true
                    base: 'public_html'

        watch:
            options:
                livereload: true
            default:
                files: ['src/**/*.jade', 'src/**/*.styl', 'src/**/*.coffee']
                tasks: ['clean', 'sprite', 'coffee', 'jshint', 'min', 'stylus', 'jade']

    grunt.registerTask 'build', ['clean', 'sprite', 'image', 'coffee', 'jshint', 'min', 'stylus', 'jade']
    grunt.registerTask 'server', ['clean', 'sprite', 'image', 'coffee', 'jshint', 'min', 'stylus', 'jade', 'connect', 'watch']
