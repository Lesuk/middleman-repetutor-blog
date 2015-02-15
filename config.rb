require 'susy'
require 'breakpoint'

# Time.zone = "UTC"

activate :blog do |blog|
  # blog.prefix = "blog"

  blog.permalink = "{slug}"
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  # blog.layout = "article_layout"
  blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false
page "articles/*", :layout => :article_layout

compass_config do |config|
  config.output_style = :compact
  config.line_comments = false
end

# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

helpers do
  def is_page_active(page)
    current_page.url.include?(page)
  end

  # Title to Slug
  def make_slug(title)
    (title).to_slug.normalize.transliterate(:ukrainian).to_s
  end

end

activate :directory_indexes

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

configure :development do
  activate :livereload
  # activate :autoprefixer
end

set :slim, pretty: true
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Build-specific configuration
configure :build do
  activate :minify_html
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end