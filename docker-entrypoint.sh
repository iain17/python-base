#/bin/bash
echo "Starting service..."
while true
do
        pkill -f python
        make run &
        inotifywait --exclude .swp -e create -e modify -e delete -e move -r /opt/service/
        echo "Change detected. Reloading..."
done