
module Jekyll
  class SeoTag
    class Drop < Jekyll::Drops::Drop
      def page_title
        return @page_title if defined?(@page_title)

        title = format_string(page[page['net_title'].nil? ? 'title' : 'net_title'])
        title_category = format_string(page["title_category"])
        @page_title = if title && title_category && title != title_category
                        title + TITLE_SEPARATOR + title_category
                      else
                        title || title_category || site_title
                      end
      end
    end
  end
end