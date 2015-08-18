
"""
  CRON script
  This script will find all images without thumbs and for each missing will
  execute imagemagick's container to create thumb.
"""
imgs = File.ls!("data/files/img")
thumbs = File.ls!("data/files/thumb")
imgs -- thumbs
|> Enum.each(fn file ->
  System.cmd "docker-compose", [
    "run", "--rm", "imagemagick",
    "mogrify",
    "-resize", "200x200^",
    "-write", "/files/thumb/#{file}",
    "/files/img/#{file}[0]"
  ]
end)






