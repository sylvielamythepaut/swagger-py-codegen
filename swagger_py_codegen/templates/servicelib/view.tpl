

# Copyright (c) ECMWF 2020.

from __future__ import absolute_import, unicode_literals


def {{ name.lower() }}(context, *args):
    {%- for method, ins in methods.items() %}
    {% if 'response' in  ins -%}
    return {{ ins.response.0 }}
    {%- else %}
    pass
    {%- endif %}
    {% endfor %}


def main():
    from servicelib import service

    service.start_services(
        {"name": "{{ name.lower() }}", "execute": {{ name.lower() }}},
    )


