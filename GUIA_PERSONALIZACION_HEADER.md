# Guía de Personalización del Header (header.tpl)

Esta guía explica cómo personalizar el archivo `snipplets/header/header.tpl` del tema Luxo para TiendaNube/Nuvemshop.

## Estructura del Header

El header se encuentra en `/snipplets/header/header.tpl` y contiene todos los elementos de navegación superior del sitio web.

### Componentes Principales

1. **Barra de navegación principal**
2. **Logo de la tienda**
3. **Menú de navegación**
4. **Buscador**
5. **Iconos de usuario y carrito**
6. **Menú móvil (hamburguesa)**

## Elementos Personalizables

### 1. Logo de la Tienda

**Ubicación en el código:**
```twig
<div class="header-logo">
    <a href="{{ store.url }}" class="logo-link">
        {% if store.logo %}
            <img src="{{ store.logo | img_url('medium') }}" alt="{{ store.name }}" class="logo-img">
        {% else %}
            <span class="logo-text">{{ store.name }}</span>
        {% endif %}
    </a>
</div>
```

**Personalizaciones posibles:**
- Cambiar el tamaño del logo modificando `img_url('medium')` por `'small'`, `'large'`, etc.
- Añadir clases CSS personalizadas al logo
- Modificar el comportamiento del logo en móvil vs desktop

### 2. Menú de Navegación

**Ubicación en el código:**
```twig
<nav class="header-nav">
    <ul class="nav-list">
        {% for item in navigation %}
            <li class="nav-item">
                <a href="{{ item.url }}" class="nav-link">{{ item.name }}</a>
                {% if item.subitems %}
                    <ul class="subnav">
                        {% for subitem in item.subitems %}
                            <li><a href="{{ subitem.url }}">{{ subitem.name }}</a></li>
                        {% endfor %}
                    </ul>
                {% endif %}
            </li>
        {% endfor %}
    </ul>
</nav>
```

**Personalizaciones posibles:**
- Añadir iconos a los elementos del menú
- Cambiar la estructura del submenú (dropdown vs mega-menu)
- Añadir elementos adicionales al menú (ej: teléfono, redes sociales)

### 3. Buscador

**Ubicación en el código:**
```twig
<div class="header-search">
    <form action="{{ store.search_url }}" method="get" class="search-form">
        <input type="text" name="q" placeholder="{{ 'Buscar productos...' | translate }}" class="search-input">
        <button type="submit" class="search-btn">
            <svg class="search-icon"><use xlink:href="#search"></use></svg>
        </button>
    </form>
</div>
```

**Personalizaciones posibles:**
- Cambiar el placeholder del buscador
- Añadir búsqueda predictiva (autocomplete)
- Modificar el estilo del buscador (expandible, modal, etc.)

### 4. Iconos de Usuario y Carrito

**Ubicación en el código:**
```twig
<div class="header-actions">
    <!-- Icono de usuario -->
    <a href="{{ store.customer_url }}" class="header-icon user-icon">
        <svg><use xlink:href="#user"></use></svg>
        <span class="icon-text">{{ 'Mi cuenta' | translate }}</span>
    </a>
    
    <!-- Icono de carrito -->
    <a href="{{ store.cart_url }}" class="header-icon cart-icon js-cart-toggle">
        <svg><use xlink:href="#cart"></use></svg>
        <span class="cart-count js-cart-widget-amount">{{ cart.items_count }}</span>
        <span class="icon-text">{{ 'Carrito' | translate }}</span>
    </a>
</div>
```

**Personalizaciones posibles:**
- Añadir más iconos (wishlist, comparar productos)
- Cambiar el comportamiento del carrito (sidebar vs página completa)
- Personalizar el contador del carrito

## Configuraciones por Dispositivo

### Header Desktop
```twig
<header class="header d-none d-lg-block">
    <!-- Contenido específico para desktop -->
</header>
```

