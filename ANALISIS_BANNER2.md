# Análisis y Solución: Segundo Banner en Homepage

## Resumen Ejecutivo

Se intentó agregar una segunda sección de "Banners de categorías" en la página de inicio que fuera editable desde el administrador de TiendaNube. La implementación no funcionó debido a inconsistencias en los nombres de variables y falta de integración con el sistema existente de banners.

Este documento explica los problemas encontrados y la solución recomendada.

---

## Contexto: Cómo Funciona el Sistema de Secciones

La página de inicio (`templates/home.tpl`) utiliza un sistema modular donde:

1. **Configuración**: En `config/settings.txt` se definen hasta 18 posiciones (`home_order_position_1` a `home_order_position_18`)
2. **Enrutador**: El archivo `snipplets/home/home-section-switch.tpl` actúa como switch/router que renderiza la sección correspondiente
3. **Validación**: En `home.tpl` se definen variables `has_*` para validar si existe contenido para cada sección
4. **Renderizado**: Cada sección incluye su propio template (ej: `home-banners.tpl`, `home-slider.tpl`)

---

## Lo Que Se Intentó (Commit 0c89b76)

### Archivos Modificados:
1. **`config/settings.txt`**: Se agregó la sección "Banners de categorías 2" (líneas 736-783) con:
   - `banner2` (gallery)
   - `banner_mobile2` (gallery)
   - `banner_slider2` (checkbox)
   - `banner_same_size2` (checkbox)
   - `banner_text_outside2` (checkbox)
   - `banner_columns_desktop2` (dropdown)
   - `banner_columns_mobile2` (dropdown)
   - `toggle_banner_mobile2` (checkbox)

2. **`snipplets/home/home-section-switch.tpl`**: Se agregaron dos secciones:
   - `categories2` (líneas 50-58)
   - `promotional2` (líneas 116-125)

3. **`snipplets/home/home-banners-grid-2.tpl`**: Archivo nuevo creado para renderizar el segundo banner

---

## Problemas Identificados

### 🔴 Problema #1: Inconsistencia en Nombres de Sección

**Línea**: `config/settings.txt:1086`
```
sections
    slider = Carrusel de imágenes
    main_categories = Categorías principales
    products = Productos destacados
    informatives = Información de envíos, pagos y compra
    categories = Banners de categorías
    categories_copy = Banners de categorías 2    ← Config usa "categories_copy"
```

**Línea**: `home-section-switch.tpl:50`
```twig
{% elseif section_select == 'categories2' %}    ← Template busca "categories2"
```

**Impacto**: La sección nunca coincide, por lo tanto nunca se renderiza.

---

### 🔴 Problema #2: Falta Variable de Validación

**En `templates/home.tpl:7`** solo existen:
```twig
{% set has_banners = settings.banner and settings.banner is not empty %}
{% set has_promotional_banners = settings.banner_promotional and settings.banner_promotional is not empty %}
{% set has_news_banners = settings.banner_news and settings.banner_news is not empty %}
```

**Falta**:
```twig
{% set has_banners2 = settings.banner2 and settings.banner2 is not empty %}
```

**Impacto**: No hay forma de validar si existe contenido para banner2, y no se incluye en la validación de `show_help`.

---

### 🔴 Problema #3: Template Incorrecto

**Línea**: `home-section-switch.tpl:56`
```twig
{% include 'snipplets/home/home-banners.tpl' with {'has_banner': true} %}
```

**Problema**: El archivo `home-banners.tpl` no sabe manejar `banner2`. Solo maneja:
- `has_banner` → usa `settings.banner`
- `has_banner_promotional` → usa `settings.banner_promotional`
- `has_banner_news` → usa `settings.banner_news`
- `has_module` → usa `settings.module`

**Impacto**: Aunque la sección se ejecutara, intentaría renderizar el banner1 en lugar del banner2.

---

### 🔴 Problema #4: Sección "promotional2" Incorrecta

**Línea**: `home-section-switch.tpl:116-125`
```twig
{% elseif section_select == 'promotional2' %}
    {% set has_banner_promotional2 = settings.banner_promotional2 and settings.banner_promotional2 is not empty %}
    ...
    {% include 'snipplets/home/home-banners-grid-2.tpl' with {'banner_promotional2': true} %}
```

**Problema**: No existe `settings.banner_promotional2` en `config/settings.txt`. Esta sección no está definida en la configuración.

**Impacto**: Código muerto que no se puede usar.

---

### 🔴 Problema #5: Template Incompleto

El archivo `home-banners-grid-2.tpl` fue creado pero:
- Usa variables incorrectas (`banner_promotional2` en lugar de `banner2`)
- No sigue la estructura del sistema existente de banners
- No integra con `home-banners-grid.tpl` que es el renderizador real

---

