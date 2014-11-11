PreTty-Query-Digest
===================

Create a nice HTML table from a MySQL slow query log using pt-query digest http://www.percona.com/doc/percona-toolkit

```
usage: launch.py [-h] [--report_path [REPORT_PATH]] [--no_server]
                 [--server_port SERVER_PORT] [--server_address SERVER_ADDRESS]
                 file_name


positional arguments:
  file_name             path to the slow query log file

optional arguments:
  -h, --help            show this help message and exit
  --report_path [REPORT_PATH]
                        create a html report instead of running a local server
                        if no value is provided the report will be in
                        reports/slow_query_report.html
  --no_server           Do not start a server to show the webpage
  --server_port SERVER_PORT
                        Change the port of the server, default is 8080
  --server_address SERVER_ADDRESS
                        Change the port of the server, default is 127.0.0.1
```