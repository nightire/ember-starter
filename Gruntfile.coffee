module.exports = (grunt)->

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-newer'

  grunt.config.init
    info: grunt.file.readJSON 'package.json'

    copy:
      assets:
        expand: true
        cwd: 'src'
        src: ['**/*', '!**/*.{scss,sass,js,coffee,hbs}']
        dest: 'pub'
        filter: 'isFile'

    compass:
      compile:
        options:
          config: 'config.rb'

    coffee:
      compile:
        files:
          'pub/javascripts/application.js': [
            'src/coffee/**/*.coffee'
          ]
        options:
          bare: false
          sourceMap: true

    watch:
      options:
        spawn: false
        livereload: true
        livereloadOnError: false
      assets:
        files: ['src/**/*', '!src/**/*.{scss,sass,js,coffee,handlebars,hbs}']
        tasks: ['newer:copy:assets']
      styles:
        files: ['src/sass/**/*.{sass,scss}']
        tasks: ['compass:compile']
      script:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee:compile']

  grunt.registerTask 'default', ['watch']