## Solución Propuesta: Opción A (Recomendada)

### Estrategia
Integrar el segundo banner en el sistema existente, siguiendo el patrón arquitectónico del tema.

### Ventajas
✅ Sigue la arquitectura existente del tema
✅ Reutiliza código probado
✅ Mantenible y escalable
✅ Compatible con el diseñador web de TiendaNube
✅ Consistente con otros tipos de banners

---

## Pasos para Implementar la Solución

### Paso 1: Agregar Variable de Validación

**Archivo**: `templates/home.tpl`
**Línea**: Después de la línea 7

**Cambio**:
```twig
{% set has_banners = settings.banner and settings.banner is not empty %}
{% set has_banners2 = settings.banner2 and settings.banner2 is not empty %}
{% set has_promotional_banners = settings.banner_promotional and settings.banner_promotional is not empty %}
```

**Y en línea 21**, actualizar la validación de `show_help`:
```twig
{% set show_help = not (has_main_slider or has_mobile_slider or has_video or has_main_categories or has_banners or has_banners2 or has_promotional_banners or has_news_banners or has_image_and_text_module or has_informative_banners or has_instafeed or has_welcome_message or has_institutional_message or has_testimonials or has_brands) and not has_products %}
```

---

### Paso 2: Corregir Nombre de Sección

**Archivo**: `snipplets/home/home-section-switch.tpl`
**Línea**: 50

**Antes**:
```twig
{% elseif section_select == 'categories2' %}
```

**Después**:
```twig
{% elseif section_select == 'categories_copy' %}
```

**Y actualizar el contenido**:
```twig
{% elseif section_select == 'categories_copy' %}
	{#  **** Categories banners 2 ****  #}
	<section class="section-banners-home position-relative" data-store="home-banner-categories2">
		{% if show_help or (show_component_help and not has_banners2) %}
			{% snipplet 'defaults/home/category_banners_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-banners.tpl' with {'has_banner2': true} %}
		{% endif %}
	</section>
```

---

### Paso 3: Extender Sistema de Banners

**Archivo**: `snipplets/home/home-banners.tpl`
**Líneas**: 3-12

**Agregar después de las validaciones de `has_banner`**:

```twig
{% set has_banner = has_banner | default(false) %}
{% set has_mobile_banners = (settings.toggle_banner_mobile and settings.banner_mobile and settings.banner_mobile is not empty) or theme_editor %}

{% set has_banner2 = has_banner2 | default(false) %}
{% set has_mobile_banners2 = (settings.toggle_banner_mobile2 and settings.banner_mobile2 and settings.banner_mobile2 is not empty) or theme_editor %}

{% set has_banner_promotional = has_banner_promotional | default(false) %}
```

**Líneas**: 14-21

**Agregar después del bloque `if has_banner`**:

```twig
{% if has_banner %}
    {% set section_name = 'banner' %}
    {% set section_format = settings.banner_slider ? 'slider' : 'grid' %}
    {% set section_columns_mobile = settings.banner_columns_mobile %}
    {% set section_columns_desktop = settings.banner_columns_desktop %}
    {% set section_grid_classes = settings.banner_columns_desktop == 4 ? 'col-md-3' : settings.banner_columns_desktop == 3 ? 'col-md-4' : settings.banner_columns_desktop == 2 ? 'col-md-6' : 'col-md-12' %}
    {% set section_text_position = settings.banner_text_outside ? 'outside' : 'above' %}
    {% set section_image_size = settings.banner_same_size ? 'same' : 'original' %}
{% elseif has_banner2 %}
    {% set section_name = 'banner2' %}
    {% set section_format = settings.banner_slider2 ? 'slider' : 'grid' %}
    {% set section_columns_mobile = settings.banner_columns_mobile2 %}
    {% set section_columns_desktop = settings.banner_columns_desktop2 %}
    {% set section_grid_classes = settings.banner_columns_desktop2 == 4 ? 'col-md-3' : settings.banner_columns_desktop2 == 3 ? 'col-md-4' : settings.banner_columns_desktop2 == 2 ? 'col-md-6' : 'col-md-12' %}
    {% set section_text_position = settings.banner_text_outside2 ? 'outside' : 'above' %}
    {% set section_image_size = settings.banner_same_size2 ? 'same' : 'original' %}
{% elseif has_banner_promotional %}
```

**Líneas**: 45-50

**Agregar después del bloque de renderizado de `has_banner`**:

```twig
    {% if has_banner %}
        {% include 'snipplets/home/home-banners-grid.tpl' with {'banner': true} %}
        {% if has_mobile_banners %}
            {% include 'snipplets/home/home-banners-grid.tpl' with {'banner': true, mobile: true} %}
        {% endif %}
    {% endif %}
    {% if has_banner2 %}
        {% include 'snipplets/home/home-banners-grid.tpl' with {'banner2': true} %}
        {% if has_mobile_banners2 %}
            {% include 'snipplets/home/home-banners-grid.tpl' with {'banner2': true, mobile: true} %}
        {% endif %}
    {% endif %}
    {% if has_banner_promotional %}
```

