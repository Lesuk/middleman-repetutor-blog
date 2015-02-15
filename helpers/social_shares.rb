module SocialShares
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
end