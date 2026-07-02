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

	<section class="section-countdown-home" data-store="home-countdown" id="countdown">
		<div class="container-fluid">
			<div class="countdown-container">
				{% if settings.countdown_home_label %}
					<div class="countdown-label" {% if settings.countdown_label_color %}style="color: {{ settings.countdown_label_color }};"{% endif %}>
						{{ settings.countdown_home_label }}
					</div>
				{% endif %}
				<div class="countdownTitle" >
            
           <div class="countdown" {% if settings.countdown_numbers_color %}style="color: {{ settings.countdown_numbers_color }};"{% endif %}>
                <div class="grupo">
                    <p class="grande" id="dias">00</p>
                    <p class="chico">DIAS</p>
                </div>
                <div class="grupo">
                    <p class="grande" id="horas">00</p>
                    <p class="chico">HORAS</p>
                </div>
                <div class="grupo">
                    <p class="grande" id="minutos">00</p>
                    <p class="chico">MINUTOS</p>
                </div>
                <div class="grupo">
                    <p class="grande" id="segundos">00</p>
                    <p class="chico">SEGUNDOS</p>
                </div>
            </div>
        </div>
			</div>
		</div>
	</section>
{% endif %}
