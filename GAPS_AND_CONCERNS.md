# Análisis de Gaps y Preocupaciones - Migración Template Luxo

**Fecha**: 3 de Octubre, 2025
**Análisis**: Comparación entre la checklist de migración y el template actual en workspace

---

## ⚠️ PREOCUPACIÓN CRÍTICA: Clarificación de Template

### 🔴 Inconsistencia en Nomenclatura de Templates

La checklist de migración menciona migrar al **"Template RIO"** (línea 2 del documento), pero el workspace actual contiene el template **"luxo-completa"**.

**Pregunta Crítica**: ¿Son el mismo template o son diferentes?

**Acción Requerida**:
- ✅ Confirmar si "luxo-completa" ES el "Template RIO" mencionado en la migración
- ✅ Si son diferentes, obtener el template RIO correcto
- ✅ Si son el mismo, actualizar documentación para evitar confusión

---

## 🔴 GAPS CRÍTICOS (Prioridad Alta - Impiden el Funcionamiento)

### 1. Integraciones de Terceros - TODAS FALTANTES

#### ❌ Google Tag Manager
- **Estado**: NO encontrado en el código
- **Impacto**: Pérdida total de analytics, tracking de conversiones, píxeles de marketing
- **Container ID**: `GTM-P4BX6JS`
- **Ubicación Requerida**: `layouts/layout.tpl` (head + body)
- **Severidad**: 🔴 CRÍTICA
- **Esfuerzo**: 30 minutos (copy/paste de código)

#### ❌ WoowUp Customer Data Platform
- **Estado**: NO encontrado en el código
- **Impacto**: Pérdida de tracking de clientes, eventos personalizados, CDP completo
- **App ID**: `DoH5lCS7j`
- **Ubicación Requerida**: `layouts/layout.tpl` (head)
- **Templates Afectados**: dot.tpl, buenavibra.tpl (aún no existen)
- **Severidad**: 🔴 CRÍTICA
- **Esfuerzo**: 2-3 horas (script + recrear formularios personalizados)

#### ❌ VWO (Visual Website Optimizer)
- **Estado**: NO encontrado en el código
- **Impacto**: Pérdida de testing A/B activos, optimización de conversiones
- **Account ID**: `749150`
- **Ubicación Requerida**: `layouts/layout.tpl` (head)
- **Severidad**: 🟠 ALTA (si hay tests activos en producción)
- **Esfuerzo**: 30 minutos + verificar tests activos

---

### 2. Tags/Secciones Personalizados de Productos - TODOS FALTANTES

#### ❌ Tags Personalizados No Creados
**Estado**: El archivo `config/sections.txt` solo tiene tags básicos (primary, new, sale, featured)

**Tags Faltantes**:
- `cuotas` - Badge de 6 cuotas
- `veintiuno` - Badge de 9 cuotas
- `eshop` - Exclusivo e-shop
- `thekluv` - Colección THE KLUV
- `fiveoff` - Descuento por 5 horas
- `veinte` - Colección MundiFungi
- `veintidos` - Colección Año 2022
- `veintitres` - Colección Año 2023

**Impacto**: Los productos en producción con estos tags NO mostrarán badges
**Severidad**: 🟠 ALTA
**Esfuerzo**: 1 hora (definir todos los tags en config/sections.txt)

---

### 3. Templates Personalizados Críticos Faltantes

#### ❌ dot.tpl (Landing con formulario WoowUp)
- **Estado**: NO existe
- **Propósito**: Captura de leads con email, tags "dot", fecha de nacimiento
- **Integración**: API de WoowUp Events
- **Severidad**: 🟠 ALTA (si está en uso activo)
- **Esfuerzo**: 3-4 horas

#### ❌ buenavibra.tpl (Landing con formulario WoowUp)
- **Estado**: NO existe
- **Propósito**: Captura de leads con email, tags "buenavibra"
- **Integración**: API de WoowUp Events
- **Severidad**: 🟠 ALTA (si está en uso activo)
- **Esfuerzo**: 2-3 horas

#### ❌ bases_condiciones.tpl
- **Estado**: NO existe
- **Propósito**: Bases y condiciones legales
- **Severidad**: 🟡 MEDIA
- **Esfuerzo**: 1-2 horas (o migrar a página estándar)

#### ❌ links.tpl
- **Estado**: NO existe
- **Propósito**: Desconocido
- **Severidad**: ⚪ BAJA (necesita validación de uso)
- **Esfuerzo**: Por determinar

#### ❌ lookbook.tpl
- **Estado**: NO existe
- **Propósito**: Página de lookbook
- **Severidad**: 🟡 MEDIA
- **Esfuerzo**: 2-3 horas

#### ❌ test.tpl
- **Estado**: NO existe
- **Propósito**: Testing (probablemente no es crítico)
- **Severidad**: ⚪ BAJA
- **Esfuerzo**: N/A (probablemente no migrar)

