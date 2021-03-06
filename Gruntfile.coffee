module.exports = (grunt)->
  # Time Grunt tasks
  require("time-grunt")(grunt)

  # Load all Grunt tasks
  require("load-grunt-tasks")(grunt)

  # Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON("package.json")
    watch:
      default:
        files: ["public/sass/**/*.scss", "public/coffee/**/*.coffee"]
        tasks: ["sass", "coffee"]
        options:
          event: ["added", "changed"]
    sass:
      default:
        files:
          "public/css/style.css": "public/sass/style.scss"
          "public/css/portfolio.css": "public/sass/portfolio.scss"
          "public/css/open-graph.css": "public/sass/open-graph.scss"
    coffee:
      options:
        sourceMap: true
      default:
        files: [
          expand: true
          cwd: "public/coffee"
          src: ["**/*.coffee"]
          dest: "public/js"
          ext: ".js"
        ]
    uglify:
      files:
        expand: true
        cwd: "public/js"
        src: "**/*.js"
        dest: "public/js"
    imagemin:
      options:
        optimizationLevel: 7
      dynamic:
        files: [
          expand: true
          cwd: "public/images/"
          src: ["**/*.{png,jpg,gif}"]
          dest: "public/images/"
        ]
    clean: []
  })

  # Default task(s).
  grunt.registerTask("default", ["sass", "coffee", "watch"])
  grunt.registerTask("once", ["sass", "coffee"])
  grunt.registerTask("production", ["sass", "coffee", "uglify"])
  grunt.registerTask("optimize", ["imagemin"])