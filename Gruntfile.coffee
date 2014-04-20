module.exports = (grunt)->

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-bowercopy'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-ember-templates'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-newer'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.config.init
    info: grunt.file.readJSON 'package.json'

    copy:
      assets:
        expand: true
        cwd: 'src'
        src: ['**/*', '!**/*.{scss,sass,js,coffee,hbs}']
        dest: 'pub'
        filter: 'isFile'

    bowercopy:
      options:
        destPrefix: 'pub/javascripts/vendor'
      vendor:
        files:
          'jquery/jquery.js': 'jquery/dist/jquery.js'
          'handlebars/handlebars.js': 'handlebars/handlebars.js'
          'ember/ember.js': 'ember/ember.js'
          'ember-data/ember-data.js': 'ember-data/ember-data.js'

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
      vendor:
        files: ['bower_components/**/*']
        tasks: ['newer:bowercopy:vendor']
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
        files: ['pub/javascripts/**/*.js', 'test/**/*.{coffee,js}']
        tasks: ['karma:test:run']
        options:
          livereload: false

    connect:
      server:
        options:
          base: 'pub'
          port: 1234
          hostname: '0.0.0.0'
          open: true
          livereload: true

  grunt.registerTask 'default', ['karma:test:start', 'connect', 'watch']
