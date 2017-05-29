#/bin/bash
echo "Starting service..."
make run &

# add specific files or their extensions to watch them 
files_to_watch=("py" "*yaml" "Makefile")

# create an associative map to check against
declare -A map
for ext in "${files_to_watch[@]}"; do
  map["$ext"]=1
done

# main program loop
# uses inotify to check whether files have been created, moved, edited etc.
while true
do
    inotifywait -m /opt/service -r -e create -e modify -e delete -e move -e moved_to |
		while read path action file; do
			file_extension=${file##*.}
			
			if [[ ${map["$file_extension"]} ]]; then 
				echo "Change detected. Reloading..."
				pkill -f python
				make run &
			fi
		done
done
