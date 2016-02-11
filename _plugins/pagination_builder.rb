module Jekyll
  module PaginationBuilder

    def pagination(page)
      return '' unless page

      guide_files = FileHelper.siblings(page['path'], '*.markdown')
      guide_data  = YamlHelper.data(guide_files, sort_by: 'page_number')

      prev_fragment = prev_html_for(guide_data, page['page_number'])
      next_fragment = next_html_for(guide_data, page['page_number'])

      "#{prev_fragment}#{next_fragment}"
    end

    private

    def prev_html_for(guide_data, current_page)
      return '' unless guide_data.any?
      return '' unless current_page > 1

      previous_page = current_page - 1
      previous_data = guide_data[previous_page - 1]

      pagination_html_for(previous_data, 'Previous', 'prev')
    end

    def next_html_for(guide_data, current_page)
      return '' unless guide_data.any?
      return '' unless guide_data.length > current_page

      next_page = current_page + 1
      next_data = guide_data[next_page - 1]

      pagination_html_for(next_data, 'Next', 'next')
    end

    def pagination_html_for(data, direction, rel)
      HtmlHelper.build_fragment do |html|
        html.li(class: direction.downcase) {
          html.a(title: "Navigate to #{direction.downcase} part", rel: rel, href: data['permalink']) {
            html.span(direction, class: 'pagination-label')
            html.span(data['part_title'], class: 'pagination-part-title')
          }
        }
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::PaginationBuilder)
