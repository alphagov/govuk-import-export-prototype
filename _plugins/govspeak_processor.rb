class Jekyll::Converters::Markdown::GovspeakProcessor
  def initialize(config)
    require 'active_support'
    require 'govspeak'
    @config = config
  end

  def convert(content)
    govspeak = ::Govspeak::Document.new(content)
    ActiveSupport::SafeBuffer.new(govspeak.to_html)
  end
end
