# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

# With alternative layout
# page "/path/to/file.html", layout: "other_layout"

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   "/this-page-has-no-template.html",
#   "/template-file.html",
#   locals: {
#     which_fake_page: "Rendering a fake page with a local variable"
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end

activate :directory_indexes

activate :external_pipeline,
  name: :webpack,
  command: build? ? "yarn run build" : "yarn run start",
  source: ".tmp/dist",
  latency: 1

set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "images"

proxy "index.html", "/remember-lost-species/dodo.html"

activate :deploy do |deploy|
  deploy.deploy_method = :rsync
  deploy.host          = "root@extinct.life"
  deploy.path          = "/home/user-data/www/extinct.life"
  deploy.user          = "root"
end
