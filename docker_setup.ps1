docker build -t lab02-image .
docker run --name lab02 --oom-kill-disable -it lab02-image /bin/bash
