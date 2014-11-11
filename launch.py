# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from src import run_pt_query
import os
import codecs
from src.bottle import route, run, template
import argparse

thead = ["DB", "fingerprint", "QueryCount", "MedianTime",
         "95% Time", "TotalTime", "RowExamined", "LockTime"]


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Nice pt-query-digest')
    parser.add_argument('file_name',  help='path to the slow query log file')
    parser.add_argument('--report_path',  nargs="?", default=None, const="reports/slow_query_report.html",
                        help='create a html report instead of running a local server '
                             'if no value is provided the report will be in reports/slow_query_report.html')
    parser.add_argument('--no_server',  action="store_true",
                        help='Do not start a server to serve the result')
    parser.add_argument('--server_port', action="store", type=int, default=8080,
                        help='Change the port of the server [default 8080]')
    parser.add_argument('--server_address', action="store", default="127.0.0.1",
                        help='Change the bind address of the server [default 127.0.0.1]')

    args = parser.parse_args()

    if not os.path.exists("reports"):
        os.mkdir("reports")

    if not os.path.exists("cache"):
        os.mkdir("cache")

    print("Starting pt-query-digest for {}".format(args.file_name))
    parsed_result = run_pt_query.run(args.file_name)

    template_result = template('index', parsed_result=parsed_result, thead=thead)

    if args.report_path:
        print("Saving report to {}".format(args.report_path))
        with codecs.open(args.report_path, 'w', encoding='utf8') as f:
            f.write(template_result)

    if not args.no_server:
        @route('/')
        def index():
            return template('index', parsed_result=parsed_result, thead=thead)

        run(host=args.server_address, port=args.server_port)