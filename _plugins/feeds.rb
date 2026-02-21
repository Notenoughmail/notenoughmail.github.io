
module Jekyll
  class Feeds

    @@update_lookups = {
      :kjstfc => { :name => 'KubeJS TFC', :url => 'kubejs-tfc' },
      :configjs => { :name => 'ConfigJS', :url => 'configjs' },
      :precpros => { :name => 'Precision Prospecting', :url => 'prec-pros' },
      :tfcgv => { :name => 'TFCGenViewer', :url => 'tfcgv' }
    }

    class << self
      def process_updates(page)
        gp = @@update_lookups[page.data['layout'].to_s.to_sym]
        unless gp.nil?
          page.data['parent'] = 'Updates'
          page.data['grand_parent'] = gp[:name]

          date = fix_date(page)

          link = '/%s/%s/%s/%s-%s.html' % [
            date.year,
            date.month,
            date.mday,
            gp[:url],
            (page.data['url_version'].nil? ?
                page.data['version'].to_s.gsub('.', '-') :
                page.data['url_version'].to_s)
          ]

          page.data['permalink'] = link
          page.data['update_post'] = true
          page.data['thin_media'] = true
        end
      end

      @@writing_lookups = {
        :commentary => { :thin => false },
        :story => { :thin => true }
      }

      def process_writing(page)
        lk = @@writing_lookups[page.data['layout'].to_s.to_sym]
        unless lk.nil?
          fix_date(page)
          page.data['writing'] = true
          page.data['thin_media'] = lk[:thin]
        end
      end

      def fix_date(page)
          date_any_type = page.data['date']
          if date_any_type.is_a? String
            date_any_type = DateTime.strptime(date_any_type.gsub('MST', '-0700'), "%Y-%m-%d %H:%M:%S %z")
          elsif date_any_type.is_a? Time
            date_any_type = date_any_type.to_datetime
          end

          page.data['date'] = date_any_type
          page.data['nav_order'] = date_any_type.to_s
          date_any_type
      end
    end
  end
end

Jekyll::Hooks.register [:pages], :post_init do |page|
  Jekyll::Feeds.process_updates(page) if page.path.to_s.end_with?(".md")
  Jekyll::Feeds.process_writing(page) if page.path.to_s.end_with?('.md')
end
