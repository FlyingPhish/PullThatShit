## PullThatShit (PTS)

PTS is a Ruby script (written by a n00b) to help semi/fully automate document downloading + metadata scraping. You pass it a file that contains pngs, pdfs, docs etc and it'll download (or attempt to download) resources from those URLs. Once downloaded it'll run exiftool and save the results to the 'results' folder. 

This tool currently supports .txt files with URLs on new lines or Logger++ .json files (Burp Extension). Once the file is specified you can choose a few options like removing previous results/downloads and selecting what filetype group you want to grab (pictures, documents or all). This will then go through the target file, pull the relevant file extensions and load it into the tool.

This tool was created so you could automate grabbing metadata from a Web App pentest you've conducted, or if you've been snooping around (OSINT) and you've either got a list of URLs or you've been running your traffic via Burp.

Version 1.5 is the current version.

## Usage

./pts targetfile.txt
OR
./pts targetjsonfile.json

## Upcoming Updates

Add support for Logger++ JSON files + add feature for parsing said filetype. - DONE

Add document group selection so you can only chose to download image filetypes. - DONE

Add feature to highlight interesting metadata in files and print them out on the screen.

Potentially -

Allow user to set User agent, timeout, wait and redirect properties.

Auth support for base urls.

## Advisory

All the scripts listed in this repository should only be used for authorized penetration testing and/or educational purposes. Any misuse of this software will not be the responsibility of the author or of any other collaborator. Use it on your own networks and/or systems with the network owner's permission. Furthermore, please use at your own risk as the author or any other collaborator are not responsible for any issues or trouble caused!
