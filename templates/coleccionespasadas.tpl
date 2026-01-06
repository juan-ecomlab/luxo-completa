{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
	{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
{% endembed %}

<div class="pasadas">
	<h1>COLECCIONES PASADAS</h1>

	<!-- p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Nam amet libero porro enim cumque nobis esse quibusdam? Expedita necessitatibus inventore aperiam harum corporis unde commodi, asperiores nostrum iusto quis veritatis.</p -->
	<div
		class="carousel">
		<!-- Radios -->
		<input type="radio" name="slider" id="slide1" checked>
		<input type="radio" name="slider" id="slide2">
		<input type="radio" name="slider" id="slide3">
		<input type="radio" name="slider" id="slide4">
		<input type="radio" name="slider" id="slide5">
		<input type="radio" name="slider" id="slide6">
		<input type="radio" name="slider" id="slide7">
		<input type="radio" name="slider" id="slide8">
		<input type="radio" name="slider" id="slide9">
		<input
		type="radio" name="slider" id="slide10">

		<!-- Imágenes -->
		<div class="carousel-images">

			<img src="{{ 'images/Colecciones pasadas/temp. pasadas-01.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-02.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-03.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-04.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-05.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-06.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-07.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-08.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-09.jpg' | static_url }}" alt="">
            <img src="{{ 'images/Colecciones pasadas/temp. pasadas-10.jpg' | static_url }}" alt="">
			
		</div>

		<!-- Flechas -->
		<div
			class="nav">
			<!-- prev -->
			<label for="slide10" class="prev">&#10094;</label>
			<label for="slide1" class="prev">&#10094;</label>
			<label for="slide2" class="prev">&#10094;</label>
			<label for="slide3" class="prev">&#10094;</label>
			<label for="slide4" class="prev">&#10094;</label>
			<label for="slide5" class="prev">&#10094;</label>
			<label for="slide6" class="prev">&#10094;</label>
			<label for="slide7" class="prev">&#10094;</label>
			<label for="slide8" class="prev">&#10094;</label>
			<label for="slide9" class="prev">&#10094;</label>

			<!-- next -->
			<label for="slide2" class="next">&#10095;</label>
			<label for="slide3" class="next">&#10095;</label>
			<label for="slide4" class="next">&#10095;</label>
			<label for="slide5" class="next">&#10095;</label>
			<label for="slide6" class="next">&#10095;</label>
			<label for="slide7" class="next">&#10095;</label>
			<label for="slide8" class="next">&#10095;</label>
			<label for="slide9" class="next">&#10095;</label>
			<label for="slide10" class="next">&#10095;</label>
			<label for="slide1" class="next">&#10095;</label>
		</div>

		<!-- Indicadores -->
		<div class="carousel-nav">
			<label for="slide1"></label>
			<label for="slide2"></label>
			<label for="slide3"></label>
			<label for="slide4"></label>
			<label for="slide5"></label>
			<label for="slide6"></label>
			<label for="slide7"></label>
			<label for="slide8"></label>
			<label for="slide9"></label>
			<label for="slide10"></label>
		</div>
	</div>
</div>
{% include 'snipplets/home/home-welcome-message.tpl' with {'institutional': true} %}
