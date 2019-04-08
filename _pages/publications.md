---
layout: page
permalink: /publications/
title: publications
description: For future publications ;-)
years: []
---

{% for y in page.years %}
  <h3 class="year">{{y}}</h3>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}