docker build -t harbor01:443/oscodes/syslog-generator:latest -f Dockerfile --no-cache .

docker push harbor01:443/oscodes/syslog-generator:latest
