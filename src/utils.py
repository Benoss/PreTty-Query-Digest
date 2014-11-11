# -*- coding: utf-8 -*-

import hashlib

def md5_for_file(path, block_size=256*128, hr=True):
    '''
    Block size directly depends on the block size of your filesystem
    to avoid performances issues
    Here I have blocks of 4096 octets (Default NTFS)
    '''
    md5 = hashlib.md5()
    with open(path,'rb') as f:
        for chunk in iter(lambda: f.read(block_size), b''):
             md5.update(chunk)
    if hr:
        return md5.hexdigest()
    return md5.digest()