{# Product name and breadcrumbs #}
<div class="mostrarDesktop"> 
{% if home_main_product %}    
    <h2 class="h4 mb-3 pt-2">{{ product.name }}</h4>
{% else %}
    {% embed "snipplets/page-header.tpl" %}
        {% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
    {% endembed %}
{% endif %}
</div>


{# Product price #}

<div class="price-container mb-3 row" data-store="product-price-{{ product.id }}">
    <div class="col">
        {% set price_big_class = settings.payment_discount_price ? 'font-big' %}
        <span class="d-inline-block {{ price_big_class }}">
           <div id="compare_price_display" class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</div>
        </span>
        <span class="d-inline-block {{ price_big_class }}">
        	<div class="js-price-display" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">{% if product.display_price %}{{ product.price | money }}{% endif %}</div>
        </span>
    </div>
    {% if settings.product_detail_installments %}
        <div class="col-auto">
            {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "item-installments"}}) }}
        </div>
    {% endif %}
    <div class="col-12">
        {{ component('price-without-taxes', {
                container_classes: "mt-2 font-small opacity-60",
            })
        }}
        {{ component('payment-discount-price', {
                visibility_condition: settings.payment_discount_price,
                location: 'product',
                container_classes: "mt-2",
            })
        }}
    </div>
</div>

