{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
	{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
{% endembed %}

<div class="coleccion">
    <h1>COLECCIÓN</h1>
    <div class="contenedor">
        <a href="/remeras">
            <img src="{{ 'images/Colecciones/REMERAS.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>REMERAS</h3>
        </a>
        <a href="/bermudas">
            <img src="{{ 'images/Colecciones/BERMUDAS.png' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>BERMUDAS</h3>
        </a>
        <a href="/camisas">
            <img src="{{ 'images/Colecciones/CAMISAS.png' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>CAMISAS</h3>
        </a>
        <a href="/hoodies">
            <img src="{{ 'images/Colecciones/HOODIES.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>HOODIES</h3>
        </a>
        <a href="/buzos">
            <img src="{{ 'images/Colecciones/BUZOS.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>BUZOS</h3>
        </a>
        <a href="/pantalones">
            <img src="{{ 'images/Colecciones/PANTALONES.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>PANTALONES</h3>
        </a>
        <a href="/night-glasses">
            <img src="{{ 'images/Colecciones/LENTES.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>LENTES</h3>
        </a>
        <a href="/camperas">
            <img src="{{ 'images/Colecciones/CAMPERAS.png' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>CAMPERAS</h3>
        </a>
        <a href="/medias">
            <img src="{{ 'images/Colecciones/MEDIAS.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>MEDIAS</h3>
        </a>
        <a href="/hoodies-canino">
            <img src="{{ 'images/Colecciones/HOODIES CANINOS.png' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>HOODIES CANINOS</h3>
        </a>
        <a href="/accesorios">
            <img src="{{ 'images/Colecciones/ACCESORIOS.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>ACCESORIOS</h3>
        </a>
        <a href="/gift-cards">
            <img src="{{ 'images/Colecciones/GIFT CARDS.png' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>GIFTCARDS</h3>
        </a>
        <a href="/productos">
            <img src="{{ 'images/Colecciones/VER TODOS.jpg' | static_url }}" alt="Muestra coleccion">
            <p>VER COLECCIÓN</p>
            <h3>VER TODOS</h3>
        </a>
    </div>
</div>
{% include 'snipplets/home/home-welcome-message.tpl' with {'institutional': true} %}