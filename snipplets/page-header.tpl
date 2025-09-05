{# /*============================================================================
  #Page header
==============================================================================*/

#Properties

#Title

#Breadcrumbs

#}

<section class="page-header {% if template != 'category' %}pt-4{% endif %} {{ page_header_class }}" data-store="page-title">
	{% if not (template == 'product' or template == 'category') %}
	<div class="container-fluid {{ page_header_custom_classes }}">
		<div class="row">
			<div class="col">
	{% endif %}
				{% include 'snipplets/breadcrumbs.tpl' %}
				<h1 class="{% if template == 'product' %}js-product-name {% endif %}h4" {% if template == "product" %}data-store="product-name-{{ product.id }}"{% endif %}>{% block page_header_text %}{% endblock %}</h1>
	{% if not (template == 'product' or template == 'category') %}
			</div>
		</div>
	</div>
	{% endif %}
</section>
