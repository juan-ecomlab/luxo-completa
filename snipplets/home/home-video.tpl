{% if settings.video_embed or params.preview %}
    
    {% set video_url = settings.video_embed %}
    {% set video_format = 
        '/watch?v=' in video_url ? '/watch?v=' :
        '/youtu.be/' in video_url ? '/youtu.be/' :
        '/shorts/' in video_url ? '/shorts/'
    %}
    {% set video_id = video_url|split(video_format)|last %}
    {% set video_has_autoplay = settings.video_type == 'autoplay' %}
    {% set video_has_sound = settings.video_type == 'sound' %}
    {% set custom_video_image = "video_image.jpg" | has_custom_image %}
    {% set has_video_first = settings.home_order_position_1 == 'video' %}

    <div class="js-section-video" data-transition="fade-in-up" {% if settings.head_transparent %}data-header-type="transparent-on-section"{% endif %}>
        <div class="container-fluid p-0">
            <div class="row no-gutters">
                <div class="col-12">
                    {% set has_video_text = (settings.video_title or settings.video_subtitle or settings.video_text or (settings.video_button and settings.video_button_url)) or not video_has_autoplay %}
                    <div class="js-home-video-container lazyload home-video embed-responsive embed-responsive-16by9{% if settings.video_vertical_mobile %} embed-responsive-1by1{% endif %} position-relative{% if video_has_autoplay and has_video_text %} home-video-overlay{% endif %}" data-video="{{ video_id }}" data-video-type="{{ settings.video_type }}" data-custom-thumb="{{ custom_video_image ? 'true' : 'false' }}" data-allow-custom-thumb="{{ has_video_first or video_has_sound ? 'true' : 'false' }}">
                        <a href="#" class="js-play-button video-player"{% if video_has_autoplay %} style="display: none"{% endif %}>
                        </a>
                        <div class="js-home-video-text-container home-video-text" {% if not has_video_text %}style="display: none;"{% endif %} data-home-video-sound="{{ video_has_sound ? 'true' : 'false' }}">
                            <div class="js-play-button video-player-icon mb-4" {% if video_has_autoplay %} style="display: none"{% endif %}>
                                <svg class="icon-inline icon-xs svg-icon-text icon-xs svg-icon-text"><use xlink:href="#play"/></svg>
                            </div>
                            <div class="js-home-video-subtitle subtitle mb-3" {% if not settings.video_subtitle %}style="display: none;"{% endif %}>{{ settings.video_subtitle }}</div>
                            <h2 class="js-home-video-title h1 mb-3" {% if not settings.video_title %}style="display: none;"{% endif %}>{{ settings.video_title }}</h2>
                            <p class="js-home-video-text mb-3" {% if not settings.video_text %}style="display: none;"{% endif %}>{{ settings.video_text }}</p>
                            {% set has_video_button = settings.video_button and settings.video_button_url  %}
                            <a href="{{ settings.video_button_url }}" class="js-home-video-button btn btn-secondary btn-small" {% if not has_video_button %}style="display: none;"{% endif %}>{{ settings.video_button }}</a>
                        </div>
                        <div class="js-home-video-image {% if has_video_first and video_has_autoplay %}d-block d-md-none{% endif %}" {% if not (has_video_first or video_has_sound) %} style="display: none"{% endif %}>
                            {% if custom_video_image %}
                                {% set video_image_static_url = "video_image.jpg" | static_url %}
                                {% set video_image_src = video_image_static_url | settings_image_url("large") %}
                            {% else %}
                                {% set video_image_src = 'https://img.youtube.com/vi_webp/' ~ video_id ~ '/maxresdefault.webp' %}
                            {% endif %}
                            <img class="home-video-image{% if not has_video_first %} lazyload fade-in{% endif %}" {% if not has_video_first %}data-{% endif %}src='{{ video_image_src }}'{% if custom_video_image %} {% if not has_video_first %}data-{% endif %}srcset='{{ video_image_static_url | settings_image_url("original") }} 1024w, {{ video_image_static_url | settings_image_url("1080p") }} 1920w'{% endif %} alt="{{ 'Video de' | translate }} {{ store.name }}" />
                            {% if video_has_autoplay and not theme_editor %}
                                <div class="placeholder-shine placeholder-shine-invert"></div>
                            {% endif %}
                        </div>
                        <div class="js-home-video" id="player"></div>
                        {% if video_has_autoplay %}
                            <div class="home-video-hide-controls"></div>
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    </div>
{% endif %}
