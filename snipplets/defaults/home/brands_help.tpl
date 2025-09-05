{# Brands that work as examples #}

<div class="js-section-brands js-brands-placeholder pb-5 position-relative">
	<div class="container">
		<h2 class="js-brands-title h5 section-title mb-0 text-center">{{ 'Nuestras marcas' | translate }}</h2>
	</div>
	<div class="position-relative pb-3">
		<div class="container pr-0 pr-md-3">
			<div class="js-swiper-empty-brands brand-swiper swiper-container">
				<div class="swiper-wrapper">
					{% for i in 1..16 %}
						<div class="swiper-slide slide-container text-center">
							{{ component('placeholders/brand-placeholder' , {
								placeholder_classes: {
									svg_class: 'brand-image svg-icon-text',
								}})
							}}
						</div>
					{% endfor %}
				</div>
			</div>
		</div>
		<div class="js-swiper-empty-brands-prev swiper-button-prev d-none d-md-block ml-3 svg-icon-text">
			<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
		</div>
		<div class="js-swiper-empty-brands-next swiper-button-next d-none d-md-block mr-3 svg-icon-text">
			<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
		</div>
	</div>
	{% if not params.preview %}
		<div class="placeholder-overlay transition-soft">
			<div class="placeholder-info">
				<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
				<div class="placeholder-description font-small-xs my-2">
					{{ "Podés subir logos desde" | translate }} <strong>"{{ "Marcas" | translate }}"</strong>
				</div>
				<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-secondary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
			</div>
		</div>
	{% endif %}
</div>

{# Skeleton of "true" section accessed from instatheme.js #}
<div class="js-brands-top" style="display:none">
	{% include 'snipplets/home/home-brands.tpl' %}
</div>