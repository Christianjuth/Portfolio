module.exports = (grunt)->
  # Load all Grunt tasks
  require("load-grunt-tasks")(grunt)

  # Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON("package.json")
    watch:
      default:
        files: ["resources/sass/**/*.scss", "resources/coffee/**/*.coffee"]
        tasks: ["sass", "coffee"]
        options:
          event: ["added", "changed"]
    sass:
      default:
        files:
          "public/css/style.css": "resources/sass/style.scss"
          "public/css/open-graph.css": "resources/sass/open-graph.scss"
    coffee:
      options:
        sourceMap: true
      default:
        files: [
          expand: true
          cwd: "resources/coffee"
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
    compress:
      main:
        options:
          mode: "gzip"
        files: [
          {expand: true, src: ["**/*.js"], cwd: "public/js", dest: "public/js", ext: ".js.gz"}
          {expand: true, src: ["**/*.css"], cwd: "public/css", dest: "public/css", ext: ".css.gz"}
        ]
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
    clean: ["public/css/**/*.map", "public/js/**/*.map"]
  })

  # Default task(s).
  grunt.registerTask("default", ["sass", "coffee", "watch"])
  grunt.registerTask("once", ["sass", "coffee"])
  grunt.registerTask("production", ["sass", "coffee", "uglify", "imagemin", "compress", "clean"])