#!/usr/bin/env python3
'''
lists all documents in a collection.
'''


def list_all(mongo_collection):
    '''list_all: Return list of documetns.
    '''
    return [doc for doc in mongo_collection.find()]
