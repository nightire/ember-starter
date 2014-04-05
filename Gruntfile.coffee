module.exports = (grunt)->

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-ember-templates'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-karma'
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

    emberTemplates:
      compile:
        files:
          'pub/javascripts/template.js': 'src/template/**/*.hbs'
        options:
          precompile: false
          templateBasePath: 'src/template'

    karma:
      options:
        configFile: 'karma.conf.js'
      test:
        background: true
        singleRun: false
      continuous:
        reporters: 'progress'

    watch:
      options:
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
      template:
        files: ['src/template/**/*.hbs']
        tasks: ['emberTemplates:compile']
      test:
        files: ['pub/javascripts/**/*.js', 'test/**/*{.spec,_spec,Spec}.js']
        tasks: ['karma:test:run']

  grunt.registerTask 'default', ['karma:test:start', 'watch']
