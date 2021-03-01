# Module For Parsing Files and Managing Local Files/Folders
module FileParser
  # File Path Tracking
  @@current_directory = File.expand_path('downloads/*').to_s
  @@exif_directory = File.expand_path('downloads').to_s

  # Cleans The Downloads Folder
  def clean_folder
    cmd = TTY::Command.new(printer: :pretty)
    if cmd.run!("rm #{@@current_directory}").failure?
      puts "Directory doesn't exist or it's empty. If empty then ignore!.".colorize(:light_red)
    end
  end

  # Parse JSON Files into .txt File
  def parse_json
    # Require JSON For Parsing
    require 'json'

    # Variables
    json_file = File.read(@user_file)
    json_file_parsed = JSON.parse(json_file)
    targets = []

    # Maths Stuffs
    counter = 0
    length = json_file_parsed.length; length -= 1

    # Parse JSON Ouput n Stuff Into Array
    until counter > length
      targets.push(json_file_parsed[counter]['Request']['URL'])
      counter += 1
    end

    # Remove Duplicates
    targets = targets.uniq

    # Add Stuff From Array To File
    File.open('parsed_targets.txt', 'w+') do |url|
      url.puts(targets)
    end

    # Reassign Variable
    @user_file = 'parsed_targets.txt'
  end

  # Create New Targets File
  def select_file_type
    # Different Grep Queries
    case @file_type_group
    when 'images'
      grep = '.png$|.jpg$|.svg$|.jpeg$|.tiff$|.tif$|.bmp$|.eps$'
    when 'documents'
      grep = '.pdf$|.doc$|.txt$|.docx$|.xlsx$|.xls$|.csv$|.odt$|.ods$|.pages$|.ppt$|.pptx$'
    when 'all'
      # CBA Changing The Bottom Code
      system("cat #{@user_file} | sort -u |  egrep '^.*\\.[a-z]+$' > final_targets_#{@file_type_group}.txt")
    else
      puts "Summat's gone wrong 'ere"
    end

    # Grep User's File n Create Final Targets File
    system("cat #{@user_file} | sort -u | grep -E '#{grep}' > final_targets_#{@file_type_group}.txt")

    # Reassigned Variable
    @user_file = 'final_targets_' + @file_type_group + '.txt'
  end

  def read_stats
    # Keywords To Count
    interesting_values = 'Author|Producer|Creator|Creator Tool|XMP Toolkit|GPS|Software|Comments'
    puts ; puts 'Interesting Results (Small Sample):'
    system("grep -E '#{interesting_values}' results/results.txt")
  end
end
