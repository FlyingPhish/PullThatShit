## PullThatShit (PTS)

PTS is a Ruby script (written by a n00b) to help semi/fully automate document downloading + metadata scraping. You pass it a file with URLs that contain pngs, pdfs etc and it'll download (or attempt to download) resources for those URLs. Once downloaded it'll run exiftool and save the results to the 'results' folder. The next update will allow you to pass it a Logger++ Burp JSON file and it'll parse the URLS for you. Meaning you could do a web app test or OSINT with Burp's Proxy, and then pull that shit.

Version 1.0 is the current version.

## Upcoming Updates

Add support for Logger++ JSON files + add feature for parsing said filetype.

Add document group selection so you can only chose to download image filetypes.

Add feature to highlight interesting metadata in files and print them out on the screen.

Potentially -
Allow user to set User agent, timeout, wait and redirect properties.
Auth support for base urls.

## Advisory

All the scripts listed in this repository should only be used for authorized penetration testing and/or educational purposes. Any misuse of this software will not be the responsibility of the author or of any other collaborator. Use it on your own networks and/or systems with the network owner's permission. Furthermore, please use at your own risk as the author or any other collaborator are not responsible for any issues or trouble caused!
