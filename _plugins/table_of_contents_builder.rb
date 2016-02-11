module Jekyll
  module TableOfContentsBuilder

    def toc(content)
      return '' unless content

      HtmlHelper.build_fragment do |html|
        html.ol(id: 'document_sections') {
          HtmlHelper.find_fragments(content, "h2[id]").each do |heading|
            html.li {
              html.a(heading.text, href: "##{heading['id']}")
            }
          end
        }
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::TableOfContentsBuilder)
