# Guía de Estilos y Arquitectura - Tema Luxo

Esta guía completa documenta la arquitectura técnica, sistema de estilos y convenciones de desarrollo del tema Luxo para Nuvemshop/TiendaNube.

## Índice
1. [Arquitectura del Tema](#arquitectura-del-tema)
2. [Sistema de Templates](#sistema-de-templates)
3. [Arquitectura CSS](#arquitectura-css)
4. [Sistema de Grillas y Diseño Responsive](#sistema-de-grillas-y-diseño-responsive)
5. [Selector de Talles Hover](#selector-de-talles-hover)
6. [Sistema de Configuración](#sistema-de-configuración)
7. [Arquitectura JavaScript](#arquitectura-javascript)
8. [Optimizaciones de Performance](#optimizaciones-de-performance)
9. [Personalizaciones de Estilo](#personalizaciones-de-estilo)
10. [Convenciones de Desarrollo](#convenciones-de-desarrollo)

## Arquitectura del Tema

### Estructura de Directorios
```
luxo-completa/
├── config/           # Configuración del tema
├── layouts/          # Template principal
├── templates/        # Templates de páginas
├── snipplets/        # Componentes reutilizables
├── static/          # CSS y JS
└── assets/          # Archivos CSS adicionales
```

## Sistema de Templates

### Jerarquía de Templates (3 Niveles)

#### 1. Layout Principal (`/layouts/layout.tpl`)
- Template maestro con estructura HTML
- Carga de CSS crítico y asíncrono
- Inclusión de scripts y meta tags

#### 2. Templates de Página (`/templates/`)
- `home.tpl`: Página principal
- `product.tpl`: Detalle de producto
- `category.tpl`: Listado de categorías
- `cart.tpl`: Carrito de compras
- `search.tpl`: Resultados de búsqueda

#### 3. Componentes (`/snipplets/`)
Organizados por funcionalidad:
```
snipplets/
├── header/          # Navegación, logo, búsqueda
├── footer/          # Componentes del pie
├── home/           # Secciones del home
├── product/        # Componentes de producto
├── grid/           # Listados y filtros
│   ├── item.tpl           # Item de producto
│   ├── item-colors.tpl    # Selector de colores
│   ├── item-sizes.tpl     # Selector de talles (hover)
│   └── quick-shop.tpl     # Compra rápida
├── forms/          # Componentes de formularios
├── navigation/     # Menús y navegación
└── svg/            # Iconos SVG
```

## Arquitectura CSS

### Sistema de 3 Capas para Performance

#### 1. CSS Crítico (`static/css/style-critical.scss`)
- **Carga**: Inline en el layout
- **Contenido**: Estilos above-the-fold
- **Elementos**: Grid, tipografía, botones, formularios, item de producto
- **Tamaño objetivo**: < 50KB

#### 2. CSS Asíncrono (`static/css/style-async.scss`)
- **Carga**: Asíncrona después del page load
- **Contenido**: Estilos no críticos
- **Elementos**: Modales, tooltips, animaciones, sliders

#### 3. Sistema de Colores (`static/css/style-colors.scss`)
- **Carga**: Inline después del CSS crítico
- **Contenido**: Variables de color dinámicas
- **Fuente**: Configuración del usuario en `settings.txt`

### Tokens CSS (`static/css/style-tokens.tpl`)
```css
:root {
  /* Colores principales */
  --main-foreground: {{ main_foreground }};
  --main-background: {{ main_background }};
  --accent-color: {{ accent_color }};
  
  /* Colores con opacidad */
  --main-foreground-opacity-10: {{ main_foreground }}1A;
  --main-foreground-opacity-30: {{ main_foreground }}4D;
  
  /* Tipografía */
  --heading-font: {{ settings.font_headings }};
  --body-font: {{ settings.font_rest }};
  
  /* Tamaños */
  --font-base: {{ font_rest_size }}px;
  --h1: {{ heading_size }}px;
}
```

## Sistema de Grillas y Diseño Responsive

### Basado en Bootstrap Grid v4.1.3

#### Breakpoints
- **Mobile**: < 768px
- **Desktop**: ≥ 768px (md)

#### Clases de Columnas
```html
<!-- Mobile: 2 columnas, Desktop: 4 columnas -->
<div class="col-6 col-md-3">...</div>

<!-- Oculto en mobile, visible en desktop -->
<div class="d-none d-md-block">...</div>
```

#### Configuración de Grilla de Productos
- **Mobile**: 1, 2 o 3 columnas (configurable)
- **Desktop**: 2, 3 o 4 columnas (configurable)

## Selector de Talles Hover

### Implementación Completa

#### 1. Estructura HTML (`snipplets/grid/item-sizes.tpl`)
```twig
{% if has_size_variants and size_options | length > 1 %}
    <div class="js-item-sizes-container item-sizes-container">
        <div class="item-sizes-overlay">
            <div class="item-sizes-grid">
                {% for option in size_options | slice(0, 8) %}
                    <button class="js-size-variant-add item-size-btn">
                        {{ option.name }}
                    </button>
                {% endfor %}
            </div>
        </div>
    </div>
{% endif %}
```

#### 2. Estilos CSS (`style-critical.scss`)
```scss
/* Contenedor principal */
.item-sizes-container {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 9;
    opacity: 0;
    visibility: hidden;
    transition: opacity 0.3s ease, visibility 0.3s ease;
    pointer-events: none;
}

/* Activación en hover */
.item:hover .item-sizes-container {
    opacity: 1;
    visibility: visible;
    pointer-events: auto;
}

/* Grid de talles */
.item-sizes-grid {
    display: flex;
    flex-wrap: nowrap;
    gap: 4px;
    justify-content: center;
}

/* Botones de talle */
.item-size-btn {
    min-width: 32px;
    height: 32px;
    padding: 4px 8px;
    background: white;
    border: 1px solid #ddd;
    font-size: 12px;
    cursor: pointer;
    transition: all 0.2s ease;
    
    &:hover {
        border-color: #333;
        background: #f5f5f5;
    }
    
    &-disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }
}
```

#### 3. JavaScript (`store.js.tpl`)
```javascript
// Agregar talle al carrito
jQueryNuvem(document).on("click", ".js-size-variant-add", function(e) {
    e.preventDefault();
    e.stopPropagation();
    
    var $button = jQueryNuvem(this);
    var productId = $button.data('product-id');
    var variantId = $button.data('variant-id');
    
    // Mostrar loading
    $button.closest('.js-item-sizes-container')
        .find('.js-size-variant-loading').show();
    
    // Agregar al carrito vía AJAX
    jQueryNuvem.post("{{ store.cart_url }}", {
        'add_to_cart': productId,
        'variant': variantId
    })
    .done(function(data) {
        // Mostrar notificación de éxito
        showCartNotification();
    })
    .fail(function() {
        // Manejar error
    });
});
```

### Detección de Variantes de Talle
```twig
{% for variation in product.variations %}
    {% if variation.name in ['Talle', 'Talla', 'Tamanho', 'Size'] %}
        {% set has_size_variants = true %}
        {% set size_variation_id = variation.id %}
        {% set size_options = variation.options %}
    {% endif %}
{% endfor %}
```

### Verificación de Stock
```twig
{% for variant in product.variants %}
    {% if variant.available and variant.stock > 0 %}
        {% if variant.option0 == option.name %}
            {% set size_variant_available = true %}
            {% set size_variant_id = variant.id %}
        {% endif %}
    {% endif %}
{% endfor %}
```

## Sistema de Configuración

### Archivos de Configuración

#### `config/settings.txt`
Define opciones configurables por el usuario:
```
checkbox
    name = product_size_hover_selector
    description = Mostrar selector de talles al pasar el mouse
```

#### `config/defaults.txt`
Valores por defecto:
```
product_size_hover_selector = 1
grid_columns_desktop = 3
grid_columns_mobile = 2
```

#### `config/translations.txt`
Soporte multi-idioma:
```
es "Agregar al carrito"
en "Add to cart"
pt "Adicionar ao carrinho"
```

## Arquitectura JavaScript

### Estructura y Organización

#### Inicialización
```javascript
DOMContentLoaded.addEventOrExecute(() => {
    // Código que se ejecuta cuando el DOM está listo
});
```

#### Integración con TiendaNube
```javascript
// Variables globales de la tienda
window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url }}"
}

// jQuery de TiendaNube
jQueryNuvem(document).ready(function() {
    // Código jQuery
});

// APIs de TiendaNube
LS.ready.then(function() {
    // Código que requiere las librerías de TiendaNube
});
```

### Funciones Principales
1. **Lazy Load**: Carga diferida de imágenes
2. **Cart Operations**: Agregar/quitar del carrito
3. **Product Variants**: Cambio de variantes
4. **Quickshop**: Compra rápida
5. **Filters**: Filtros de productos
6. **Infinite Scroll**: Scroll infinito

## Optimizaciones de Performance

### Critical Path Rendering
1. **CSS crítico inline**: Renderizado instantáneo
2. **CSS asíncrono**: Carga no bloqueante
3. **Fuentes preload**: Carga anticipada
4. **Imágenes lazy load**: Carga bajo demanda

### Optimización de Imágenes
```html
<!-- Imágenes responsivas -->
<img 
    class="lazyload"
    data-sizes="auto"
    data-srcset="
        {{ product | img_url('small') }} 240w,
        {{ product | img_url('medium') }} 320w,
        {{ product | img_url('large') }} 480w
    "
    alt="{{ product.name }}"
/>
```

### Viewport-based Sizing
```twig
{% if columns_mobile == 3 %}
    {% set mobile_image_viewport_space = '33' %}
{% elseif columns_mobile == 2 %}
    {% set mobile_image_viewport_space = '50' %}
{% else %}
    {% set mobile_image_viewport_space = '100' %}
{% endif %}
```

## Personalizaciones de Estilo

### Diferencia entre CSS y SCSS

**CSS** es el lenguaje estándar para estilos web. **SCSS** es una extensión que permite variables, anidación y funciones avanzadas.

### Opciones para Agregar Estilos

#### Opción 1: Panel de Administración (CSS solamente)
- **Ubicación**: Admin → Diseñar tienda → CSS personalizado
- **Formato**: Solo CSS tradicional
- **Ideal para**: Cambios puntuales y rápidos

#### Opción 2: Archivos SCSS (Recomendado)
- **Ubicación**: Admin → Diseñar tienda → Editar código → Carpeta "static"
- **Archivos**: `style-critical.scss`, `style-async.scss`, `style-colors.scss`
- **Ideal para**: Personalizaciones extensas y organizadas

### Ejemplo de Sintaxis

**CSS tradicional:**
```css
.product-item { border: 1px solid #eee; }
.product-item:hover { transform: scale(1.05); }
```

**SCSS (más potente):**
```scss
$border-color: #eee;
.product-item {
    border: 1px solid $border-color;
    &:hover { transform: scale(1.05); }
}
```

## 1. Homepage (Página de Inicio)

### Estructura de Archivos CSS/SCSS

#### Archivos principales:
- **`static/style-critical.scss`**: Header, navbar, slider above-the-fold
- **`static/style-async.scss`**: Secciones de productos, categorías, footer
- **`static/style-colors.scss`**: Variables de colores personalizables

### Ajustes desde Diseñador Web
- **Acceso**: Panel Admin → Diseñar tienda → Personalizar
- **Secciones disponibles**: Slider, Categorías destacadas, Productos destacados, Banners, Video, Newsletter
- **Colores**: Configuración de paleta de colores principal y secundaria
- **Tipografía**: Selección de fuentes para títulos y texto

### Componentes Estructurales y Sus Estilos

#### Header y Navegación
**Archivo TPL**: `snipplets/header/header.tpl`
**CSS/SCSS**: `static/style-critical.scss`
**Clases principales**: `.header`, `.navbar`, `.nav-item`, `.logo`

```scss
// En style-critical.scss
.header {
    background: white;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
    
    .navbar {
        padding: 1rem 0;
        
        .nav-item {
            margin: 0 1rem;
            
            .nav-link {
                color: #333;
                font-weight: 500;
                transition: color 0.3s;
                
                &:hover {
                    color: var(--primary-color);
                }
            }
        }
    }
    
    .logo {
        max-height: 60px;
        width: auto;
    }
}
```

#### Slider Principal
**Archivo TPL**: `snipplets/home/home-slider.tpl`
**CSS/SCSS**: `static/style-critical.scss` (above-the-fold)
**Clases principales**: `.home-slider`, `.swiper-slide`, `.slider-content`

```scss
// En style-critical.scss
.home-slider {
    height: 70vh;
    min-height: 500px;
    position: relative;
    
    .swiper-slide {
        background-size: cover;
        background-position: center;
        display: flex;
        align-items: center;
        
        .slider-content {
            max-width: 600px;
            padding: 2rem;
            
            .slider-title {
                font-size: 3rem;
                font-weight: 700;
                color: white;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 1rem;
                
                @media (max-width: 768px) {
                    font-size: 2rem;
                }
            }
            
            .slider-subtitle {
                font-size: 1.2rem;
                color: rgba(255,255,255,0.9);
                margin-bottom: 2rem;
            }
            
            .slider-btn {
                padding: 15px 30px;
                font-weight: 600;
                border-radius: 25px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
        }
    }
    
    // Navegación del slider
    .swiper-pagination-bullet {
        background: white;
        opacity: 0.7;
        
        &.swiper-pagination-bullet-active {
            opacity: 1;
            background: var(--primary-color);
        }
    }
}
```

#### Sección de Categorías
**Archivo TPL**: `snipplets/home/home-categories.tpl`
**CSS/SCSS**: `static/style-async.scss`
**Clases principales**: `.home-categories`, `.category-item`, `.category-image`

```scss
// En style-async.scss
.home-categories {
    padding: 4rem 0;
    background: #f8f9fa;
    
    .section-title {
        text-align: center;
        font-size: 2.5rem;
        margin-bottom: 3rem;
        color: #333;
        
        &::after {
            content: '';
            display: block;
            width: 80px;
            height: 3px;
            background: var(--primary-color);
            margin: 1rem auto;
        }
    }
    
    .category-item {
        margin-bottom: 2rem;
        text-align: center;
        transition: transform 0.3s ease;
        
        &:hover {
            transform: translateY(-10px);
        }
        
        .category-image {
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            
            img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }
            
            &:hover img {
                transform: scale(1.1);
            }
            
            .category-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.3);
                opacity: 0;
                transition: opacity 0.3s;
                
                &:hover {
                    opacity: 1;
                }
            }
        }
        
        .category-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-top: 1rem;
            color: #333;
        }
        
        .category-count {
            color: #666;
            font-size: 0.9rem;
        }
    }
}
```

#### Productos Destacados
**Archivo TPL**: `snipplets/home/home-products.tpl`
**CSS/SCSS**: `static/style-async.scss`
**Clases principales**: `.home-products`, `.product-item`, `.product-image`

```scss
// En style-async.scss
.home-products {
    padding: 4rem 0;
    
    .product-item {
        border: 1px solid #eee;
        border-radius: 12px;
        padding: 1rem;
        transition: all 0.3s ease;
        background: white;
        height: 100%;
        
        &:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border-color: var(--primary-color);
        }
        
        .product-image {
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            margin-bottom: 1rem;
            
            img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }
            
            &:hover img {
                transform: scale(1.05);
            }
            
            .product-badge {
                position: absolute;
                top: 10px;
                left: 10px;
                background: var(--primary-color);
                color: white;
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: bold;
            }
        }
        
        .product-info {
            text-align: center;
            
            .product-title {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: #333;
                
                &:hover {
                    color: var(--primary-color);
                }
            }
            
            .product-price {
                font-size: 1.2rem;
                font-weight: 700;
                color: var(--primary-color);
                
                .price-compare {
                    font-size: 1rem;
                    text-decoration: line-through;
                    color: #999;
                    margin-right: 10px;
                }
            }
        }
    }
}
```

#### Newsletter
**Archivo TPL**: `snipplets/home/home-newsletter.tpl`
**CSS/SCSS**: `static/style-async.scss`
**Clases principales**: `.home-newsletter`, `.newsletter-form`

```scss
// En style-async.scss
.home-newsletter {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 80px 0;
    position: relative;
    
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('pattern.png') repeat;
        opacity: 0.1;
    }
    
    .newsletter-content {
        position: relative;
        z-index: 2;
        text-align: center;
        color: white;
        
        .newsletter-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .newsletter-subtitle {
            font-size: 1.2rem;
            margin-bottom: 3rem;
            opacity: 0.9;
        }
    }
    
    .newsletter-form {
        max-width: 500px;
        margin: 0 auto;
        display: flex;
        background: white;
        border-radius: 50px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        
        .form-control {
            border: none;
            padding: 18px 25px;
            font-size: 1rem;
            flex: 1;
            
            &:focus {
                outline: none;
                box-shadow: none;
            }
        }
        
        .btn {
            border: none;
            padding: 18px 30px;
            background: var(--primary-color);
            color: white;
            font-weight: 600;
            white-space: nowrap;
            
            &:hover {
                background: darken(var(--primary-color), 10%);
            }
        }
    }
}
```

## 2. Collection Listing (Listado de Productos)

### Estructura de Archivos CSS/SCSS

#### Archivos principales:
- **`static/style-critical.scss`**: Header de categoría, breadcrumbs
- **`static/style-async.scss`**: Grilla de productos, filtros, paginación
- **`static/style-colors.scss`**: Variables de colores para filtros y estados

### Ajustes desde Diseñador Web
- **Vista de grilla**: 2, 3 o 4 columnas
- **Filtros laterales**: Activar/desactivar filtros por precio, marca, etc.
- **Ordenamiento**: Opciones de ordenamiento disponibles

### Componentes Estructurales y Sus Estilos

#### Header de Categoría y Breadcrumbs
**Archivo TPL**: `templates/category.tpl`
**CSS/SCSS**: `static/style-critical.scss`
**Clases principales**: `.category-header`, `.breadcrumbs`, `.category-title`

```scss
// En style-critical.scss
.category-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    padding: 3rem 0;
    margin-bottom: 2rem;
    
    .breadcrumbs {
        margin-bottom: 1rem;
        
        .breadcrumb {
            background: transparent;
            padding: 0;
            
            .breadcrumb-item {
                color: #666;
                
                &.active {
                    color: var(--primary-color);
                    font-weight: 600;
                }
                
                a {
                    color: #666;
                    text-decoration: none;
                    
                    &:hover {
                        color: var(--primary-color);
                    }
                }
                
                &::before {
                    content: '>';
                    color: #ccc;
                    margin: 0 10px;
                }
            }
        }
    }
    
    .category-title {
        font-size: 2.5rem;
        font-weight: 700;
        color: #333;
        margin-bottom: 1rem;
    }
    
    .category-description {
        font-size: 1.1rem;
        color: #666;
        max-width: 600px;
    }
}
```

#### Barra de Filtros y Ordenamiento
**Archivo TPL**: `snipplets/grid/sort-by.tpl`
**CSS/SCSS**: `static/style-async.scss`
**Clases principales**: `.filters-bar`, `.sort-by`, `.results-count`

```scss
// En style-async.scss
.filters-bar {
    background: white;
    padding: 1.5rem;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    margin-bottom: 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
    
    .results-count {
        color: #666;
        font-size: 0.95rem;
        
        strong {
            color: var(--primary-color);
            font-weight: 600;
        }
    }
    
    .filter-controls {
        display: flex;
        gap: 1rem;
        align-items: center;
        
        .filter-toggle {
            background: none;
            border: 1px solid #ddd;
            padding: 8px 15px;
            border-radius: 20px;
            color: #666;
            font-size: 0.9rem;
            cursor: pointer;
            
            &:hover, &.active {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
            
            i {
                margin-right: 5px;
            }
        }
    }
    
    .sort-by {
        .sort-select {
            border: 1px solid #ddd;
            border-radius: 20px;
            padding: 8px 15px;
            background: white;
            color: #666;
            font-size: 0.9rem;
            min-width: 150px;
            
            &:focus {
                outline: none;
                border-color: var(--primary-color);
            }
        }
    }
    
    .view-modes {
        display: flex;
        gap: 5px;
        
        .view-btn {
            width: 35px;
            height: 35px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #666;
            
            &:hover, &.active {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
        }
    }
}
```

#### Layout de Grilla de Productos
**Archivo TPL**: `snipplets/grid/item-grid.tpl`
**CSS/SCSS**: `static/style-async.scss`
**Clases principales**: `.item-grid`, `.item`, `.item-image`, `.item-info`

```scss
// En style-async.scss
.products-grid {
    display: grid;
    gap: 2rem;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    
    &.grid-2 { grid-template-columns: repeat(2, 1fr); }
    &.grid-3 { grid-template-columns: repeat(3, 1fr); }
    &.grid-4 { grid-template-columns: repeat(4, 1fr); }
    
    @media (max-width: 768px) {
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }
    
    @media (max-width: 480px) {
        grid-template-columns: 1fr;
    }
}

.item-grid {
    .item {
        border: 1px solid #f0f0f0;
        border-radius: 12px;
        overflow: hidden;
        transition: all 0.3s ease;
        background: white;
        position: relative;
        height: 100%;
        display: flex;
        flex-direction: column;
        
        &:hover {
            border-color: var(--primary-color);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            transform: translateY(-5px);
        }
        
        .item-image {
            position: relative;
            overflow: hidden;
            aspect-ratio: 1;
            
            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease;
            }
            
            &:hover img {
                transform: scale(1.08);
            }
            
            .item-labels {
                position: absolute;
                top: 10px;
                left: 10px;
                z-index: 2;
                
                .label {
                    display: block;
                    background: var(--primary-color);
                    color: white;
                    padding: 4px 10px;
                    border-radius: 12px;
                    font-size: 0.8rem;
                    font-weight: bold;
                    margin-bottom: 5px;
                    
                    &.label-sale {
                        background: #e74c3c;
                    }
                    
                    &.label-new {
                        background: #27ae60;
                    }
                }
            }
            
            .item-actions {
                position: absolute;
                top: 10px;
                right: 10px;
                opacity: 0;
                transition: opacity 0.3s ease;
                
                .action-btn {
                    width: 35px;
                    height: 35px;
                    background: white;
                    border: none;
                    border-radius: 50%;
                    margin-bottom: 5px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    color: #666;
                    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                    
                    &:hover {
                        background: var(--primary-color);
                        color: white;
                    }
                }
            }
            
            &:hover .item-actions {
                opacity: 1;
            }
        }
        
        .item-info {
            padding: 1.2rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            
            .item-title {
                font-size: 1rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: #333;
                line-height: 1.3;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                
                a {
                    color: inherit;
                    text-decoration: none;
                    
                    &:hover {
                        color: var(--primary-color);
                    }
                }
            }
            
            .item-description {
                font-size: 0.9rem;
                color: #666;
                margin-bottom: 1rem;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            
            .item-price {
                margin-top: auto;
                
                .price {
                    font-size: 1.2rem;
                    font-weight: 700;
                    color: var(--primary-color);
                }
                
                .price-compare {
                    font-size: 1rem;
                    text-decoration: line-through;
                    color: #999;
                    margin-right: 10px;
                }
                
                .price-discount {
                    font-size: 0.8rem;
                    color: #e74c3c;
                    font-weight: 600;
                }
            }
            
            .item-colors {
                margin-top: 0.5rem;
                display: flex;
                gap: 5px;
                
                .color-option {
                    width: 18px;
                    height: 18px;
                    border-radius: 50%;
                    border: 2px solid #fff;
                    box-shadow: 0 0 0 1px #ddd;
                    cursor: pointer;
                    
                    &:hover {
                        transform: scale(1.2);
                    }
                }
            }
        }
    }
}
```

#### Filtros Laterales
**Archivo TPL**: `snipplets/grid/filters.tpl`
**CSS/SCSS**: `static/style-async.scss`
**Clases principales**: `.filters-sidebar`, `.filter-group`, `.filter-option`

```scss
// En style-async.scss
.filters-sidebar {
    background: white;
    border-radius: 12px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    padding: 2rem;
    position: sticky;
    top: 120px;
    max-height: calc(100vh - 140px);
    overflow-y: auto;
    
    .filters-title {
        font-size: 1.3rem;
        font-weight: 700;
        margin-bottom: 2rem;
        color: #333;
        display: flex;
        align-items: center;
        justify-content: space-between;
        
        .clear-filters {
            font-size: 0.9rem;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            
            &:hover {
                text-decoration: underline;
            }
        }
    }
    
    .filter-group {
        margin-bottom: 2rem;
        border-bottom: 1px solid #f0f0f0;
        padding-bottom: 1.5rem;
        
        &:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        
        .filter-title {
            font-weight: 600;
            margin-bottom: 1rem;
            color: #333;
            font-size: 1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
            
            &::after {
                content: '−';
                font-size: 1.2rem;
                transition: transform 0.3s ease;
            }
            
            &.collapsed::after {
                transform: rotate(90deg);
                content: '+';
            }
        }
        
        .filter-options {
            max-height: 200px;
            overflow-y: auto;
            
            &::-webkit-scrollbar {
                width: 4px;
            }
            
            &::-webkit-scrollbar-thumb {
                background: #ddd;
                border-radius: 2px;
            }
        }
        
        .filter-option {
            display: flex;
            align-items: center;
            padding: 0.5rem 0;
            
            input[type="checkbox"],
            input[type="radio"] {
                margin-right: 10px;
                cursor: pointer;
            }
            
            label {
                cursor: pointer;
                color: #666;
                font-size: 0.95rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 100%;
                
                &:hover {
                    color: var(--primary-color);
                }
                
                .filter-count {
                    font-size: 0.8rem;
                    color: #999;
                    background: #f0f0f0;
                    padding: 2px 6px;
                    border-radius: 10px;
                }
            }
        }
        
        // Filtro de precio especial
        &.price-filter {
            .price-range {
                margin-top: 1rem;
                
                .price-inputs {
                    display: flex;
                    gap: 10px;
                    margin-bottom: 1rem;
                    
                    input {
                        flex: 1;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        padding: 8px 10px;
                        font-size: 0.9rem;
                        
                        &:focus {
                            outline: none;
                            border-color: var(--primary-color);
                        }
                    }
                }
                
                .price-slider {
                    margin-top: 1rem;
                    height: 6px;
                    background: #f0f0f0;
                    border-radius: 3px;
                    position: relative;
                    
                    .slider-track {
                        height: 100%;
                        background: var(--primary-color);
                        border-radius: 3px;
                    }
                }
            }
        }
    }
}
```

#### Paginación
**Archivo TPL**: `snipplets/grid/pagination.tpl`
**CSS/SCSS**: `static/style-async.scss`
**Clases principales**: `.pagination`, `.page-link`

```scss
// En style-async.scss
.pagination-container {
    margin-top: 4rem;
    text-align: center;
    
    .pagination {
        display: inline-flex;
        gap: 5px;
        background: white;
        padding: 1rem;
        border-radius: 50px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        
        .page-item {
            .page-link {
                border: none;
                color: #666;
                padding: 12px 16px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                min-width: 44px;
                text-align: center;
                
                &:hover {
                    background: var(--primary-color);
                    color: white;
                    transform: translateY(-2px);
                }
                
                &.active {
                    background: var(--primary-color);
                    color: white;
                }
            }
            
            &.disabled .page-link {
                color: #ccc;
                cursor: not-allowed;
                
                &:hover {
                    background: transparent;
                    transform: none;
                }
            }
        }
    }
    
    .load-more {
        margin-top: 2rem;
        
        .btn-load-more {
            background: white;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            padding: 15px 30px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            
            &:hover {
                background: var(--primary-color);
                color: white;
            }
        }
    }
}
```

## 3. Product Page (Página de Producto)

### Ajustes desde Diseñador Web
- **Layout**: Imágenes a la izquierda o derecha
- **Galería de imágenes**: Mostrar miniaturas abajo o al lado
- **Información de envío**: Mostrar calculadora de envío
- **Productos relacionados**: Cantidad y disposición

### Modificaciones por Código

#### Layout General
**Archivo**: `templates/product.tpl`

```scss
// Estructura de página de producto
.product-detail {
    .product-images {
        position: sticky;
        top: 100px; // Hace que las imágenes sigan al scroll
    }
    
    .product-info {
        padding-left: 3rem;
        
        @media (max-width: 768px) {
            padding-left: 0;
            margin-top: 2rem;
        }
    }
}
```

#### Galería de Imágenes
**Archivo**: `snipplets/product/product-image.tpl`

```scss
// Personalizar galería de imágenes
.product-slider {
    margin-bottom: 1rem;
    
    .swiper-slide img {
        width: 100%;
        height: 500px;
        object-fit: cover;
        border-radius: 10px;
    }
    
    // Navegación del slider
    .swiper-button-next,
    .swiper-button-prev {
        color: var(--primary-color);
        background: white;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
}

// Miniaturas
.product-thumbs {
    .swiper-slide {
        cursor: pointer;
        opacity: 0.6;
        border-radius: 8px;
        overflow: hidden;
        
        &.swiper-slide-thumb-active {
            opacity: 1;
            border: 2px solid var(--primary-color);
        }
    }
}
```

#### Información del Producto
**Archivo**: `snipplets/product/product-form.tpl`

```scss
// Título y precio
.product-title {
    font-size: 2rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #333;
}

.product-price {
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--primary-color);
    margin-bottom: 1rem;
    
    .price-compare {
        font-size: 1.2rem;
        text-decoration: line-through;
        color: #999;
        margin-left: 10px;
    }
}

// Variantes (colores, talles)
.product-variants {
    margin: 2rem 0;
    
    .variant-label {
        font-weight: 600;
        margin-bottom: 0.5rem;
        display: block;
    }
    
    .variant-option {
        display: inline-block;
        margin: 5px 10px 5px 0;
        
        input[type="radio"] {
            display: none;
            
            &:checked + label {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
        }
        
        label {
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            
            &:hover {
                border-color: var(--primary-color);
            }
        }
    }
}

// Botón de compra
.product-form .btn-primary {
    width: 100%;
    padding: 15px;
    font-size: 1.1rem;
    font-weight: 600;
    border-radius: 8px;
    margin-top: 1rem;
}
```

#### Descripción y Tabs
**Archivo**: `snipplets/product/product-description.tpl`

```scss
// Tabs de información
.product-tabs {
    margin-top: 3rem;
    
    .nav-tabs {
        border-bottom: 2px solid #f0f0f0;
        
        .nav-link {
            border: none;
            color: #666;
            font-weight: 600;
            padding: 15px 25px;
            
            &.active {
                color: var(--primary-color);
                border-bottom: 2px solid var(--primary-color);
            }
        }
    }
    
    .tab-content {
        padding: 2rem 0;
        
        .tab-pane {
            line-height: 1.6;
            color: #555;
        }
    }
}
```

#### Productos Relacionados
**Archivo**: `snipplets/product/product-related.tpl`

```scss
// Sección de productos relacionados
.product-related {
    margin-top: 4rem;
    padding-top: 3rem;
    border-top: 1px solid #eee;
    
    .section-title {
        text-align: center;
        font-size: 1.8rem;
        margin-bottom: 2rem;
        color: #333;
    }
    
    .related-slider {
        .swiper-slide {
            height: auto;
        }
    }
}
```

## 4. Static Pages (Páginas Estáticas)

### Ajustes desde Diseñador Web
- **Páginas disponibles**: Nosotros, Contacto, Términos y condiciones, Política de privacidad
- **Editor de contenido**: Editor WYSIWYG para agregar contenido
- **Formulario de contacto**: Campos personalizables

### Modificaciones por Código

#### Layout de Páginas Estáticas
**Archivo**: `templates/page.tpl`

```scss
// Estructura general de páginas estáticas
.page-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 3rem 15px;
    
    .page-header {
        text-align: center;
        margin-bottom: 3rem;
        
        h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }
        
        .page-subtitle {
            font-size: 1.2rem;
            color: #666;
        }
    }
    
    .page-body {
        line-height: 1.8;
        color: #555;
        font-size: 1.1rem;
        
        h2, h3, h4 {
            color: #333;
            margin-top: 2rem;
            margin-bottom: 1rem;
        }
        
        p {
            margin-bottom: 1.5rem;
        }
        
        img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 2rem 0;
        }
    }
}
```

#### Página de Contacto
**Archivo**: `templates/page.contact.tpl`

```scss
// Formulario de contacto
.contact-form {
    background: #f8f9fa;
    padding: 3rem;
    border-radius: 10px;
    margin-top: 2rem;
    
    .form-group {
        margin-bottom: 2rem;
        
        label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 1rem;
            
            &:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(var(--primary-color-rgb), 0.25);
            }
        }
        
        textarea.form-control {
            min-height: 120px;
        }
    }
    
    .btn-submit {
        width: 100%;
        padding: 15px;
        font-size: 1.1rem;
        font-weight: 600;
    }
}

// Información de contacto
.contact-info {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    
    .contact-item {
        display: flex;
        align-items: center;
        margin-bottom: 1.5rem;
        
        .contact-icon {
            width: 50px;
            height: 50px;
            background: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            
            svg {
                width: 20px;
                height: 20px;
                fill: white;
            }
        }
        
        .contact-details {
            h4 {
                margin: 0 0 5px 0;
                color: #333;
            }
            
            p {
                margin: 0;
                color: #666;
            }
        }
    }
}
```

## Variables CSS Globales

Para mantener consistencia en todo el tema, utiliza estas variables CSS definidas en `static/style-colors.scss`:

```scss
// Colores principales (configurables desde admin)
:root {
    --primary-color: #007bff;
    --secondary-color: #6c757d;
    --success-color: #28a745;
    --danger-color: #dc3545;
    --warning-color: #ffc107;
    --info-color: #17a2b8;
    --light-color: #f8f9fa;
    --dark-color: #343a40;
    
    // Tipografía
    --font-family-primary: 'Open Sans', sans-serif;
    --font-family-secondary: 'Montserrat', sans-serif;
    
    // Espaciado
    --container-padding: 15px;
    --section-padding: 4rem 0;
    
    // Bordes
    --border-radius: 8px;
    --border-color: #e9ecef;
}
```

## Consejos de Implementación

1. **Siempre prueba en dispositivos móviles** después de realizar cambios
2. **Utiliza las variables CSS** para mantener consistencia de colores
3. **Respeta la estructura de archivos** del tema para futuras actualizaciones
4. **Realiza copias de seguridad** antes de modificaciones importantes
5. **Valida el código CSS** para evitar errores de sintaxis

## Archivos Críticos a No Modificar

- `config/data.json`: Configuración de build del tema
- `layouts/layout.tpl`: Layout principal (solo modificar con precaución)
- `snipplets/header/header.tpl` y `snipplets/footer/footer.tpl`: Estructuras base

## Convenciones de Desarrollo

### Nomenclatura de Clases CSS
```scss
.item {}                    // Componente
.item-image {}             // Elemento del componente
.item-image-featured {}    // Modificador del elemento
.js-item-product {}        // Hook para JavaScript
.is-active {}              // Estado
```

### Estructura de Componentes
```twig
{# snipplets/grid/item.tpl #}
<div class="item js-item-product" data-product-id="{{ product.id }}">
    <div class="item-image">
        {# Imagen del producto #}
    </div>
    <div class="item-description">
        {# Información del producto #}
    </div>
    <div class="item-actions">
        {# Acciones (comprar, quickshop) #}
    </div>
</div>
```

### Variables Twig Comunes
```twig
{{ product.name }}              {# Nombre del producto #}
{{ product.price | money }}     {# Precio formateado #}
{{ product.url }}               {# URL del producto #}
{{ product.featured_image }}    {# Imagen principal #}
{{ product.variations }}        {# Variaciones #}
{{ store.url }}                 {# URL de la tienda #}
{{ 'texto' | translate }}       {# Traducción #}
```

### Prioridades de Z-index
```scss
// z-index: 1-9      - Elementos básicos
// z-index: 10-99    - Overlays y tooltips
// z-index: 100-999  - Dropdowns y popovers
// z-index: 1000+    - Modales y notificaciones

.item-floating-elements { z-index: 2; }
.item-sizes-container { z-index: 9; }
.modal { z-index: 20000; }
.notification { z-index: 30000; }
```

### Testing y Debugging
```javascript
// Log de datos del producto
console.log('Product data:', {{ product | json_encode }});

// Verificar disponibilidad de variantes
{% for variant in product.variants %}
    console.log('Variant {{ variant.id }}:', {
        available: {{ variant.available }},
        stock: {{ variant.stock }},
        option: '{{ variant.option0 }}'
    });
{% endfor %}
```

## Notas de Implementación

### Compatibilidad con TiendaNube
- No usar `{% break %}` en templates (no soportado)
- Evitar selectores CSS anidados con `&` (usar clases completas)
- Los archivos SCSS son compilados por la plataforma
- No hay sistema de build local

### Mejores Prácticas
1. Mantener el CSS crítico bajo 50KB
2. Usar lazy loading para imágenes fuera del viewport
3. Minimizar el uso de JavaScript síncrono
4. Aprovechar el sistema de cache de TiendaNube
5. Testear en el ambiente de desarrollo antes de producción

### Deployment
Los archivos se suben directamente vía FTP/FTPS a:
- URL: `ftp.tiendanube.com`
- Protocolo: FTPS con TLS
- Estructura de carpetas idéntica al repositorio

---

*Última actualización: Septiembre 2024*
*Versión del tema: Luxo 1.0*
*Compatible con: TiendaNube/Nuvemshop*