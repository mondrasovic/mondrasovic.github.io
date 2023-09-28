# Jekyll static website for a personal blog

## Setting up the site

Install **jekyll**:
```
sudo apt-get -y install ruby-full build-essential make
```

Install **bundler**:
```
sudo gem install jekyll bundler
```

Installing the necessary packages, run
```
bundle install
```
in the project root directory where `Gemfile` is located.

## MathJax

To enable the **MathJax**, add
```
# Build settings
markdown: kramdown
```
to the `_config.yml` file.

Then, add
```
usemathjax: true
```
to each post where the **MathJax** should be enabled.

## Useful commands

Shows the path where the **minima** theme is installed.
```
bundle info --path minima
```

Serving the application.
```
bundle exec jekyll serve
```

Serving the application with on-the-fly reloading turned on.
```
bundle exec jekyll serve --livereload
```

When serving the site inside a Docker image, specifying the host network is useful, i.e.:
```
bundle exec jekyll serve --host 0.0.0.0 --livereload
```