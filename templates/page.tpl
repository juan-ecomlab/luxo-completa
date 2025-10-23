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

{% elseif current_url == "empresab" %}
{% include 'templates/empresab.tpl' %}

{% elseif current_url == "thekluv" %}
{% include 'templates/thekluv.tpl' %}

{% elseif current_url == "insuave" %}
{% include 'templates/insuave.tpl' %}

{% elseif current_url == "castiglioni" %}
{% include 'templates/castiglioni.tpl' %}

{% elseif current_url == "artista-canalla" %}
{% include 'templates/artista-canalla.tpl' %}

{% elseif current_url == "totosanchez" %}
{% include 'templates/totosanchez.tpl' %}

{% elseif current_url == "aldagrama" %}
{% include 'templates/aldagrama.tpl' %}

{% elseif current_url == "dalia" %}
{% include 'templates/dalia.tpl' %}

{% elseif current_url == "tamo" %}
{% include 'templates/tamo.tpl' %}

{% elseif current_url == "villy-villain" %}
{% include 'templates/villy-villain.tpl' %}

{% elseif current_url == "piranha" %}
{% include 'templates/piranha.tpl' %}

{% elseif current_url == "pioppo" %}
{% include 'templates/pioppo.tpl' %}

{% elseif current_url == "suasnabar" %}
{% include 'templates/suasnabar.tpl' %}

{% elseif current_url == "colecciones-pasadas" %}
{% include 'templates/coleccionespasadas.tpl' %}

{% elseif current_url == "test" %}
{% include 'templates/test.tpl' %}

{% else %}
{{ page.content }}
{% endif %}

</section>

