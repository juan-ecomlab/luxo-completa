{% if (settings.brands and settings.brands is not empty) or params.preview %}
	<div class="js-section-brands pb-5{% if not settings.brands_title %} pt-5{% endif %}">
		<div class="container">
			<h2 class="js-brands-title h5 section-title mb-0 text-center"{% if not settings.brands_title %} style="display:none"{% endif %}>{{ settings.brands_title }}</h2>
		</div>
		<div class="position-relative pb-3">
			<div class="container pr-0 pr-md-3">
				<div class="js-swiper-brands brand-swiper swiper-container">
					<div class="js-swiper-brands-wrapper swiper-wrapper">
						{% for slide in settings.brands %}
							<div class="swiper-slide slide-container text-center">
								{% if slide.link %}
									<a href="{{ slide.link | setting_url }}" title="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}" aria-label="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}">
								{% endif %}
									<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('large') }}" class="lazyload brand-image" alt="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}">
								{% if slide.link %}
									</a>
								{% endif %}
							</div>
						{% endfor %}
					</div>
				</div>
			</div>
			<div class="js-swiper-brands-prev swiper-button-prev d-none d-md-block ml-3 svg-icon-text">
				<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
			</div>
			<div class="js-swiper-brands-next swiper-button-next d-none d-md-block mr-3 svg-icon-text">
				<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
			</div>
		</div>
	</div>
{% endif %}
