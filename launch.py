# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from src import parse_result
from src import run_pt_query
file = "/home/benoit/gramm/result.json"

parsed_result = run_pt_query.run("/home/benoit/gramm/ns382943-slow.log")


from src.bottle import route, run, template


thead = ["DB", "fingerprint", "QueryCount", "MedianTime",
         "95% Time", "TotalTime", "RowExamined", "LockTime"]


@route('/')
def index():
    return template('index', parsed_result=parsed_result, thead=thead)

run(host='localhost', port=8080, debug=True)