### Header Mobile
```twig
<header class="header-mobile d-lg-none">
    <!-- Contenido específico para móvil -->
    <button class="mobile-menu-toggle js-mobile-menu-toggle">
        <span class="hamburger-line"></span>
        <span class="hamburger-line"></span>
        <span class="hamburger-line"></span>
    </button>
</header>
```

## Variables de Configuración Disponibles

### Variables del Store
- `{{ store.url }}` - URL base de la tienda
- `{{ store.name }}` - Nombre de la tienda
- `{{ store.logo }}` - URL del logo
- `{{ store.cart_url }}` - URL del carrito
- `{{ store.customer_url }}` - URL de cuenta de cliente

### Variables de Navegación
- `{{ navigation }}` - Menú principal de navegación
- `{{ navigation.primary }}` - Menú primario
- `{{ navigation.secondary }}` - Menú secundario

### Variables de Configuración del Tema
```twig
{% if settings.header_transparent %}
    <!-- Header transparente -->
{% endif %}

{% if settings.header_sticky %}
    <!-- Header fijo al hacer scroll -->
{% endif %}
```

## Ejemplos de Personalización

### 1. Layout: Logo Centrado, Navegación Izquierda, Buscador y Login Derecha

Este layout distribuye los elementos en una sola fila con el logo en el centro.

```twig
<header class="header header-layout-centered">
    <div class="container-fluid">
        <div class="row align-items-center">
            <!-- Navegación Izquierda -->
            <div class="col-md-4 d-flex justify-content-start">
                <nav class="header-nav">
                    <ul class="nav-list d-flex mb-0">
                        {% for item in navigation | slice(0, 4) %}
                            <li class="nav-item me-3">
                                <a href="{{ item.url }}" class="nav-link">{{ item.name }}</a>
                            </li>
                        {% endfor %}
                    </ul>
                </nav>
            </div>
            
            <!-- Logo Centrado -->
            <div class="col-md-4 d-flex justify-content-center">
                <div class="header-logo">
                    <a href="{{ store.url }}" class="logo-link">
                        {% if store.logo %}
                            <img src="{{ store.logo | img_url('medium') }}" alt="{{ store.name }}" class="logo-img">
                        {% else %}
                            <span class="logo-text">{{ store.name }}</span>
                        {% endif %}
                    </a>
                </div>
            </div>
            
            <!-- Buscador y Acciones Derecha -->
            <div class="col-md-4 d-flex justify-content-end align-items-center">
                <!-- Buscador compacto -->
                <div class="header-search me-3">
                    <form action="{{ store.search_url }}" method="get" class="search-form d-flex">
                        <input type="text" name="q" placeholder="{{ 'Buscar...' | translate }}" class="search-input form-control form-control-sm">
                        <button type="submit" class="search-btn btn btn-outline-secondary btn-sm">
                            <svg class="search-icon" width="16" height="16"><use xlink:href="#search"></use></svg>
                        </button>
                    </form>
                </div>
                
                <!-- Acciones de usuario -->
                <div class="header-actions d-flex">
                    <a href="{{ store.customer_url }}" class="header-icon user-icon me-2" title="{{ 'Mi cuenta' | translate }}">
                        <svg width="20" height="20"><use xlink:href="#user"></use></svg>
                    </a>
                    <a href="{{ store.cart_url }}" class="header-icon cart-icon js-cart-toggle position-relative" title="{{ 'Carrito' | translate }}">
                        <svg width="20" height="20"><use xlink:href="#cart"></use></svg>
                        {% if cart.items_count > 0 %}
                            <span class="cart-count badge bg-primary position-absolute top-0 start-100 translate-middle">{{ cart.items_count }}</span>
                        {% endif %}
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>
```

