# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os
from subprocess import check_output
import json
from src.utils import md5_for_file


additional_args = ["--output=json", "--limit=100", "--progress=time,5"]


def run(file_name, pt_executable=None):
    if not pt_executable:
        pt_executable = "pt-query-digest"

    if os.path.exists(file_name):
        md5_hash = md5_for_file(file_name)
        cache_file_path = os.path.join("cache", "{}.json".format(md5_hash))
        if os.path.exists(cache_file_path):
            with open(cache_file_path) as f:
                json_response = f.read()
        else:
            try:
                json_response = check_output([pt_executable] + additional_args + [file_name])
                with open(cache_file_path, 'w') as f:
                    f.write(json_response)
            except OSError:
                raise Exception("pt-query-digest not found, install http://www.percona.com/doc/percona-toolkit")
    else:
        raise Exception("File '{}' does not exist".format(file_name))

    decoded_response = json.loads(json_response)

    #print(json.dumps(decoded_response, indent=2))

    return decoded_response