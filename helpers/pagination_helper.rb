module PaginationHelper
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