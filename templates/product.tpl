
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

<div class="beneficios-pdp">
    <div class="linea"></div>
    <div class="conteiner">
        <img src="{{ 'images/icons/entrega-urgente.png' | static_url }}" alt="Entrega icono">
        <div class="beneficios-content">
            <p><b>Envios Bonificados</b></p>
            <p>A partir de $190.000</p>
        </div>
    </div>
     <div class="linea linea-desktop"></div>
    <div class="conteiner beneficios-mercado-pago">
        <img src="{{ 'images/icons/billetera-electronica (1).png' | static_url }}" alt="Billetera icono">
        <div class="beneficios-content">
            <p><b>Pagá con Mercado Pago</b></p>
            <p>Hasta 6 cuotas sin interes</p>
        </div>
    </div>
     <div class="linea linea-desktop"></div>
    <div class="conteiner">
        <img src="{{ 'images/icons/regreso-facil.png' | static_url }}" alt="regreso icono">
        <div class="beneficios-content">    
            <p><b>Cambios y devoluciones</b></p>
            <p>Sin costos</p>
        </div>
    </div>
     <div class="linea"></div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