---

### 4. Infinite Scrolling - FALTANTE

#### ❌ Setting de Infinite Scrolling
- **Estado**: NO encontrado en `config/settings.txt`
- **Valor Esperado en Producción**: `infinite_scrolling = 1`
- **Impacto**: Los usuarios tendrán que hacer clic en "siguiente página" en lugar de auto-carga
- **Severidad**: 🟡 MEDIA (afecta UX, no funcionalidad crítica)
- **Esfuerzo**: Verificar si está implementado en el JS del tema

---

## 🟡 GAPS MEDIOS (Funcionalidad Importante)

### 1. Sendtric Countdown Timers

#### ⚠️ No Implementados (y probablemente no deberían estarlo)
- **Estado**: No encontrados en código
- **IDs en Producción**:
  - Home: `tbekv9891c`
  - Category: `mynki8fmcd`
- **Problema Original**: Hardcodeados en templates
- **Recomendación**: ⚠️ Decidir si se siguen usando. Si es así, implementarlos dinámicamente vía settings
- **Severidad**: 🟡 MEDIA
- **Esfuerzo**: 2 horas (hacerlos dinámicos vía settings)

---

### 2. Popup de Newsletter vs Popup Promocional

#### ⚠️ Posible Duplicación
- **Estado**: Existe `home_promotional_popup` en settings
- **Encontrado**: `snipplets/home/home-popup.tpl`
- **Migración menciona**: También existe "newsletter popup" separado
- **Preocupación**: ¿Son el mismo componente o diferentes?
- **Acción Requerida**: Clarificar si son 2 popups diferentes o el mismo
- **Severidad**: 🟡 MEDIA
- **Esfuerzo**: Por determinar

---

### 3. Integraciones de Facebook (En Declive)

#### ⚠️ No Prioritarias - Evaluar Uso Real

La migración menciona:
- Comentarios de Facebook en productos
- Login con Facebook

**Recomendación**: ✅ Validar si estas funcionalidades tienen uso real en analytics ANTES de invertir tiempo en migrarlas. Las funcionalidades de Facebook están en declive.

---

## ✅ LO QUE YA EXISTE (No Requiere Trabajo)

### Templates Personalizados ✅
- ✅ `artistas.tpl` - Página de colaboraciones con artistas
- ✅ `locales.tpl` - Página de locales físicos
- ✅ `nft.tpl` - Página de NFT/Crypto
- ✅ `faqs.tpl` - FAQ
- ✅ `coleccion.tpl` - Página de colección

### Funcionalidades Core ✅
- ✅ `ajax_cart` - Carrito AJAX (setting existe)
- ✅ `quick_shop` - Compra rápida (setting existe)
- ✅ `home_promotional_popup` - Popup promocional
- ✅ `show_instafeed` - Feed de Instagram
- ✅ `last_product` - Alerta de último producto
- ✅ `cart_minimum_value` - Valor mínimo de carrito
- ✅ `product_color_variants` - Variantes de color
- ✅ `toggle_slider_mobile` - Slider mobile específico

### Snipplets y Componentes ✅
- ✅ `snipplets/home/home-instafeed.tpl`
- ✅ `snipplets/whatsapp-chat.tpl`
- ✅ `snipplets/home/home-popup.tpl`
- ✅ `static/checkout.scss.tpl` (estilos personalizados de checkout)

### Optimizaciones de Performance ✅
- ✅ Critical CSS inline
- ✅ Async CSS loading
- ✅ Lazy loading de imágenes
- ✅ Preload de primera imagen del slider
- ✅ `snipplets/preload-images.tpl`

---

## 🔍 ÁREAS QUE REQUIEREN VERIFICACIÓN

### 1. Templates Personalizados con Contenido Hardcodeado

#### ⚠️ artistas.tpl
**Problema**: Contiene URLs hardcodeadas a `luxo.com.ar`:
```html
<a href="https://www.luxo.com.ar/search/?q=toto" ...>
<a href="https://www.luxo.com.ar/search/?q=canalla" ...>
```

**Riesgo**: Si el dominio cambia o se usa multi-idioma, los links no funcionarán
**Recomendación**: Usar `{{ store.url }}` o hacer los links dinámicos
**Severidad**: 🟡 MEDIA
**Esfuerzo**: 30 minutos

#### ⚠️ locales.tpl
**Necesita Revisión**: Probablemente tiene direcciones e información hardcodeada
**Recomendación**: Considerar hacerlo dinámico vía settings si los locales cambian frecuentemente
**Severidad**: 🟡 MEDIA
**Esfuerzo**: Por determinar (requiere ver el archivo completo)

---

### 2. Verificaciones Funcionales

Las siguientes features existen como settings, pero requieren verificación de que funcionen correctamente:

