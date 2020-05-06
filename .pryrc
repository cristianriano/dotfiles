### General
Pry.editor = ENV['VISUAL'] || 'vim'

### Listing
Pry.config.ls.separator = " "
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :blue
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :red