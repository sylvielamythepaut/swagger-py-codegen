# -*- coding: utf-8 -*-

{% include '_do_not_change.tpl' %}
from __future__ import absolute_import


{{ views }}


{% for view in views -%}

def {{ view.name.lower() }}(context, *args):
	{%- for method, ins in view.methods.items() %}
    {% if 'response' in  ins -%}
    return {{ ins.response.0 }}
    {%- else %}
    pass
    {%- endif %}
    {% endfor %}

{% endfor %}

def main():
    from servicelib import service

    service.start_services(
	    {% for view in views -%}
	    {"name": "{{ view.name.lower() }}", "execute": {{ view.name.lower() }}},
	    {% endfor -%}
    )

