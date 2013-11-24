# url where the file we are going to download
url = "http://media.pragprog.com/titles/rails4/code/rails30/depot_b/public/images/"

# linux commands list to make this happen
commands = Array.[]('wget', 'rm')

# the arguments for the commands
args = Array.[]('-N', '-i', '-P')

# the directory
directory = "files/"

# the files
files = Array.[]('index.html', 'file-list.tmp')
# unique pattern for the html file
pattern = /<tr><td valign="top"><img src="\/icons\/image2.gif" alt="\[IMG\]"><\/td><td><a href="/

# download the index.html
system("#{commands[0]} #{args[0]} #{url}")

# create array to store file list
downloaded_files = Array.new

# choosing the appropriate filename to be downloaded
File.open(files[0], 'r') do |f|
  while line = f.gets
    if pattern.match(line)
      downloaded_files.<<((line.split(pattern))[1].split('"')[0])
    end
  end
end

# generate the complete url for the files we are going to download
File.open(files[1], 'w') do |tempFile|
  downloaded_files.each do |file|
    tempFile.puts url+file
  end
end

# download all files in the file list
system("#{commands[0]} #{args[0]} #{args[1]} #{files[1]} #{args[2]} #{directory} ")
# delete we are not going to use anymore
system("#{commands[1]} #{files[0]} #{files[1]}")

# generate necessary info
def separator
 system(
    %{
      echo "\n #{'='*100}\n"
    }
  ) 
end

separator

system(
  %{
    echo "\t your files is ready, take a look at #{directory} folder to get the files you've downloaded"
  }
)

# additional info
system(
  %{
    echo "\t script created by dwi.juli.prabowo@gmail.com, any issues please contact"
  }
)

separator

# end of file
