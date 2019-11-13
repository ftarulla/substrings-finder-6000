import os
import re

def import_file(path, dst):
  src = open(path, "r")
  for line in src:
    dst.write(line)
  src.close()

if __name__ == "__main__":
  src = open("./templates/_index.html", "r")
  dst = open("./index.html", "w")

  for line in src:
    # match = re.search(r"{{'(.+)'}}", line)
    match = re.search(r"include\('(.+)'\)", line)
    if match:
      file = match.group(1)
      import_file(file, dst)
    else:
      dst.write(line)

  src.close()
  dst.close()

  print("Done!")
