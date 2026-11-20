{# Countdown timer, shared by home and category pages.
   Include with {countdown_context: 'category'} from category.tpl.
   IDs are for the JS (static/js/store.js.tpl); styles target classes only. #}

{% set countdown_is_category = countdown_context == 'category' %}
{% set has_countdown = countdown_is_category ? settings.show_countdown_category : settings.show_countdown_home %}
{% set countdown_has_title = settings.countdown_home_title or settings.countdown_home_title_2 %}

{% if has_countdown %}

	<section class="section-countdown-home{% if settings.countdown_style and settings.countdown_style != 'default' %} section-countdown-{{ settings.countdown_style }}{% endif %}" data-store="{{ countdown_is_category ? 'category-countdown' : 'home-countdown' }}" id="countdown">
		<div class="container-fluid">
			<div class="countdown-container">
				<div class="countdownTitle">
					{% if countdown_has_title or settings.countdown_home_label %}
						<div class="countdown-heading">
							{% if countdown_has_title %}
								<div class="countdown-title" id="countdown-title">{{ settings.countdown_home_title }}</div>
							{% endif %}
							{% if settings.countdown_home_label %}
								<div class="countdown-label" {% if settings.countdown_home_label_color %}style="color: {{ settings.countdown_home_label_color }};"{% endif %}>
									{{ settings.countdown_home_label }}
								</div>
							{% endif %}
						</div>
					{% endif %}

					<div class="countdown" {% if settings.countdown_home_numbers_color %}style="color: {{ settings.countdown_home_numbers_color }};"{% endif %}>
						<div class="grupo">
							<p class="grande" id="dias">00</p>
							<p class="chico"><span class="countdown-unit-long">{{ 'Días' | translate }}</span><span class="countdown-unit-short">{{ 'Días' | translate }}</span></p>
						</div>
						<div class="grupo">
							<p class="grande" id="horas">00</p>
							<p class="chico"><span class="countdown-unit-long">{{ 'Horas' | translate }}</span><span class="countdown-unit-short">{{ 'Hs' | translate }}</span></p>
						</div>
						<div class="grupo">
							<p class="grande" id="minutos">00</p>
							<p class="chico"><span class="countdown-unit-long">{{ 'Minutos' | translate }}</span><span class="countdown-unit-short">{{ 'Min' | translate }}</span></p>
						</div>
						<div class="grupo">
							<p class="grande" id="segundos">00</p>
							<p class="chico"><span class="countdown-unit-long">{{ 'Segundos' | translate }}</span><span class="countdown-unit-short">{{ 'Seg' | translate }}</span></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

{% endif %}
