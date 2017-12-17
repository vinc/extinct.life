namespace :assets do
  task :precompile do
    sh "middleman build"
  end
end

namespace :images do
  task :resize do
    images_path = "source/images"
    thumbnails_path = File.join(images_path, "thumbnails")
    FileUtils.mkdir(thumbnails_path) unless Dir.exists?(thumbnails_path)
    Dir.glob(File.join(images_path, "*.jpg")).each do |path|
      filename = path.split("/").last
      %w[2000x2000 1000x1000].each do |geometry|
        dest = File.join(thumbnails_path, [geometry, filename].join("_"))
        sh "convert #{path} -resize #{geometry} -unsharp 0x0.5+1.0+0.1 -quality 100 #{dest}"
        sh "jpegoptim -m 90 --strip-all #{dest}"
      end
    end
  end
end
