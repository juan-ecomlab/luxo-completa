
{# Payments details #}

<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="container-fluid">
        <div class="row section-single-product">
        <div class="mostrarMobile"> 
            {% if home_main_product %}    
    <h2 class="h4 mb-3 pt-2">{{ product.name }}</h4>
{% else %}
    {% embed "snipplets/page-header.tpl" %}
        {% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
    {% endembed %}
{% endif %}
        </div>
        
            <div class="col-12 col-md-5{% if not settings.scroll_product_images and product.media_count > 1 %} pl-md-0{% endif %}">
                {% include 'snipplets/product/product-image.tpl' %}
            </div>
            <div class="col" data-store="product-info-{{ product.id }}">
                {% if settings.scroll_product_images %}
                    <div class="js-sticky-product sticky-product">
                {% endif %}
            	{% include 'snipplets/product/product-form.tpl' %}
                
                {% if settings.scroll_product_images %}
                    </div>
                {% endif %}
            </div>

            {# Product description full width #}

            {% if settings.full_width_description %}
                {% include 'snipplets/product/product-description.tpl' %}
            {% endif %}
        </div>
    </div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
