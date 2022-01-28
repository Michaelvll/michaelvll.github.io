---
layout: page
permalink: /publications/
title: Publications
description: 
years: [2021, 2020, 2019]
---

{% for y in page.years %}
  <h3 class="year"><slim>{{y}}</slim></h3>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}
