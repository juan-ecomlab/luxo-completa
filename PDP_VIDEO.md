# Video en la PDP

Documentación del comportamiento del video como slide del slider de producto y dentro del lightbox de Fancybox.

## Archivos involucrados

- `snipplets/video-item.tpl` — markup del video (slide + modal)
- `snipplets/product/product-video.tpl` — wrapper que incluye `video-item.tpl` dos veces (slider visible + modal oculto)
- `snipplets/product/product-image.tpl` — slider de la PDP, donde se inserta el video como uno más de los slides
- `static/css/style-async.scss` — reglas del video dentro del lightbox de Fancybox
- `static/css/style-critical.scss` — estilos base de `.embed-responsive` y `.product-video`
- `static/js/store.js.tpl` — `Fancybox.bind` y handlers de `Carousel.change`

## Layout del lightbox de Fancybox

Reglas dentro de `@media (min-width: 768px)` en `static/css/style-async.scss`:

### Modal (`.fancybox__content.js-product-video-modal`)
- `height: calc(100vh - 128px)` — ajusta al alto del viewport descontando el padding vertical del `.fancybox__slide` en desktop (64px arriba + 64px abajo).
- `width: auto` + `aspect-ratio: var(--vid-aspect, 16 / 9)` — el ancho se deriva del aspect natural del video. La var `--vid-aspect` la setea el template (`snipplets/video-item.tpl:5`) cuando hay `media.dimensions`. Fallback `16 / 9` para casos sin dimensions (típicamente YouTube).
- `min-height: 0` — necesario para que `aspect-ratio` no sea pisado por `min-height: auto` del flex item.
- `align-self: center` + `flex: 0 0 auto` — centra y evita estirado dentro del slide flex column.

### Outer embed (`.js-product-video-modal .embed-responsive`)
- `padding-bottom: 0 !important` — anula el hack `padding-bottom: X%` inline emitido por el template para videos nativos con dimensions.
- `height: 100% !important` — anula el `height: 0` inline.
- `background: transparent` — quita el fondo negro de la regla genérica `.embed-responsive { background: var(--main-foreground) }` (`style-colors.scss:1110`) que aparecía como "sombra" a los lados de la `.video-image` centrada.

### Container del iframe (`.js-external-video-iframe-container`)
- `position: absolute` + `top/left/right/bottom: 0` — llena el outer embed sin depender de la cadena de `height: 100%` por `.js-video-native-image` (que es auto y colapsa).

### Wrapper inyectado por Cloudflare (`.js-external-video-iframe-container > div`)
- `padding-top: 0 !important` — anula el `padding-top: 133.33%` inline que inyecta `media.render` de Cloudflare Stream y que hacía desbordar el alto del modal post-click.
- `height: 100%` — el wrapper toma el alto del container.

### Por qué los `!important`
Solo se usan donde es estrictamente necesario para vencer estilos *inline* que no se pueden vencer por especificidad:

| Override | Compite contra |
|---|---|
| `.embed-responsive { padding-bottom: 0 !important }` | inline `style="padding-bottom: 133.33%"` del template |
| `.embed-responsive { height: 100% !important }` | inline `style="height: 0"` del template |
| `.iframe-container > div { padding-top: 0 !important }` | inline `style="padding-top: 133.33%"` de `media.render` (Cloudflare) |

Las demás reglas no usan `!important` porque la especificidad del selector (`0,4,0` o más) ya gana.

## Aspect ratio dinámico

`snipplets/video-item.tpl:5` emite `--vid-aspect: {w} / {h}` inline al elemento del modal cuando `product_native_video and media.dimensions` está disponible:

```twig
<div id="product-video-modal-{{ media.id }}" class="js-product-video-modal product-video"
     style="display: none;{% if product_native_video and media.dimensions %} --vid-aspect: {{ media.dimensions['width'] }} / {{ media.dimensions['height'] }};{% endif %}">
```

Esto evita el letterbox que el player de Cloudflare hace cuando el aspect del iframe no matchea el del video.

## Autoplay en el lightbox

