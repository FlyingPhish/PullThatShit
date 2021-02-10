# Requires
require 'tty-prompt'
require 'tty-command'
require 'colorize'

require_relative 'modules/file_manipulation'

# Main Functionality - Downloader 'n Metadata Pulla'
class DownloaderAndPulla
  # Includes
  include FileParser

  # Variables 'n Such
  @user_agent = '"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36"'
  attr_reader :file_type_group, :user_file, :fresh_start

  def initialize(user_file, file_type_group, fresh_start)
    @user_file = user_file
    @file_type_group = file_type_group
    @fresh_start = fresh_start

    # Run Clean Function if Needed
    clean_folder if @fresh_start == true
  end

  def wget_download
    # Initiate TTY Command
    @cmd = TTY::Command.new(printer: :pretty)
    puts ''; puts "Getting the shit and putting it in 'downloads' folder:"

    # Running wget & Handling/Hiding Ugly Errors
    if @cmd.run!("wget -i #{@user_file} -c -nv --wait 2 --random-wait --no-http-keep-alive --user-agent=#{@user_agent} -P downloads/").failure?
      print 'Finished w/ some'.colorize(:green); puts ' errors.'.colorize(:red); puts
    end

    # Run Next Bit if POPULATED
    if Dir.empty?('downloads') == false
      exiftool_start
    else
      abort('Fuck, nothing to do as the folder is empty...')
    end
  end

  # Run exiftool
  def exiftool_start
    puts ; puts 'Running exiftool on your downlaods folder:'
    @cmd.run!("exiftool #{@@exif_directory}/* > #{@@exif_directory}/../results/results.txt")
  end
end

puts "

██▓███   █    ██  ██▓     ██▓       ▄▄▄█████▓ ██░ ██  ▄▄▄      ▄▄▄█████▓     ██████  ██░ ██  ██▓▄▄▄█████▓
▓██░  ██▒ ██  ▓██▒▓██▒    ▓██▒       ▓  ██▒ ▓▒▓██░ ██▒▒████▄    ▓  ██▒ ▓▒   ▒██    ▒ ▓██░ ██▒▓██▒▓  ██▒ ▓▒
▓██░ ██▓▒▓██  ▒██░▒██░    ▒██░       ▒ ▓██░ ▒░▒██▀▀██░▒██  ▀█▄  ▒ ▓██░ ▒░   ░ ▓██▄   ▒██▀▀██░▒██▒▒ ▓██░ ▒░
▒██▄█▓▒ ▒▓▓█  ░██░▒██░    ▒██░       ░ ▓██▓ ░ ░▓█ ░██ ░██▄▄▄▄██ ░ ▓██▓ ░      ▒   ██▒░▓█ ░██ ░██░░ ▓██▓ ░ 
▒██▒ ░  ░▒▒█████▓ ░██████▒░██████▒     ▒██▒ ░ ░▓█▒░██▓ ▓█   ▓██▒  ▒██▒ ░    ▒██████▒▒░▓█▒░██▓░██░  ▒██▒ ░ 
▒▓▒░ ░  ░░▒▓▒ ▒ ▒ ░ ▒░▓  ░░ ▒░▓  ░     ▒ ░░    ▒ ░░▒░▒ ▒▒   ▓▒█░  ▒ ░░      ▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░▓    ▒ ░░   
░▒ ░     ░░▒░ ░ ░ ░ ░ ▒  ░░ ░ ▒  ░       ░     ▒ ░▒░ ░  ▒   ▒▒ ░    ░       ░ ░▒  ░ ░ ▒ ░▒░ ░ ▒ ░    ░    
░░        ░░░ ░ ░   ░ ░     ░ ░        ░       ░  ░░ ░  ░   ▒     ░         ░  ░  ░   ░  ░░ ░ ▒ ░  ░      
            ░         ░  ░    ░  ░             ░  ░  ░      ░  ░                  ░   ░  ░  ░ ░           

By @FlyingPhishy
"; puts

# USER INPUT SECTION / CHECK IF USER ARG HAS BEEN SUBMITTED
if ARGV[0].nil?
  abort('Error: Specify filename with script. Currently accepts a parsed .txt or a Logger++ JSON (JSON in progress atm)')
else
  # CHECK IF EXISTS
  abort('Error: File not found. Specify a REAL file.') if File.exist?(ARGV[0]) == false

  # Initiate Prompt
  prompt = TTY::Prompt.new(active_color: :bright_yellow, interrupt: :exit)
  fresh_start = prompt.yes?('Do you want to clear the downloads folder?')

  # NEXT FEATURE SO JUST HAVE TO PASS MEANINGLESS ARG
  # wanted_file_group = prompt.select('Filetype Group Wanted?:', %w[images documents all])
  wanted_file_group = 'coming soon'

  # Start the Script
  start_script = DownloaderAndPulla.new(ARGV[0], wanted_file_group, fresh_start)
end

# Check What Methods To Fire Off
case ARGV[0].downcase
when /.txt/
  start_script.wget_download
when /.json/
  # start_script.
else
  puts "Summat's gone wrong 'ere"
end
