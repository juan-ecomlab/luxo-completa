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
        <div class="js-item-sizes-container item-sizes-container" 
             data-variants="{{ product.variants_object | json_encode }}"
             data-size-variation-id="{{ size_variation_id }}">
            <div class="item-sizes-overlay">
                <div class="item-sizes-grid">
                    {% for option in size_options | slice(0, 8) %}
                        {% set size_variant_available = false %}
                        {% set size_variant_id = null %}
                        {% set size_variant_stock = 0 %}
                        
                        {# Find matching variant for this size option #}
                        {% for variant in product.variants %}
                            {% if variant.option_values[size_variation_id] == option.id and variant.available and variant.stock > 0 and not size_variant_available %}
                                {% set size_variant_available = true %}
                                {% set size_variant_id = variant.id %}
                                {% set size_variant_stock = variant.stock %}
                            {% endif %}
                        {% endfor %}
                        
                        <button 
                            type="button" 
                            class="js-size-variant-add item-size-btn{% if not size_variant_available %} item-size-btn-disabled{% endif %}" 
                            data-product-id="{{ product.id }}"
                            data-variant-id="{{ size_variant_id }}"
                            data-variation-id="{{ size_variation_id }}"
                            data-option-id="{{ option.id }}"
                            data-size-name="{{ option.name }}"
                            data-stock="{{ size_variant_stock }}"
                            {% if not size_variant_available %}disabled{% endif %}
                            title="{% if size_variant_available %}{{ 'Agregar talle' | translate }} {{ option.name }} ({{ size_variant_stock }} {{ 'disponible' | translate }}){% else %}{{ 'Sin stock' | translate }}{% endif %}"
                            aria-label="{% if size_variant_available %}{{ 'Agregar al carrito talle' | translate }} {{ option.name }}{% else %}{{ 'Talle' | translate }} {{ option.name }} {{ 'sin stock' | translate }}{% endif %}">
                            {{ option.name }}
                        </button>
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