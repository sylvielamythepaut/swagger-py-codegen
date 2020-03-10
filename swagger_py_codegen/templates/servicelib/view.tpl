

# Copyright (c) ECMWF 2020.

from __future__ import absolute_import, unicode_literals

{%- for method, ins in methods.items() %}

def {{ method }}(context):

{% endfor %}


def hello(context, arg):
    return "Hello, {}!".format(arg)


def bonjour(context, *arg):
    all = []
    for a in arg :
        all.append(a["name"])

    return "Bonjour: {}!".format(", ".join(all))


def main():
    from servicelib import service

    service.start_services(
        {"name": "hello", "execute": hello}, 
        {"name": "bonjour", "execute": bonjour},
    )


