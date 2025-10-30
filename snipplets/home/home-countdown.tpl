{% set has_countdown = settings.show_countdown_home and settings.countdown_home_url %}

{% if has_countdown %}
	<section class="section-countdown-home" data-store="home-countdown">
		<div class="container-fluid">
			<div class="countdown-container">
				{% if settings.countdown_home_label %}
					<div class="countdown-label">
						{{ settings.countdown_home_label }}
					</div>
				{% endif %}
				<div class="countdown-timer" {% if settings.countdown_home_max_width %}style="max-width: {{ settings.countdown_home_max_width }}px; margin: 0 auto;"{% endif %}>
					<img src="{{ settings.countdown_home_url }}"
					     alt="{{ 'Temporizador de cuenta regresiva' | translate }}"
					     class="img-fluid" />
				</div>
			</div>
		</div>
	</section>
{% endif %}
