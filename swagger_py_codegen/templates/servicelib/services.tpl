# -*- coding: utf-8 -*-

{% include '_do_not_change.tpl' %}
from __future__ import absolute_import





{% for view in views -%}

def {{ view.name.lower() }}(context, *args):
	{%- for method, ins in view.methods.items() %}
    {% if 'response' in  ins -%}
    return { "input" : args, "status" : "method {{ view.name.lower() }} to be implemented"} 
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

