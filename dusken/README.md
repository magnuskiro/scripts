GitHub Markup
=============

We use this library on GitHub when rendering your README or any other
rich text file.

# Scripts created in association with Under Dusken. #

Markups
-------
ad

Installation
-----------

    gem install github-markup


Usage
-----

    require 'github/markup'
    GitHub::Markup.render('README.markdown', "* One\n* Two")

Or, more realistically:

    require 'github/markup'
    GitHub::Markup.render(file, File.read(file))


Testing
-------

To run the tests:


