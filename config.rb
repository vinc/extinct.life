ignore "**/.*swp"

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

helpers do
  def ls(dir)
    sitemap.resources.select do |resource|
      resource.path.start_with?(dir)
    end
  end
end

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

activate :asset_hash

activate :deploy do |deploy|
  deploy.deploy_method = :rsync
  deploy.host          = "root@extinct.life"
  deploy.path          = "/home/user-data/www/extinct.life"
  deploy.user          = "root"
end

set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "images"

blog = activate :blog do |blog|
  # blog.prefix = "/"
  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "layouts/blog"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"
  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
  blog.publish_future_dated = false
end

ready do
  redirect "index.html", to: blog.data.articles.last.path

  sitemap.resources.each do |resource|
    next unless resource.data.title.nil?

    case resource.locals["page_type"]
    when "tag"
      resource.data.title = resource.locals["tagname"]
    when "year", "month", "day"
      resource.data.title = resource.locals[resource.locals["page_type"]].to_s
    end
  end
end
