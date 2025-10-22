{% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
{% set has_footer_contact_info = (store.whatsapp or store.phone or store.email or store.address or store.blog) and settings.footer_contact_show %}          

{% set has_footer_menu = settings.footer_menu and settings.footer_menu_show %}
{% set has_footer_menu_secondary = settings.footer_menu_secondary and settings.footer_menu_secondary_show %}
{% set has_footer_about = settings.footer_about_show and (settings.footer_about_title or settings.footer_about_description) %}
{% set has_payment_logos = settings.payments %}
{% set has_shipping_logos = settings.shipping %}
{% set has_shipping_payment_logos = has_payment_logos or has_shipping_logos %}

{% set has_seal_logos = store.afip or ebit or settings.custom_seal_code or ("seal_img.jpg" | has_custom_image) %}
{% set show_help = not has_products and not has_social_network %}
<footer class="js-footer js-hide-footer-while-scrolling display-when-content-ready{% if settings.show_tab_nav %} pb-5 pb-md-0{% endif %}" data-store="footer">
	<div class="container-fluid">
		{# Footer Content Wrapper - 70% desktop, 80% mobile #}
		<div class="footer-content-wrapper">
			{# ROW 1: Three columns - Seal+Newsletter+Social | Contact (Secondary Menu) | FAQs (Primary Menu) #}
			<div class="row mb-4 footer-row-1">

				{# Column 1: Seal + Newsletter + Social Icons #}
				{% if settings.news_show or has_social_network %}
					<div class="col-12 col-md-4 mb-4 mb-md-0">
						{% if "seal_img.jpg" | has_custom_image %}
							<div class="footer-logo custom-seal logo-footer-desktop d-none d-md-block mb-3">
								<span class="footer-logo-wrapper">
									{% if settings.seal_url != '' %}
										<a href="{{ settings.seal_url | setting_url }}" target="_blank">
									{% endif %}
										<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "seal_img.jpg" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
									{% if settings.seal_url != '' %}
										</a>
									{% endif %}
								</span>
							</div>
						{% endif %}
						{% include 'snipplets/newsletter.tpl' %}
						{% include "snipplets/social/social-links.tpl" %}
					</div>
				{% endif %}

				{% if template != 'password' %}

					{# Column 2: Contact/Secondary Menu #}
					{% if has_footer_menu_secondary %}
						<div class="col-12 col-md-4 mb-4 mb-md-0">
							<div class="{% if settings.footer_menus_toggle %}js-accordion-container{% endif %}">
								{% if settings.footer_menus_toggle %}
									<a href="#" class="js-accordion-toggle-mobile row no-gutters">
								{% endif %}
									{% if settings.footer_menu_secondary_title %}
										<div class="subtitle mb-3 {% if settings.footer_menus_toggle %}col{% endif %}">{{ settings.footer_menu_secondary_title }}</div>
									{% endif %}
								{% if settings.footer_menus_toggle %}
										<span class="d-md-none">
											<span class="js-accordion-toggle-inactive">
												<svg class="icon-inline icon-w-14 icon-lg icon-rotate-90"><use xlink:href="#chevron"/></svg>
											</span>
											<span class="js-accordion-toggle-inactive" style="display: none;">
												<svg class="icon-inline icon-w-14 icon-lg icon-rotate-90-neg"><use xlink:href="#chevron"/></svg>
											</span>
										</span>
									</a>
									<div class="js-accordion-content js-accordion-content-mobile">
								{% endif %}
										{% include "snipplets/navigation/navigation-foot-secondary.tpl" %}
								{% if settings.footer_menus_toggle  %}
									</div>
								{% endif %}
							</div>
						</div>
					{% endif %}

					{# Column 3: FAQs/Primary Menu #}
					{% if has_footer_menu %}
						<div class="col-12 col-md-4 mb-4 mb-md-0">
							<div class="{% if settings.footer_menus_toggle %}js-accordion-container{% endif %}">
								{% if settings.footer_menus_toggle %}
									<a href="#" class="js-accordion-toggle-mobile row no-gutters">
								{% endif %}
									{% if settings.footer_menu_title %}
										<div class="subtitle mb-3 {% if settings.footer_menus_toggle %}col{% endif %}">{{ settings.footer_menu_title }}</div>
									{% endif %}
								{% if settings.footer_menus_toggle %}
										<span class="d-md-none">
											<span class="js-accordion-toggle-inactive">
												<svg class="icon-inline icon-w-14 icon-lg icon-rotate-90"><use xlink:href="#chevron"/></svg>
											</span>
											<span class="js-accordion-toggle-inactive" style="display: none;">
												<svg class="icon-inline icon-w-14 icon-lg icon-rotate-90-neg"><use xlink:href="#chevron"/></svg>
											</span>
										</span>
									</a>
									<div class="js-accordion-content js-accordion-content-mobile">
								{% endif %}
										{% include "snipplets/navigation/navigation-foot.tpl" %}
								{% if settings.footer_menus_toggle %}
									</div>
								{% endif %}
							</div>
						</div>
					{% endif %}

				{% endif %}

			</div>

			{# Logos Payments and Shipping #}
			{% if has_shipping_payment_logos and template != 'password' %}
				<div class="footer-payments-shipping-logos text-center mb-4">
					{% if has_payment_logos %}
						<span class="mr-2-md">{% include "snipplets/logos-icons.tpl" with {'payments': true} %}</span>
					{% endif %}
					{% if has_shipping_logos %}
						<span>{% include "snipplets/logos-icons.tpl" with {'shipping': true} %}</span>
					{% endif %}
				</div>
			{% endif %}

			{# Language selector #}
			{% if languages | length > 1 and settings.languages_footer and template != 'password' %}
				<div class="row mb-4">
					<div class="col-6 offset-3 col-md-2 offset-md-5">
						{% include "snipplets/navigation/navigation-lang.tpl" %}
					</div>
				</div>
			{% endif %}

			{# ROW 2: Copyright + Consumer Defense + Regret Button #}
			{% if template != 'password' %}
				<div class="footer-row-2 mb-4">
					<div class="footer-copyright-section text-left">
						<span>Copyright LUXO | Ropa sin género para humanos. {{ "now" | date('Y') }}. Todos los derechos reservados.</span>
						<br>
						<span>Defensa de las y los consumidores. Para reclamos <a href="https://autogestion.produccion.gob.ar/consumidores" target="_blank">ingrese aquí</a></span>
						<br>
						<a href="https://api.whatsapp.com/send/?phone=5491126193903&text&type=phone_number&app_absent=0" target="_blank" class="footer-regret-button">BOTÓN DE ARREPENTIMIENTO</a>
					</div>
				</div>
			{% endif %}

			{# ROW 3: AFIP QR Code #}
			{% if has_seal_logos and template != 'password' %}
				<div class="footer-row-3 text-center mb-4">
					{% if store.afip %}
						<div class="footer-logo afip seal-afip d-inline-block">
							{{ store.afip | raw }}
						</div>
					{% endif %}
					{% if ebit %}
						<div class="footer-logo ebit seal-ebit d-inline-block">
							{{ ebit }}
						</div>
					{% endif %}
					{% if settings.custom_seal_code %}
						<div class="custom-seal custom-seal-code d-inline-block">
							{{ settings.custom_seal_code | raw }}
						</div>
					{% endif %}
				</div>
			{% endif %}

			{# ROW 4: Platform Logos (TiendaNube + ECommerceLab) #}
			{% if template != 'password' %}
				<div class="footer-row-4 text-center mb-4">
					<div class="footer-platform-logos">
						{{ new_powered_by_link }}
						<a href="https://ecommercelab.agency/?utm_source=Web_LUXOAR&utm_medium=Web_LUXOAR&utm_campaign=Web_LUXOAR&utm_content=Web_LUXOAR&utm_term=Web_LUXOAR" target="_blank" class="d-inline-block eclab-link">
							<img class="logo-eclab" src="{{ 'images/eclab logo.svg' | static_url }}" alt="Logo Eclab">
						</a>
					</div>
				</div>
			{% endif %}

		</div>

		{# Mobile seal image only - outside wrapper for backward compatibility #}
		{% if "seal_img.jpg" | has_custom_image %}
			<div class="row justify-content-center mb-4">
				<div class="col text-center">
					<div class="footer-logo custom-seal logo-footer-mobile d-md-none">
						<span class="footer-logo-wrapper">
							{% if settings.seal_url != '' %}
								<a href="{{ settings.seal_url | setting_url }}" target="_blank">
							{% endif %}
								<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "seal_img.jpg" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
							{% if settings.seal_url != '' %}
								</a>
							{% endif %}
						</span>
					</div>
				</div>
			</div>
		{% endif %}

	</div>
</footer>