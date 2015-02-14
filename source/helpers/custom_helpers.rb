module CustomHelpers
  def fb_share_url(path)
    str = "https://www.facebook.com/sharer/sharer.php?u=http://repetitor.lviv.ua/"
    str += "#{path}"
    str
  end
end