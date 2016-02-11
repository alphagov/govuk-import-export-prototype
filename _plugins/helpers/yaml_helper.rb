module YamlHelper

  def self.data(files, sort_by: nil)
    return {} unless files.any?

    front_matter = files.map do |file|
      content = File.read(file.to_s)

      if content =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
        YAML.load(Regexp.last_match(1))
      end
    end

    front_matter.compact!
    front_matter.sort_by! {|entry| entry[sort_by] } if sort_by
    front_matter
  end

end
