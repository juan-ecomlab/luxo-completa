{% if product_modal %}

	{# Product video modal wrapper #}

	<div id="product-video-modal-{{ media.id }}" class="js-product-video-modal product-video" style="display: none;{% if product_native_video and media.dimensions %} --vid-aspect: {{ media.dimensions['width'] }} / {{ media.dimensions['height'] }};{% endif %}">
{% endif %}
		<div class="{% if not thumb and not product_native_video %}js-video{% endif %} {% if product_video and not product_modal %}js-video-product{% endif %} embed-responsive {% if not product_native_video or not media.dimensions %}embed-responsive-16by9{% endif %} visible-when-content-ready"{% if product_native_video and media.dimensions %} style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100 }}%; height: 0;"{% endif %}>

			{% if thumb %}
				<div class="video-player">
			{% else %}
				{% if product_modal_trigger %}

					{# Open modal in mobile with product video inside #}

					<a id="trigger-video-modal-{{ media.id }}" href="#product-video-modal-{{ media.id }}" data-fancybox="product-gallery" class="js-play-button video-player d-block d-md-none">
						<div class="video-player-icon">
							<svg class="icon-inline svg-icon-text icon-xs"><use xlink:href="#play"/></svg>
						</div>
					</a>
				{% endif %}
				<a href="javascript:void(0)" {% if product_native_video %}data-video_uid="{{ media.next_video }}"{% endif %} class="{% if product_native_video %}js-play-native-button{% else %}js-play-button{% endif %} video-player {% if product_modal_trigger %}d-none d-md-block{% endif %}">
			{% endif %}
					<div class="video-player-icon {% if thumb %}video-player-icon-small{% endif %}">
						<svg class="icon-inline icon-xs svg-icon-text icon-xs"><use xlink:href="#play"/></svg>
					</div>
			{% if thumb %}
				</div>
			{% else %}
				</a>
			{% endif %}
	

			{# Video thumbnail #}

				{% if product_native_video %}
					<div class="js-video-native-image">
						<div data-video_uid="{{ media.uid }}" class="js-external-video-iframe-container embed-responsive" data-video-color="{{ settings.accent_color | trim('#') }}" style="display:none;">
							{{ media.render | raw }}
						</div>
						<img data-video_uid="{{ media.uid }}" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ media.thumbnail }}" class="video-image lazyload" alt="{{ 'Video de' | translate }} {% if template != 'product' %}{{ product.name }}{% else %}{{ store.name }}{% endif %}">
					</div>
				{% else %}
					<div class="js-video-image">
						<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="" class="lazyload video-image fade-in" alt="{{ 'Video de' | translate }} {% if template != 'product' %}{{ product.name }}{% else %}{{ store.name }}{% endif %}" style="display: none;">
						<div class="placeholder-fade">
						</div>
					</div>
				{% endif %}

		</div>
		{% if not thumb %}

			{% if not product_native_video %}
				{# Empty iframe component: will be filled with JS on play button click #}

				{% if product.video_url %}
				{% set video_url = product.video_url %}
				{% endif %}

				<div class="js-video-iframe embed-responsive embed-responsive-16by9" style="display: none;" data-video-color="{{ settings.accent_color | trim('#') }}" data-video-url="{{ video_url }}">
				</div>

			{% endif %}


		{% endif %}
{% if product_modal %}
		{% if product_native_video %}
			<button type="button" class="js-video-mute-toggle video-mute-toggle is-muted" aria-label="{{ 'Activar sonido' | translate }}">
				<svg class="video-mute-toggle-icon video-mute-toggle-icon-muted" viewBox="0 0 512 512" aria-hidden="true">
					<path fill="currentColor" d="M215.03 71.05L126.06 160H24c-13.26 0-24 10.74-24 24v144c0 13.26 10.74 24 24 24h102.06l88.97 88.95c15.03 15.03 40.97 4.47 40.97-16.97V88.02c0-21.46-25.96-31.98-40.97-16.97zM461.64 256l45.64-45.64c6.3-6.3 6.3-16.52 0-22.82l-22.82-22.82c-6.3-6.3-16.52-6.3-22.82 0L416 210.36l-45.64-45.64c-6.3-6.3-16.52-6.3-22.82 0l-22.82 22.82c-6.3 6.3-6.3 16.52 0 22.82L370.36 256l-45.63 45.63c-6.3 6.3-6.3 16.52 0 22.82l22.82 22.82c6.3 6.3 16.52 6.3 22.82 0L416 301.64l45.64 45.64c6.3 6.3 16.52 6.3 22.82 0l22.82-22.82c6.3-6.3 6.3-16.52 0-22.82L461.64 256z"/>
				</svg>
				<svg class="video-mute-toggle-icon video-mute-toggle-icon-unmuted" viewBox="0 0 480 512" aria-hidden="true">
					<path fill="currentColor" d="M215.03 71.05L126.06 160H24c-13.26 0-24 10.74-24 24v144c0 13.26 10.74 24 24 24h102.06l88.97 88.95c15.03 15.03 40.97 4.47 40.97-16.97V88.02c0-21.46-25.96-31.98-40.97-16.97zM480 256c0-63.53-32.06-121.94-85.77-156.24-11.19-7.14-26.03-3.82-33.12 7.46s-3.78 26.21 7.41 33.36C408.27 165.97 432 209.11 432 256s-23.73 90.03-63.48 115.42c-11.19 7.14-14.5 22.07-7.41 33.36 6.51 10.36 21.12 15.14 33.12 7.46C447.94 377.94 480 319.54 480 256zm-141.77-76.87c-11.58-6.33-26.19-2.16-32.61 9.45-6.39 11.61-2.16 26.2 9.45 32.61C327.98 228.28 336 241.63 336 256c0 14.38-8.02 27.72-20.92 34.81-11.61 6.41-15.84 21-9.45 32.61 6.43 11.66 21.05 15.8 32.61 9.45 28.23-15.55 45.77-45 45.77-76.88s-17.54-61.32-45.78-76.86z"/>
				</svg>
			</button>
		{% endif %}
	</div>
{% endif %}