---

### Paso 4: Extender Renderizador de Banners

**Archivo**: `snipplets/home/home-banners-grid.tpl`
**Acción**: Agregar soporte para `banner2`

Este archivo probablemente tiene una estructura similar a:
```twig
{% set banner = banner | default(false) %}
{% set banner_promotional = banner_promotional | default(false) %}
{% set banner_news = banner_news | default(false) %}
```

**Agregar**:
```twig
{% set banner2 = banner2 | default(false) %}
```

Y luego donde se define qué imágenes usar:
```twig
{% if banner %}
    {% set section_slides = mobile ? settings.banner_mobile : settings.banner %}
{% elseif banner2 %}
    {% set section_slides = mobile ? settings.banner_mobile2 : settings.banner2 %}
{% elseif banner_promotional %}
```

---

### Paso 5: Eliminar Código Incorrecto

**Archivo**: `snipplets/home/home-section-switch.tpl`
**Líneas**: 116-126

**Eliminar completamente**:
```twig
{% elseif section_select == 'promotional2' %}
    {% set banner_promotional2 = true %}
    {% set has_banner_promotional2 = settings.banner_promotional2 and settings.banner_promotional2 is not empty %}
    <section class="section-banners-home position-relative" data-store="home-banner-promotional2">
        {% if show_help or (show_component_help and not has_banner_promotional2) %}
            {% snipplet 'defaults/home/promotional_banners_help.tpl' %}
        {% else %}
            {% include 'snipplets/home/home-banners-grid-2.tpl' with {'banner_promotional2': true} %}
        {% endif %}
    </section>

```

**Archivo**: `snipplets/home/home-banners-grid-2.tpl`
**Acción**: Eliminar el archivo completo (ya no es necesario)

---

## Resultado Esperado

Después de implementar estos cambios:

1. ✅ La sección "Banners de categorías 2" aparecerá en el ordenador de secciones del admin
2. ✅ Se podrán cargar imágenes desde el diseñador web de TiendaNube
3. ✅ Funcionarán todas las opciones configuradas:
   - Carrusel o grilla
   - Diferentes columnas en desktop (1, 2, 3, 4)
   - Diferentes columnas en mobile (1, 2)
   - Imágenes alternativas para mobile
   - Texto dentro o fuera de la imagen
   - Mismo alto para todos los banners
4. ✅ El código seguirá el patrón arquitectónico del tema
5. ✅ Será mantenible y escalable

---

## Pruebas Recomendadas

Después de implementar los cambios:

1. **Verificar configuración**: Ir al admin de TiendaNube → Diseño → Página de inicio
2. **Agregar sección**: Buscar "Banners de categorías 2" en el listado de secciones
3. **Cargar imágenes**: Subir al menos 2 imágenes de prueba
4. **Probar configuraciones**:
   - Cambiar número de columnas
   - Activar/desactivar carrusel
   - Probar imágenes mobile
   - Verificar texto fuera/dentro
5. **Responsive**: Verificar en mobile y desktop

---

## Archivos a Modificar (Resumen)

| Archivo | Acción |
|---------|--------|
| `templates/home.tpl` | ✏️ Agregar `has_banners2` variable |
| `snipplets/home/home-section-switch.tpl` | ✏️ Cambiar `categories2` → `categories_copy`<br>❌ Eliminar sección `promotional2` |
| `snipplets/home/home-banners.tpl` | ✏️ Agregar soporte para `banner2` |
| `snipplets/home/home-banners-grid.tpl` | ✏️ Agregar soporte para `banner2` |
| `snipplets/home/home-banners-grid-2.tpl` | ❌ Eliminar archivo |
| `config/settings.txt` | ✅ Ya está correcto (no requiere cambios) |

---

## Referencias

- **PDF de Landings**: Documento con patrones de implementación de TiendaNube
- **Commit problemático**: `0c89b76` - "intentando duplicar banners de categoria"
- **Patrón arquitectónico**: Similar a cómo funcionan `banner_promotional` y `banner_news`

---

## Notas Adicionales

- La configuración en `settings.txt` está correcta y no requiere cambios
- El sistema de ordenamiento de secciones ya incluye `categories_copy` en la lista
- Todos los campos necesarios (`banner2`, `banner_mobile2`, etc.) ya están definidos
- La solución propuesta es escalable si en el futuro se necesita un tercer banner

---

**Fecha**: 1 de Octubre, 2025
**Autor**: Análisis de Claude Code
**Versión**: 1.0
