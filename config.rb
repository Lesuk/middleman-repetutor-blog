require "susy"
###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "{slug}"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  # blog.layout = "article_layout"
  blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false
page "articles/*", :layout => :article_layout

###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.output_style = :compact
  config.line_comments = false
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
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

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###
helpers do
  def is_page_active(page)
    # current_page.url == page
    current_page.url.include?(page)
  end

  def fb_share(article)
    base = "http://repetitor.lviv.ua/"
    url = "https://www.facebook.com/sharer/sharer.php?"
    url += "u=#{base}#{article.data.slug}"
  end
  def vk_share(article)
    base = "http://repetitor.lviv.ua/"
    url  = "http://vkontakte.ru/share.php?"
    url += "url=" + "#{base}#{article.data.slug}"
    url += "&title=" + "#{article.data.title}"
    url += "&description=" + "#{article.data.description}"
    if article.data.img_url
      url += '&image=' + "image.jpg"
    else
      url
    end
  end
  def tw_share(article)
    base = "http://repetitor.lviv.ua/"
    url  = 'http://twitter.com/share?'
    url += 'text=' + "#{article.data.title}"
    url += '&url=' + "#{base}#{article.data.slug}"
  end
  def odn_share(article)
    base = "http://repetitor.lviv.ua/"
    url  = 'http://www.odnoklassniki.ru/dk?st.cmd=addShare&st.s=1'
    url += '&st.comments=' + "#{article.data.title}"
    url += '&st._surl=' + "#{base}#{article.data.slug}"
  end

  def locals_for(page, key)
    page && page.metadata[:locals][key]
  end

  def pagination_links
    if locals_for(current_page, 'num_pages') == 1
      return nil
    end

    prev_link = pagination_item('&lsaquo;', locals_for(current_page, 'prev_page').try(:url))
    next_link = pagination_item('&rsaquo;', locals_for(current_page, 'next_page').try(:url))

    items = []

    # Add the current page
    page = current_page

    # Add the prior pages
    i = 0
    while page = locals_for(page, 'prev_page')
      if (i < 2)
        items.unshift pagination_item_for(page)
        i += 1
      end
      first_page = page
    end
    first_link = pagination_item('&laquo;', first_page.try(:url))

    # Add all subsequent pages
    page = current_page
    items.push pagination_item_for(current_page)

    i = 0
    while page = locals_for(page, 'next_page')
      if (i < 2)
        items.push pagination_item_for(page)
        i += 1
      end
      last_page = page
    end
    last_link = pagination_item('&raquo;', last_page.try(:url))

    # Combine the items with the prev/next links
    items = [first_link, prev_link, items, next_link, last_link].flatten

    content_tag(:ul, items.join)
  end

  def pagination_item_for(page)
    link_title = page.metadata[:locals]['page_number']
    pagination_item(link_title, page.url)
  end

  def pagination_item(link_title, link_path, options = {})
    if link_path == current_page.url
      content = content_tag(:span, link_title, class: "page active")
      # options[:class] = "active"
    elsif link_path
      content = link_to(link_title, link_path, class: "page")
    else
      content = content_tag(:span, link_title, class: "page")
      options[:class] = "disabled"
    end

    content_tag(:li, content, options)
  end

end

activate :directory_indexes

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

configure :development do
  activate :livereload
  # activate :autoprefixer
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

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