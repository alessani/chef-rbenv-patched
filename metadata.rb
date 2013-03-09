maintainer       "Extendi"
maintainer_email "alessani@gmail.com"
license          "All rights reserved"
description      "Installs/Configures rbenv and ruby_build"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

recipe "rubymachine", "Install ruby with rbenv and ruby_build"

depends 'rbenv'
