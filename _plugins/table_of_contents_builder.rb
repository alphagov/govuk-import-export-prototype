require 'nokogiri'

module Jekyll
  module TableOfContentsBuilder

    def toc(content)
      return '' unless content

      document = Nokogiri::HTML::DocumentFragment.parse(content)
      headings = document.css("h2[id]")

      fragment = Nokogiri::HTML::DocumentFragment.parse ""

      Nokogiri::HTML::Builder.with(fragment) do |html|
        html.ol(id: 'document_sections') {
          headings.each do |heading|
            html.li {
              html.a(heading.text, href: "##{heading['id']}")
            }
          end
        }
      end

      fragment.to_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::TableOfContentsBuilder)
