
{# Payments details #}

<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="container-fluid">
        <div class="row section-single-product">
            
        
            <div class="col-12 col-md-6{% if not settings.scroll_product_images and product.media_count > 1 %} pl-md-0{% endif %}">
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

{# Benefits strip: texts come from Detalle de producto > Beneficios debajo del producto; empty fields fall back to these defaults #}
{% if not settings.pdp_benefits_hide %}
<div class="beneficios-pdp">
    <div class="linea"></div>
    <div class="conteiner">
        <img src="{{ 'images/icons/envios.svg' | static_url }}" alt="Entrega icono">
        <div class="beneficios-content">
            <p><b>{{ settings.pdp_benefit_shipping_title | default('Envíos Bonificados') }}</b></p>
            <p>{{ settings.pdp_benefit_shipping_text | default('A partir de $160.000') }}</p>
        </div>
    </div>
     <div class="linea linea-desktop"></div>
    <div class="conteiner beneficios-mercado-pago">
        <img src="{{ 'images/icons/billetera.svg' | static_url }}" alt="Billetera icono">
        <div class="beneficios-content">
            <p><b>{{ settings.pdp_benefit_payment_title | default('Pagá con Mercado Pago') }}</b></p>
            <p>{{ settings.pdp_benefit_payment_text | default('Hasta 9 cuotas sin interés') }}</p>
        </div>
    </div>
     <div class="linea linea-desktop"></div>
    <div class="conteiner" id="resenas">
        <img src="{{ 'images/icons/cambios.svg' | static_url }}" alt="regreso icono">
        <div class="beneficios-content">
            <p><b>{{ settings.pdp_benefit_returns_title | default('Cambios y devoluciones') }}</b></p>
            <p>{{ settings.pdp_benefit_returns_text | default('Sin costos') }}</p>
        </div>
    </div>
     <div class="linea"></div>
</div>
{% endif %}

<div class="resenas">
       
    </div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
