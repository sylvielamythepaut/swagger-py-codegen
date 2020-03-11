[worker]
autoreload = 1
port = 8000
serve_results = /var/cache/servicelib

[log]
level = debug
type = text

[scratch]
dirs = /var/cache/servicelib
strategy = random

[results]
class = http-files
dirs = /var/cache/servicelib
http_port = 8000