- ⚠️ **Infinite Scrolling**: No encontrado como setting, verificar si está en JS
- ⚠️ **Ajax Cart**: Setting existe, verificar snipplets asociados
- ⚠️ **Quick Shop**: Setting existe, verificar modal implementation
- ⚠️ **WhatsApp Chat**: Archivo existe, verificar integración con `store.whatsapp`

---

## 📊 Resumen de Gaps por Severidad

### 🔴 Críticos (Bloquean Go-Live)
1. Google Tag Manager - **SIN IMPLEMENTAR**
2. WoowUp Script de Tracking - **SIN IMPLEMENTAR**
3. Tags/Secciones personalizados de productos - **TODOS FALTANTES**

**Esfuerzo Total Crítico**: ~5-6 horas

---

### 🟠 Altos (Afectan Funcionalidad Importante)
1. VWO Testing A/B - **SIN IMPLEMENTAR**
2. Templates dot.tpl y buenavibra.tpl - **NO EXISTEN**
3. URL hardcodeadas en artistas.tpl - **REQUIERE FIX**

**Esfuerzo Total Alto**: ~8-10 horas

---

### 🟡 Medios (UX y Features Secundarias)
1. Infinite Scrolling - **POR VERIFICAR**
2. Sendtric Countdown Timers - **DECIDIR SI SE USA**
3. Templates bases_condiciones.tpl, lookbook.tpl - **NO EXISTEN**
4. Popup Newsletter vs Promocional - **CLARIFICAR**

**Esfuerzo Total Medio**: ~5-7 horas

---

### ⚪ Bajos (Nice-to-Have)
1. Integraciones de Facebook - **EVALUAR USO**
2. Templates links.tpl, test.tpl - **VALIDAR NECESIDAD**

**Esfuerzo Total Bajo**: Por determinar

---

## 🎯 Recomendaciones Priorizadas

### Fase 0: Clarificaciones Urgentes (ANTES de empezar)
1. ✅ Confirmar que "luxo-completa" es el "Template RIO" mencionado
2. ✅ Validar que templates dot.tpl y buenavibra.tpl siguen en uso
3. ✅ Verificar si hay tests A/B activos en VWO
4. ✅ Decidir sobre countdown timers de Sendtric
5. ✅ Obtener credenciales de todas las integraciones

---

### Fase 1: Integraciones Críticas (Día 1 - 6 horas)
**Objetivo**: Restaurar tracking y analytics

1. **Implementar GTM** (30 min)
   - Agregar script en `layouts/layout.tpl` head
   - Agregar noscript en `layouts/layout.tpl` body
   - Container: `GTM-P4BX6JS`

2. **Implementar WoowUp Tracking** (30 min)
   - Agregar script en `layouts/layout.tpl`
   - App ID: `DoH5lCS7j`

3. **Implementar VWO** (30 min)
   - Agregar SmartCode en head
   - Account: `749150`

4. **Crear Tags de Productos** (1 hora)
   - Agregar todos los tags personalizados en `config/sections.txt`
   - Definir nombres y descripciones

5. **Fix URLs en artistas.tpl** (30 min)
   - Cambiar URLs absolutas a relativas
   - Usar `{{ store.url }}`

6. **Testing Básico** (3 horas)
   - Verificar que GTM dispare
   - Verificar tracking de WoowUp
   - Verificar tags de productos aparezcan
   - Revisar todas las páginas personalizadas existentes

---

### Fase 2: Templates Personalizados Faltantes (Día 2-3 - 10 horas)
**Objetivo**: Recrear páginas críticas del negocio

1. **Recrear dot.tpl** (4 horas)
   - Formulario con campos: email, fecha nacimiento
   - Integración API WoowUp Events
   - Tags: "dot"
   - Testing de envío

2. **Recrear buenavibra.tpl** (3 horas)
   - Formulario con campo: email
   - Integración API WoowUp Events
   - Tags: "buenavibra"
   - Testing de envío

3. **Evaluar otros templates** (3 horas)
   - Revisar necesidad de bases_condiciones.tpl
   - Revisar necesidad de lookbook.tpl
   - Revisar necesidad de links.tpl
   - Decidir si migrar o usar páginas estándar

---

### Fase 3: Verificaciones Funcionales (Día 4 - 6 horas)
**Objetivo**: Asegurar que features existentes funcionen

1. **Verificar Ajax Cart** (1 hora)
   - Probar agregar productos sin reload
   - Verificar panel de carrito
   - Testing cross-browser

2. **Verificar Quick Shop** (1 hora)
   - Probar modal desde listados
   - Verificar variantes
   - Testing mobile/desktop

3. **Verificar Infinite Scrolling** (1 hora)
   - Buscar implementación en JS
   - Si no existe, decidir si implementar
   - Testing en categorías

