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
             data-size-variation-id="{{ size_variation_id }}"
             data-deployed="floating-elements-v2024"
             data-debug-variants="{{ product.variants | json_encode }}"
             data-debug-options="{{ size_options | json_encode }}">
            <div class="item-sizes-overlay">
                <div class="item-sizes-grid">
                    {% for option in size_options | slice(0, 8) %}
                        {% set size_variant_available = false %}
                        {% set size_variant_id = null %}
                        {% set size_variant_stock = 0 %}
                        
                        {# Find matching variant for this size option #}
                        {% for variant in product.variants %}
                            {% if not size_variant_available %}
                                {# Check all option positions for size match #}
                                {% if variant.option0 == option.name or variant.option1 == option.name or variant.option2 == option.name %}
                                    {% set size_variant_available = variant.available and variant.stock > 0 %}
                                    {% set size_variant_id = variant.id %}
                                    {% set size_variant_stock = variant.stock %}
                                {% endif %}
                            {% endif %}
                        {% endfor %}
                        
                        <button 
                            type="button" 
                            class="js-size-variant-add item-size-btn{% if not size_variant_available %} item-size-btn-disabled{% endif %}" 
                            data-product-id="{{ product.id }}"
                            data-variant-id="{{ size_variant_id }}"
                            data-variation-id="{{ size_variation_id }}"
                            data-option-name="{{ option.name }}"
                            data-size-name="{{ option.name }}"
                            data-stock="{{ size_variant_stock }}"
                            data-available="{{ size_variant_available ? 'true' : 'false' }}"
                            {% if not size_variant_available %}disabled{% endif %}
                            title="{% if size_variant_available %}{{ option.name }} - {{ size_variant_stock }} disponible{% else %}{{ option.name }} - Sin stock (DEBUG: option={{ option.name }}){% endif %}">
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