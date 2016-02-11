module FileHelper

  def self.siblings(file_path, file_pattern)
    current_dir = File.expand_path(File.dirname(file_path))
    Dir["#{current_dir}/#{file_pattern}"]
  end

end