Implementado en el handler `Carousel.change` del `Fancybox.bind` en `static/js/store.js.tpl`. Cada vez que se entra a un slide con video se fuerza un reload del `src` del iframe — esto garantiza que el video reanude reproducción aunque haya sido pausado al perder visibilidad:

```js
"Carousel.change": (fancybox) => {
    pauseAllVideos();
    const slide = fancybox.getSlide?.();
    const el = slide?.$el?.querySelector?.('.js-product-video-modal');
    if (!el) return;
    const iframe = el.querySelector('iframe[id^="video-"]');
    if (iframe) {
        let src = iframe.getAttribute('src') || iframe.getAttribute('data-src') || '';
        if (src) {
            if (!/[?&]muted=true/.test(src)) {
                src = src.split('?')[0] + '?autoplay=true&muted=true&loop=true';
            }
            if (iframe.getAttribute('src')) {
                iframe.setAttribute('src', '');  // force reload
            }
            iframe.setAttribute('src', src);
        }
    }
    // mostrar container, ocultar imagen y botón
    // resync .js-video-mute-toggle a `is-muted` (el reload arranca muteado)
}
```

### Por qué `Carousel.change` y no `reveal`
En la versión de Fancybox del tema, los eventos `reveal`/`load`/`done` solo disparan para slides de tipo `image`, no para `inline` (que es el tipo del slide del video). `Carousel.change` sí dispara siempre, y desde ahí accedemos al slide actual con `fancybox.getSlide()`.

### Por qué `muted=true` es necesario
Las políticas de autoplay del browser bloquean reproducción automática con sonido. `muted=true` en la URL del iframe permite que Cloudflare Stream arranque solo. Sin este parámetro el iframe carga pero queda en pausa con el botón de play del player visible.

### Por qué force reload y no `player.play()`
La API de Cloudflare Stream no responde de forma confiable a `player.play()` después de un `pause()`. Como `pauseAllVideos()` se llama en cada `Carousel.change`, el video queda en estado pausado al volver al slide. Forzar reload del `src` (blanqueo intermedio + re-set) es la única forma confiable de reanudar.

Tradeoff: el video reinicia desde el principio en cada re-entrada al slide. Para un preview muteado en loop es imperceptible.

## Autoplay inline en el slider en mobile

El slide del video debe reproducirse en autoplay también en mobile, sin matar el swipe del slider.

### Problema original
`autoplayNativeVideoInSlide` muestra el iframe de Cloudflare Stream dentro del slide. En mobile, el iframe captura los touch events y Swiper deja de poder navegar entre slides. Además ocultaba el `.js-play-button` (modal trigger) → no quedaba forma de abrir el lightbox.

### Solución
- **JS (`static/js/store.js.tpl`)**:
  - El hide del play button solo aplica a `.js-play-native-button` (botón inline de desktop). El `.js-play-button` (modal trigger, `d-block d-md-none`) queda visible en mobile.
  - El handler `slideChange` del Swiper **ya no llama a `pauseAllVideos()`**. El video sigue reproduciéndose en background al swipear a otro slide. Al volver, no necesita resume porque nunca se pausó. Costo: consumo mínimo de CPU/batería con el iframe oculto pero corriendo.
  - `autoplayNativeVideoInSlide` setea el `src` una sola vez (chequeo `!iframe.getAttribute("src")`). Si ya está cargado, no toca nada.
- **CSS (`static/css/style-async.scss`, dentro de `@media (max-width: 767px)`):**
  - `pointer-events: none` en `.js-external-video-iframe-container` y su iframe, tanto dentro de `.js-swiper-product` como dentro de `.fancybox__container .js-product-video-modal` — el swipe atraviesa el iframe hasta Swiper / Fancybox.
  - `.js-swiper-product .js-play-button .video-player-icon { display: none }` — esconde el círculo con el play porque visualmente molesta encima del video reproduciendo. El `<a>` overlay sigue presente con `pointer-events: auto` y `z-index: 2`, así un tap abre el modal.