{# Product availability #}

{% set product_available = product.available and product.display_price %}

{# Free shipping minimum message #}
{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set has_product_free_shipping = product.free_shipping %}

{% if not product.is_non_shippable and product_available and (has_free_shipping or has_product_free_shipping) %}
    <div class="free-shipping-message mb-4 pb-2">
        <span class="float-left mr-1">
            <svg class="icon-inline icon-w svg-icon-text mr-1"><use xlink:href="#truck"/></svg>
        </span>
        <span class="font-small">
            {{ "Envío gratis" | translate }}
            <span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
                {{ "superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
            </span>
        </span>
        {% if not has_product_free_shipping %}
            <div class="js-free-shipping-discount-not-combinable font-small mt-1">
                {{ "No acumulable con otras promociones" | translate }}
            </div>
        {% endif %}
    </div>
{% endif %}

{{ component('promotions-details', {
    promotions_details_classes: {
        container: 'js-product-promo-container mb-3',
        promotion_title: 'mb-2 h6 font-big text-accent',
        valid_scopes: 'font-small mb-0',
        categories_combinable: 'font-small mb-0',
        not_combinable: 'font-small mb-0',
        progressive_discounts_table: 'table mb-2 mt-3',
        progressive_discounts_hidden_table: 'table-body-inverted',
        progressive_discounts_show_more_link: 'btn-link btn-link-primary mb-4',
        progressive_discounts_show_more_icon: 'icon-inline icon-rotate-90',
        progressive_discounts_hide_icon: 'icon-inline icon-rotate-90-neg',
        progressive_discounts_promotion_quantity: 'font-weight-light text-lowercase'
    },
    accordion_show_svg_id: 'chevron',
    accordion_hide_svg_id: 'chevron',
}) }}




{# Product form, includes: Variants, CTA and Shipping calculator #}

 <form id="product_form" class="js-product-form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
	<input type="hidden" name="add_to_cart" value="{{product.id}}" />
    <h4>Seleccioná tu talle</h4>
    {% if template == "product" %}
        {% set show_size_guide = true %}
    {% endif %}
 	{% if product.variations %}
        {% include "snipplets/product/product-variants.tpl" with {show_size_guide: show_size_guide} %}
    {% endif %}

    {% set show_product_quantity = product_available and settings.quantity_input %}

    {% if settings.last_product and show_product_quantity %}
        <div class="{% if product.variations %}js-last-product {% endif %}text-accent font-weight-bold mb-4"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
            {{ settings.last_product_text }}
        </div>
    {% endif %}

    <div class="form-row mb-2">
        {% if show_product_quantity %}
            {% include "snipplets/product/product-quantity.tpl" %}
        {% endif %}
        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
        {% set texts = {'cart': "COMPRAR AHORA", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
        <div class="{% if show_product_quantity %}col-8{% else %}col-md-6 col-12{% endif %}">

            {% if settings.product_stock and not settings.quantity_input and product.available and product.display_price %}
                {% include "snipplets/product/product-stock.tpl" with {custom_class: "pb-3"} %}
            {% endif %}

            {# Add to cart CTA #}

            <div class="iconos-talles">
    <div>
        <img src="{{ 'images/icons/camiseta.png' | static_url }}" alt="Conoce tu talle icono">
        <a data-fancybox data-src="#modaltalle2" href="javascript:;">Conocé tu talle</a> 
    </div>
    <div class="distinto">
        <img src="{{ 'images/icons/camiseta-de-manga-corta.png' | static_url }}" alt="Guia de talle icono">
        <a data-fancybox data-src="#modaltalle" href="javascript:;">Guía de talles</a>
    </div>

     <div id="modaltalle2" style="display:none;" >
                <img src="{{ ('images/tabla/' ~ product.handle ~ '.jpg' ) | static_url }}" style="width:100%;"/>
            </div> 
    <div id="modaltalle" style="display:none;" >
                <img src="{{ 'images/como-me-mido.png' | static_url }}" style="width:100%;"/>
            </div> 

</div>

            <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart"/>

            {# Fake add to cart CTA visible during add to cart event #}

            {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "mb-4"} %}

        </div>
       <div class="sla-entrega-desktop col-12">
            <img src="{{ 'images/icons/entrega-urgente.png' | static_url }}" alt="Entrega icono"><span>Llega antes del AMBA: 12 ABR - Interior: 18 ABR</span>
        </div>

        {# Description #}

{% if not settings.full_width_description %}
                    {% include 'snipplets/product/product-description.tpl' %}
                {% endif %}

        {% if settings.ajax_cart %}
            <div class="col-12">
                <div class="js-added-to-cart-product-message font-small" style="display: none;">
                    <svg class="icon-inline icon-lg svg-icon-text mr-2 d-table float-left"><use xlink:href="#check"/></svg>
                    <span>
                        {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-open-cart js-fullscreen-modal-open btn-link float-right subtitle ml-1" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                    </span>
                    <div class="divider"></div>
                </div>
            </div>
            <div class="sla-entrega-mobile">
            <img src="{{ 'images/icons/entrega-urgente.png' | static_url }}" alt="Entrega icono"><span>Llega antes del AMBA: 12 ABR - Interior: 18 ABR</span>
        </div>
        {% endif %}

         

        {# Free shipping visibility message #}

        {% set free_shipping_minimum_label_changes_visibility = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

        {% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

        {% if not product.is_non_shippable and product_available and has_free_shipping and not has_product_free_shipping %}

            {# Free shipping add to cart message #}

            {% if include_product_free_shipping_min_wording %}

                {% include "snipplets/shipping/shipping-free-rest.tpl" with {'product_detail': true} %}

            {% endif %}

            {# Free shipping achieved message #}

            <div class="{% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} text-accent mb-3 w-100" {% if not cart.free_shipping.cart_has_free_shipping %}style="display: none;"{% endif %}>
                {{ "¡Genial! Tenés envío gratis" | translate }}
            </div>

        {% endif %}
    </div>

    {# Product installments #}

    {% set installments_info = product.installments_info_from_any_variant %}
    {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
    {% set show_payments_info = settings.product_detail_installments and product.show_installments and product.display_price and installments_info %}

    {% if not home_main_product and (show_payments_info or hasDiscount) %}

        {# If product detail installments, include container with "see installments" link #}

        <div class="js-accordion-container w-100 mb-3">
            <a href="#" class="js-accordion-toggle py-1 row">
                <div class="col">
                    <svg class="icon-inline icon-w svg-icon-text mr-1"><use xlink:href="#credit-card"/></svg>
                    <span class="subtitle">{{ 'Medios de pago' | translate }}</span>
                </div>
                <div class="col-auto">
                    <span class="js-accordion-toggle-inactive">
                        <svg class="icon-inline svg-icon-text icon-rotate-90"><use xlink:href="#chevron"/></svg>
                    </span>
                    <span class="js-accordion-toggle-active" style="display: none;">
                        <svg class="icon-inline svg-icon-text icon-rotate-90-neg"><use xlink:href="#chevron"/></svg>
                    </span>
                </div>
            </a>
            <div class="js-accordion-content w-100 pt-3" style="display: none;">
                <div {% if installments_info %}data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments"{% endif %} class="{% if installments_info %}js-modal-open js-fullscreen-modal-open{% endif %} js-product-payments-container row mb-4" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>

                    {# Installments #}

                    {% if show_payments_info %}
                        {% set max_installments_without_interests = product.get_max_installments(false) %}
                        {% set installments_without_interests = max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                        {% set installment_text_color = installments_without_interests ? 'text-accent' : '' %}
                        {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "col-12 mb-2 " ~ installment_text_color}}) }}
                    {% endif %}

                    {# Max Payment Discount #}

                    {% set hideDiscountContainer = not (hasDiscount and product.showMaxPaymentDiscount) %}
                    {% set hideDiscountDisclaimer = not product.showMaxPaymentDiscountNotCombinableDisclaimer %}

                    <span class="js-product-discount-container col-12 mb-2" {% if hideDiscountContainer %}style="display: none;"{% endif %}>
                        <span class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</span> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}
                        <div class="js-product-discount-disclaimer font-small mt-1" {% if hideDiscountDisclaimer %}style="display: none;"{% endif %}>
                            {{ "No acumulable con otras promociones" | translate }}
                        </div>
                    </span>

                    <a id="btn-installments" class="btn-link font-small col mt-1" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                        <span class="d-table">
                            {% if not hasDiscount and not settings.product_detail_installments %}
                                <svg class="icon-inline icon-lg svg-icon-primary mr-1"><use xlink:href="#credit-card"/></svg>
                            {{ "Ver medios de pago" | translate }}
                                {% else %}
                                {{ "Ver más detalles" | translate }}
                            {% endif %}
                        </span>
                    </a>
                </div>
            </div>
        </div>
    {% endif %}

    {# Define contitions to show shipping calculator and store branches on product page #}

    {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

    {% if show_product_fulfillment and not home_main_product %}

        {# Shipping calculator and branch link #}

        <div id="product-shipping-container" class="product-shipping-calculator list w-100" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
            {% if store.has_shipping %}
                {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
            {% endif %}
        </div>

        {% if store.branches %}
            {# Link for branches #}
            {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
        {% endif %}

    {% endif %}

 </form>
  

{% if not home_main_product %}
    {# Product payments details #}

    {% include 'snipplets/product/product-payment-details.tpl' %}
{% endif %}
