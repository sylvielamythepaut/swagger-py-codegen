

# Copyright (c) ECMWF 2020.

from __future__ import absolute_import, unicode_literals

{%- for method, ins in methods.items() %}

def {{ method }}(context):

{%- endfor -%}

 PARAM {{ params }}

 {%- for method, ins in methods.items() %}

    def {{ method.lower() }}(self{{ params.__len__() and ', ' or '' }}{{ params | join(', ') }}):
        {%- for request in ins.requests %}
        print(self.{{ request }})
        {%- endfor %}

        {% if 'response' in  ins -%}
        return {{ ins.response.0 }}, {{ ins.response.1 }}, {{ ins.response.2 }}
        {%- else %}
        pass
        {%- endif %}
    {%- endfor -%}





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


