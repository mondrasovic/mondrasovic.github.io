# Jekyll static website for a personal blog

## Setting up the site

Install **jekyll**:
```
apt-get -y install ruby-full build-essential make
```

Install **bundler**:
```
gem install jekyll bundler
```

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