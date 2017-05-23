#/bin/bash
echo "Starting service..."

# add specific files or their extensions to watch them 
files_to_watch=("py" "*yaml" "Makefile" "")

# create an associative map to check against
declare -A map
for ext in "${files_to_watch[@]}"; do
  map["$ext"]=1
done

# main program loop
# uses inotify to check whether files have been created, moved, edited etc.
while true
do
    inotifywait -m ./test -e create -e modify -e delete -e move -e moved_to |
		while read path action file; do
			file_extension=${file##*.}
			
			if [[ ${map["$file_extension"]} ]]; then 
				pkill -f python
				make run
				echo "Change detected. Reloading..."
			fi
		done
done