**CSS Complementario:**
```scss
.header-layout-centered {
    padding: 15px 0;
    border-bottom: 1px solid #e1e1e1;
    
    .nav-link {
        font-weight: 500;
        color: #333;
        text-decoration: none;
        
        &:hover {
            color: #007bff;
        }
    }
    
    .search-input {
        width: 200px;
        border-radius: 20px 0 0 20px;
    }
    
    .search-btn {
        border-radius: 0 20px 20px 0;
        border-left: 0;
    }
    
    .header-icon {
        color: #333;
        text-decoration: none;
        
        &:hover {
            color: #007bff;
        }
    }
}
```

### 2. Layout: Logo en Fila Separada (Arriba), Navegación y Acciones Abajo

Este layout coloca el logo en una fila superior y los demás elementos en la fila inferior.

```twig
<header class="header header-layout-stacked">
    <!-- Fila Superior: Solo Logo -->
    <div class="header-top">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12 d-flex justify-content-center py-3">
                    <div class="header-logo">
                        <a href="{{ store.url }}" class="logo-link">
                            {% if store.logo %}
                                <img src="{{ store.logo | img_url('large') }}" alt="{{ store.name }}" class="logo-img">
                            {% else %}
                                <h1 class="logo-text mb-0">{{ store.name }}</h1>
                            {% endif %}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Fila Inferior: Navegación, Buscador y Acciones -->
    <div class="header-bottom border-top">
        <div class="container-fluid">
            <div class="row align-items-center">
                <!-- Navegación Izquierda -->
                <div class="col-md-6 d-flex justify-content-start">
                    <nav class="header-nav">
                        <ul class="nav-list d-flex mb-0">
                            {% for item in navigation %}
                                <li class="nav-item me-4">
                                    <a href="{{ item.url }}" class="nav-link">{{ item.name }}</a>
                                    {% if item.subitems %}
                                        <ul class="dropdown-menu position-absolute">
                                            {% for subitem in item.subitems %}
                                                <li><a href="{{ subitem.url }}" class="dropdown-item">{{ subitem.name }}</a></li>
                                            {% endfor %}
                                        </ul>
                                    {% endif %}
                                </li>
                            {% endfor %}
                        </ul>
                    </nav>
                </div>
                
                <!-- Buscador y Acciones Derecha -->
                <div class="col-md-6 d-flex justify-content-end align-items-center">
                    <!-- Buscador expandido -->
                    <div class="header-search me-4">
                        <form action="{{ store.search_url }}" method="get" class="search-form d-flex">
                            <input type="text" name="q" placeholder="{{ 'Buscar productos, marcas...' | translate }}" class="search-input form-control">
                            <button type="submit" class="search-btn btn btn-primary">
                                <svg class="search-icon" width="18" height="18"><use xlink:href="#search"></use></svg>
                                <span class="d-none d-lg-inline ms-1">{{ 'Buscar' | translate }}</span>
                            </button>
                        </form>
                    </div>
                    
                    <!-- Acciones con texto -->
                    <div class="header-actions d-flex">
                        <a href="{{ store.customer_url }}" class="header-icon user-icon me-3 d-flex align-items-center">
                            <svg width="20" height="20" class="me-1"><use xlink:href="#user"></use></svg>
                            <span class="d-none d-lg-inline">{{ 'Mi cuenta' | translate }}</span>
                        </a>
                        <a href="{{ store.cart_url }}" class="header-icon cart-icon js-cart-toggle d-flex align-items-center position-relative">
                            <svg width="20" height="20" class="me-1"><use xlink:href="#cart"></use></svg>
                            <span class="d-none d-lg-inline">{{ 'Carrito' | translate }}</span>
                            {% if cart.items_count > 0 %}
                                <span class="cart-count badge bg-danger ms-2">{{ cart.items_count }}</span>
                            {% endif %}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
```

