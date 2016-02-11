require 'nokogiri'

module HtmlHelper
  def self.find_fragments(content, css_selector)
    document = Nokogiri::HTML::DocumentFragment.parse(content)
    document.css(css_selector)
  end

  def self.build_fragment
    document = Nokogiri::HTML::DocumentFragment.parse("")

    yield Nokogiri::HTML::Builder.with(document)

    document.to_html
  end
end
