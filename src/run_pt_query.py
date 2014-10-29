# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os
from subprocess import check_output
import json
additional_args = ["--output=json", "--limit=100"]


def run(file_name, pt_executable=None):
    if not pt_executable:
        pt_executable = "pt-query-digest"

    if os.path.exists(file_name):
        json_response = check_output([pt_executable] + additional_args + [file_name])
    else:
        raise Exception("File '{}' does not exist".format(file_name))

    decoded_response = json.loads(json_response)

    #print(json.dumps(decoded_response, indent=2))

    return decoded_response