**CSS Complementario:**
```scss
.header-layout-stacked {
    .header-top {
        background: #fff;
        
        .logo-img {
            max-height: 60px;
        }
        
        .logo-text {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
        }
    }
    
    .header-bottom {
        background: #f8f9fa;
        padding: 12px 0;
        
        .nav-item {
            position: relative;
            
            &:hover .dropdown-menu {
                display: block;
            }
        }
        
        .nav-link {
            font-weight: 500;
            color: #333;
            text-transform: uppercase;
            font-size: 0.9rem;
            text-decoration: none;
            
            &:hover {
                color: #007bff;
            }
        }
        
        .dropdown-menu {
            display: none;
            top: 100%;
            left: 0;
            z-index: 1000;
            background: white;
            border: 1px solid #e1e1e1;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .search-input {
            width: 300px;
            border-radius: 25px 0 0 25px;
        }
        
        .search-btn {
            border-radius: 0 25px 25px 0;
            border-left: 0;
        }
        
        .header-icon {
            color: #333;
            text-decoration: none;
            font-size: 0.9rem;
            
            &:hover {
                color: #007bff;
            }
        }
    }
}
```

### 3. Añadir Teléfono al Header
```twig
<div class="header-contact">
    <a href="tel:+1234567890" class="contact-phone">
        <svg><use xlink:href="#phone"></use></svg>
        <span>+123 456 7890</span>
    </a>
</div>
```

### 4. Header con Promoción
```twig
<div class="header-promo">
    <p>{{ 'Envío gratis en compras mayores a $50.000' | translate }}</p>
</div>
```

### 5. Menú con Iconos
```twig
{% for item in navigation %}
    <li class="nav-item">
        {% if item.name == 'Inicio' %}
            <svg class="nav-icon"><use xlink:href="#home"></use></svg>
        {% elseif item.name == 'Productos' %}
            <svg class="nav-icon"><use xlink:href="#grid"></use></svg>
        {% endif %}
        <a href="{{ item.url }}" class="nav-link">{{ item.name }}</a>
    </li>
{% endfor %}
```

## Buenas Prácticas

### 1. Responsive Design
- Siempre considerar las vistas móvil y desktop
- Usar las clases de Bootstrap incluidas (`d-none d-lg-block`, etc.)
- Testear en diferentes tamaños de pantalla

### 2. Performance
- Optimizar imágenes del logo
- Minimizar el código JavaScript personalizado
- Usar sprites SVG para iconos

### 3. Accesibilidad
- Incluir atributos `alt` en imágenes
- Usar `aria-label` en botones sin texto
- Mantener contraste adecuado en colores

### 4. SEO
- Usar estructura semántica HTML5
- Incluir microdatos cuando sea apropiado
- Optimizar el texto alternativo del logo

## Configuraciones CSS

### Variables CSS Personalizables
```scss
// En style-critical.scss
$header-height: 80px;
$header-bg: #ffffff;
$header-color: #333333;
$header-border: #e1e1e1;

// Colores del menú
$nav-link-color: #333;
$nav-link-hover: #007bff;
```

### Clases CSS Principales
- `.header` - Contenedor principal del header
- `.header-logo` - Contenedor del logo
- `.header-nav` - Navegación principal
- `.header-search` - Buscador
- `.header-actions` - Iconos de usuario/carrito
- `.header-mobile` - Header móvil

## Archivos Relacionados

- **Template principal:** `snipplets/header/header.tpl`
- **Estilos:** `static/css/style-critical.scss`
- **JavaScript:** `static/js/store.js.tpl`
- **Configuración:** `config/settings.txt`

## Limitaciones y Consideraciones

1. **Limitaciones de la plataforma:** Algunas funcionalidades están limitadas por las APIs de TiendaNube
2. **Compatibilidad:** Verificar que las personalizaciones funcionen en todos los navegadores soportados
3. **Actualizaciones:** Las personalizaciones deben ser compatibles con futuras actualizaciones del tema

## Soporte y Recursos

- Documentación oficial de TiendaNube: [developers.tiendanube.com](https://developers.tiendanube.com)
- Guía de templates: Variables y funciones disponibles
- Foro de desarrolladores para consultas específicas

---

**Nota:** Siempre realizar un backup antes de modificar archivos del tema y probar los cambios en un entorno de desarrollo antes de aplicarlos en producción.