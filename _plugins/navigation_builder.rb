module Jekyll
  module NavigationBuilder

    def navigation(page)
      return '' unless page

      guide_files = FileHelper.siblings(page['path'], '*.markdown')
      guide_data  = YamlHelper.data(guide_files, sort_by: 'page_number')

      right_links = guide_data.size / 2
      left_links  = guide_data.size - right_links

      left_fragment = nav_html_for(guide_data.first(left_links), page, 1)
      right_fragment = nav_html_for(guide_data.last(right_links), page, left_links + 1)

      "#{left_fragment}#{right_fragment}"
    end

    private

    def nav_html_for(guide_data, page, start_page)
      return '' unless guide_data.any?

      HtmlHelper.build_fragment do |html|
        html.ol(start: "#{start_page}") {
          guide_data.each do |data|
            active_class = page['page_number'] == data['page_number'] ? 'active' : ''

            html.li(class: "#{active_class}") {
              html.span("#{data['page_number']}.", class: 'part-number')

              if active_class == 'active'
                html.span(data['page_title'])
              else
                html.a(data['page_title'], href: data['permalink'])
              end
            }
          end
        }
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::NavigationBuilder)
