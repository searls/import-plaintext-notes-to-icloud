require 'fileutils'

module ListFilesByMtime
  def self.call(directory_path)
    Dir["#{directory_path}/**/*.txt"].
      sort_by { |path| File.stat(path).mtime }.
      map { |path| File.read(path) }
  end
end
