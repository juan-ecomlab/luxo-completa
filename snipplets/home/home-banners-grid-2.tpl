{% set banner_promotional2 = banner_promotional2 | default(false) %}

{% if banner_promotional2 %}
    {% set has_banners = settings.banner_promotional2 and settings.banner_promotional2 is not empty %}
    {% set has_mobile_banners = settings.toggle_banner_promotional2_mobile and settings.banner_promotional2_mobile and settings.banner_promotional2_mobile is not empty %}
    {% set section_banner = has_banners ? settings.banner_promotional2 : [] %}
    {% set section_banner_mobile = has_mobile_banners ? settings.banner_promotional2_mobile : [] %}

    {% set section_slider = settings.banner_promotional2_slider %}
    {% set section_columns_mobile_2 = settings.banner_promotional2_columns_mobile == 2 %}
    {% set section_columns_desktop_4 = settings.banner_promotional2_columns_desktop == 4 %}
    {% set section_columns_desktop_3 = settings.banner_promotional2_columns_desktop == 3 %}
    {% set section_columns_desktop_2 = settings.banner_promotional2_columns_desktop == 2 %}
    {% set section_columns_desktop_1 = settings.banner_promotional2_columns_desktop == 1 %}
    {% set section_same_size = settings.banner_promotional2_same_size %}
    {% set section_text_outside = settings.banner_promotional2_text_outside %}
{% else %}
    {% set section_banner = [] %}
    {% set section_banner_mobile = [] %}
{% endif %}

<div class="js-banners-promotional2 container-fluid">
    {% if section_banner is not empty %}
        <div class="row d-none d-md-flex">
            {% for slide in section_banner %}
                <div class="col-12 mb-3">
                    {% if slide.link %}
                        <a href="{{ slide.link | setting_url }}">
                    {% endif %}
                    <img src="{{ slide.image | static_url }}" alt="{{ slide.title | default('Banner') }}" class="img-fluid w-100">
                    {% if slide.link %}
                        </a>
                    {% endif %}
                </div>
            {% endfor %}
        </div>
    {% endif %}

    {% if section_banner_mobile is not empty %}
        <div class="row d-flex d-md-none">
            {% for slide in section_banner_mobile %}
                <div class="col-12 mb-3">
                    {% if slide.link %}
                        <a href="{{ slide.link | setting_url }}">
                    {% endif %}
                    <img src="{{ slide.image | static_url }}" alt="{{ slide.title | default('Banner') }}" class="img-fluid w-100">
                    {% if slide.link %}
                        </a>
                    {% endif %}
                </div>
            {% endfor %}
        </div>
    {% endif %}
</div>

