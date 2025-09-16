{% if product.variations and product.variants %}
    {% set has_size_variants = false %}
    {% set size_variation_id = null %}
    {% set size_options = [] %}

    {# Check if product has size variations #}
    {% for variation in product.variations %}
        {% if variation.name in ['Talle', 'Talla', 'Tamanho', 'Size'] %}
            {% set has_size_variants = true %}
            {% set size_variation_id = variation.id %}
            {% set size_options = variation.options %}
        {% endif %}
    {% endfor %}

    {% if has_size_variants and size_options | length > 1 %}
        {% if mobile_version %}
            {# Mobile version - always visible in description area #}
            <div class="js-item-sizes-container item-sizes-container item-sizes-container-mobile"
                 data-variants="{{ product.variants_object | json_encode }}"
                 data-size-variation-id="{{ size_variation_id }}"
                 data-deployed="mobile-v2024"
                 data-debug-variants="{{ product.variants | json_encode }}"
                 data-debug-options="{{ size_options | json_encode }}">
                <div class="item-sizes-overlay item-sizes-overlay-mobile">
        {% else %}
            {# Desktop version - floating overlay #}
            <div class="js-item-sizes-container item-sizes-container"
                 data-variants="{{ product.variants_object | json_encode }}"
                 data-size-variation-id="{{ size_variation_id }}"
                 data-deployed="floating-elements-v2024"
                 data-debug-variants="{{ product.variants | json_encode }}"
                 data-debug-options="{{ size_options | json_encode }}">
                <div class="item-sizes-overlay">
        {% endif %}
                <div class="item-sizes-grid">
                    {% for size_option in size_options %}
                        {% for variant in product.variants %}
                            {% if variant.option0 == size_option.name or variant.option1 == size_option.name or variant.option2 == size_option.name %}
                                {% set size_variant_available = variant.stock > 0 %}

                                <button
                                    type="button"
                                    class="js-size-variant-add item-size-btn{% if not size_variant_available %} item-size-btn-disabled{% endif %}"
                                    data-product-id="{{ product.id }}"
                                    data-variant-id="{{ variant.id }}"
                                    data-variation-id="{{ size_variation_id }}"
                                    data-option-name="{{ size_option.name }}"
                                    data-size-name="{{ size_option.name }}"
                                    data-stock="{{ variant.stock }}"
                                    data-available="{{ size_variant_available ? 'true' : 'false' }}"
                                    {% if not size_variant_available %}disabled{% endif %}
                                    title="{% if size_variant_available %}{{ size_option.name }} - {{ variant.stock }} disponible{% else %}{{ size_option.name }} - Sin stock{% endif %}">
                                    {{ size_option.name }}
                                </button>
                            {% endif %}
                        {% endfor %}
                    {% endfor %}
                </div>
            </div>
            
            {# Loading state placeholder #}
            <div class="js-size-variant-loading item-sizes-loading" style="display: none;">
                <div class="item-sizes-loading-content">
                    <div class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></div>
                    <span class="sr-only">{{ 'Agregando al carrito...' | translate }}</span>
                </div>
            </div>
        </div>
    {% endif %}
{% endif %}