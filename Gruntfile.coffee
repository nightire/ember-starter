module.exports = (grunt)->

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.config.init
    info: grunt.file.readJSON 'package.json'

    copy:
      assets:
        expand: true
        cwd: 'src'
        src: ['**/*', '!**/*.{scss,sass,js,coffee,handlebars,hbs}']
        dest: 'pub'

    watch:
      options:
        spawn: false
        livereload: true
        livereloadOnError: false
      assets:
        files: ['src/**/*', '!src/**/*.{scss,sass,js,coffee,handlebars,hbs}']
        tasks: ['copy:assets']

  grunt.registerTask 'default', []