4. **Verificar WhatsApp Chat** (30 min)
   - Configurar `store.whatsapp`
   - Verificar botón flotante
   - Testing mobile

5. **Verificar Instagram Feed** (30 min)
   - Configurar token de Instagram
   - Verificar que muestre 9 items
   - Testing de fallback

6. **Review de locales.tpl y nft.tpl** (2 horas)
   - Verificar contenido actualizado
   - Verificar que no hay URLs hardcodeadas
   - Testing de responsive

---

### Fase 4: Optimización y Testing Final (Día 5 - 4 horas)
**Objetivo**: Pulir y optimizar antes de go-live

1. **Countdown Timers** (2 horas) - SI se decide usar
   - Crear settings dinámicos
   - Implementar en templates
   - Testing

2. **Testing de Performance** (1 hora)
   - Verificar Critical CSS
   - Verificar lazy loading
   - Lighthouse audit

3. **Testing Cross-Browser** (1 hora)
   - Chrome, Firefox, Safari
   - iOS y Android
   - Desktop y Mobile

---

## 🚨 Riesgos Identificados

### Riesgo #1: Templates Incorrectos
**Probabilidad**: Alta
**Impacto**: Crítico
**Mitigación**: Clarificar INMEDIATAMENTE si luxo-completa es el template correcto

### Riesgo #2: Integraciones Sin Credenciales
**Probabilidad**: Media
**Impacto**: Crítico
**Mitigación**: Obtener todas las credenciales ANTES de empezar Fase 1

### Riesgo #3: Templates Personalizados Desactualizados
**Probabilidad**: Media
**Impacto**: Medio
**Mitigación**: Revisar cada template con stakeholder del negocio

### Riesgo #4: Features No Documentadas
**Probabilidad**: Alta
**Impacto**: Medio
**Mitigación**: Hacer audit completo del sitio en producción antes de migrar

### Riesgo #5: Pérdida de Data/Tracking Durante Migración
**Probabilidad**: Baja (si se siguen las fases)
**Impacto**: Crítico
**Mitigación**:
- Implementar todas las integraciones ANTES de go-live
- Hacer soft launch con % de tráfico
- Monitorear GTM y WoowUp durante primeras 24h

---

## 📋 Checklist Pre-Migración (VALIDAR ANTES DE EMPEZAR)

- [ ] Confirmar que "luxo-completa" es el template correcto
- [ ] Obtener Container ID de GTM: `GTM-P4BX6JS`
- [ ] Obtener Account ID de VWO: `749150`
- [ ] Obtener App ID de WoowUp: `DoH5lCS7j`
- [ ] Verificar tests A/B activos en VWO
- [ ] Obtener token de Instagram de la tienda
- [ ] Validar qué templates personalizados siguen en uso
- [ ] Decidir sobre countdown timers de Sendtric
- [ ] Backup completo del sitio en producción
- [ ] Acceso a analytics de producción para comparar post-migración
- [ ] Lista de todos los tags de productos en uso en producción
- [ ] Contacto con stakeholder de negocio para validar páginas personalizadas

---

## 📈 Estimación Total de Esfuerzo

| Fase | Esfuerzo | Prioridad |
|------|----------|-----------|
| Fase 0: Clarificaciones | 2-3 horas (reuniones) | 🔴 CRÍTICA |
| Fase 1: Integraciones | 6 horas | 🔴 CRÍTICA |
| Fase 2: Templates | 10 horas | 🟠 ALTA |
| Fase 3: Verificaciones | 6 horas | 🟠 ALTA |
| Fase 4: Optimización | 4 horas | 🟡 MEDIA |
| **TOTAL** | **26-27 horas** | |

**Tiempo Estimado de Calendario**: 5 días hábiles (asumiendo 1 developer full-time)

---

## 🎓 Lecciones y Mejores Prácticas

### Para Esta Migración
1. ✅ NO migrar diseño/estilos - solo funcionalidad
2. ✅ Priorizar integraciones de terceros PRIMERO
3. ✅ Validar cada template personalizado con negocio
4. ✅ Hacer URLs dinámicas, nunca hardcodear dominios
5. ✅ Documentar todas las credenciales en lugar seguro

### Para Futuro
1. ✅ Mantener un inventario de integraciones de terceros
2. ✅ Documentar propósito de cada template personalizado
3. ✅ Evitar hardcodear configuraciones - usar settings
4. ✅ Mantener nomenclatura consistente (evitar RIO vs luxo-completa)
5. ✅ Crear runbook de migración para futuras migraciones

---

**Próximos Pasos Sugeridos**:
1. Revisar este documento con el equipo
2. Ejecutar Checklist Pre-Migración
3. Confirmar estimaciones y prioridades
4. Asignar recursos para Fase 1
5. Establecer fecha de go-live tentativa
