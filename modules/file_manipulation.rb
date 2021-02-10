# Module For Parsing Files and Managing Local Files/Folders
module FileParser
  @@current_directory = File.expand_path('downloads/*').to_s
  @@exif_directory = File.expand_path('downloads').to_s

  def clean_folder
    cmd = TTY::Command.new(printer: :pretty)
    if cmd.run!("rm #{@@current_directory}").failure?
      puts "Directory doesn't exist or it's empty. If empty then ignore!.".colorize(:light_red)
    end
  end
  
  def parse_json
    puts "Coming in next version"
  end
end