### Asimetría slider vs modal
- **Slider:** no se pausa al cambiar de slide → no hace falta reload, video continúa.
- **Modal (Fancybox):** se llama `pauseAllVideos()` en `Carousel.change` (para evitar múltiples players corriendo dentro del lightbox), por lo que sí se necesita force reload del `src` para reanudar. Ver sección "Autoplay en el lightbox".

## Botón custom de mute/unmute en el modal (mobile)

Como en mobile el iframe del modal tiene `pointer-events: none`, los controles nativos del player de Cloudflare Stream son inaccesibles. Para no perder la única interacción útil (activar sonido) se agregó un botón propio.

### Markup (`snipplets/video-item.tpl`)
Botón circular con dos SVGs inline (muted/unmuted), inyectado dentro del wrapper `.js-product-video-modal` cuando `product_native_video`. Toggle de estado vía clase `.is-muted`.

### Posicionamiento (`static/css/style-async.scss`)
- Esquina inferior derecha del modal (`position: absolute; bottom: 12px; right: 12px`).
- `z-index: 10` para quedar encima del iframe.
- `pointer-events: auto` propio (sobreescribe el `none` del iframe que está al lado).
- `display: none` en `@media (min-width: 768px)` — desktop usa los controles nativos del player (no tiene la restricción de pointer-events).

### Handler (`static/js/store.js.tpl`)
Delegado en `document` para el click en `.js-video-mute-toggle`. Agarra el iframe del modal padre, instancia el player vía `Stream(iframe)` y togglea `player.muted`. Actualiza la clase del botón.

### Resync al cambiar de slide
El `Carousel.change` del Fancybox fuerza reload del iframe → arranca muteado. El handler agrega `is-muted` al botón para mantener consistencia con el estado real del player.

## Apertura del flycart desde la PDP

El `js-size-variant-add` (selector de talles en grilla) abre el modal del carrito tras agregar un producto, replicando el patrón implementado para la PDP en el commit `7010d4527e`. Está en `static/js/store.js.tpl`, dentro del `callback_add_to_cart` del handler `.js-size-variant-add`.

## Known issues / pendientes

### Continuar el video del modal desde donde se pausó (en exploración)
En el modal, el video reinicia desde 0 al volver al slide (por el force reload). En el slider esto **no** aplica porque el video nunca se pausa.

Para que el modal también continúe en lugar de reiniciar, habría que:

- Map `videoTimes[id] = player.currentTime` actualizado vía listener `timeupdate`.
- Inyectar `&startTime=N` en la URL del iframe al re-entrar (Cloudflare lo soporta), o intentar `player.currentTime = N; player.play()` sin reload (probablemente choque con el bug original de `play()` post-pause).
- Manejar casos borde: primera visita sin valor guardado, valores cercanos al final del video que loopean inmediato, race condition en la inicialización del listener, IDs duplicados (ver más abajo).

Alternativa más simple: replicar el patrón del slider y NO llamar `pauseAllVideos()` en `Carousel.change`. Tradeoff: si hay varios videos en la galería, todos quedan corriendo simultáneamente en background dentro del modal.

### IDs duplicados de iframe
El iframe del video se renderiza dos veces (visible en el slider + oculto en el modal), compartiendo `id="video-{uid}"`. Las funciones globales `autoplayNativeVideoInSlide` y `pauseAllVideos` (en `static/js/store.js.tpl`) usan `document.getElementById(id)` y pueden actuar sobre el iframe equivocado.

El handler de autoplay del lightbox lo evita haciendo queries scopeadas al `slide.$el` (no al document). Pero la duplicación de fondo sigue presente y puede causar comportamiento inconsistente si se tocan esas funciones.

Fix futuro: dar IDs únicos a cada iframe en el template (e.g. sufijar con `-modal` el del modal) y actualizar selectores.

### Breakpoint del padding del slide
La regla `height: calc(100vh - 128px)` asume el padding `64px 100px` del `.fancybox__slide` que aplica en `min-width: 1024px`. Entre 768px y 1023px el padding del slide es `48px 8px 8px 8px` (~56px vertical). En ese rango el video queda *menor* al área disponible, lo cual es visualmente aceptable (margen extra, no overflow), pero si se quiere precisión habría que agregar una regla intermedia.
