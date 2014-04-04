require 'susy'

environment = :development

sass_dir = 'src/sass'
relative_assets = true
preferred_syntax = :scss
output_style = (environment == :production) ? :compressed : :expanded

css_dir = 'pub/stylesheets'
http_stylesheets_path = '/stylesheets'

javascripts_dir = 'pub/javascripts'
http_javascripts_path = '/javascripts'

images_dir = 'src/images'
http_images_path = '/images'

fonts_dir = 'src/fonts'
http_fonts_path = '/fonts'
