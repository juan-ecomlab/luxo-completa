{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
	{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
{% endembed %}

{# Institutional page  #}

<section class="user-content">

{% if current_url == "lookbook" %}
{% include 'templates/lookbook.tpl' %}

{% elseif current_url == "coleccion" %}
{% include 'templates/coleccion.tpl' %}

{% elseif current_url == "artistas" %}
{% include 'templates/artistas.tpl' %}

{% elseif current_url == "dot" %}
{% include 'templates/dot.tpl' %}

{% elseif current_url == "buenavibra" %}
{% include 'templates/buenavibra.tpl' %}

{% elseif current_url == "bases_condiciones" %}
{% include 'templates/bases_condiciones.tpl' %}

{% elseif current_url == "locales" %}
{% include 'templates/locales.tpl' %}

{% elseif current_url == "nft" %}
{% include 'templates/nft.tpl' %}

{% elseif current_url == "faqs" %}
{% include 'templates/faqs.tpl' %}

{% elseif current_url == "solarpark" %}
{% include 'templates/solarPark.tpl' %}

{% elseif current_url == "test" %}
{% include 'templates/test.tpl' %}

{% else %}
{{ page.content }}
{% endif %}

</section>

