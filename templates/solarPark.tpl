{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
	{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
{% endembed %}
<div id="solarPark">
    <main>
        <img src="{{ 'images/solar park/banner solar.webp' | static_url }}" class="banner" alt="Solar Park Banner">

        <section class="welcome">
            <h2>BIENVENIDOS A SOLAR PARK ☀️</h2>
            <p>
                Nuestra planta de confección textil en el Parque Industrial de La Rioja es mucho más que un espacio de producción.
            </p>
            <p>
                Solar Park es una nave industrial de 1500 m2 equipada con 72 paneles solares que cubren 180 m² de superficie, y nos permiten generar energía renovable para alimentar gran parte de nuestras operaciones diarias
            </p>
            <p>
                Nuestro excedente de energía generado, que no llegamos a consumir, lo inyectamos a la red eléctrica del parque industrial, colaborando así con otras empresas y contribuyendo a la reducción de emisiones de CO2.
            </p>
            <p>
                En menos de un año, ya evitamos la emisión de 8,5 toneladas de dióxido de carbono. Y recién estamos empezando.
            </p>
        </section>

        <div class="content-grid">
            <img src="{{ 'images/solar park/top-grid/1.webp' | static_url }}" alt="Solar Park">
            <div>
                <p>
                    Tener nuestra propia planta nos permite controlar cada paso: desde la llegada de la materia prima hasta el producto terminado que llega a tus manos. Esto significa no solo una mejora en la calidad, sino también garantizar procesos responsables, condiciones laborales justas y un impacto ambiental minimizado.
                </p>
                <p>
                    Cada decisión dentro de Solar Park refleja los valores de LUXO: transparencia, innovación y compromiso con un futuro mejor.
                </p>
                <p>
                    Solar Park abrió sus puertas en diciembre del 2022, sumando 50 nuevos puestos de trabajo, con el objetivo de llegar a más de 150 colaboradores en los próximos años. Apostamos al talento local, a la industria nacional y a demostrar que es posible construir un negocio rentable, auténtico y con propósito.
                </p>
            </div>
            <img src="{{ 'images/solar park/top-grid/2.webp' | static_url }}" alt="Solar Park">
            <div>
                <p>
                    Esta planta fue clave para lograr nuestra certificación como Empresa B, pero más allá del sello, es un reflejo de un camino que elegimos: el camino del triple impacto, donde el crecimiento económico camina de la mano con el impacto social y ambiental.
                </p>
                <p>
                    Hay momentos que definen el camino de una empresa y una marca. Decisiones que son más que estratégicas: son una declaración de principios. LUXO Solar Park es eso para nosotrxs: el salto más grande que dimos como empresa y un verdadero compromiso con la industria nacional y la sustentabilidad. Porque lo que hacemos importa, y cómo lo hacemos, todavía más.
                </p>
            </div>
        </div>

        <h2>Nuestros datos</h2>
        <section class="datos">
            <div><span>72</span><p>Paneles solares monocristalinos</p></div>
            <div><span>182</span><p>m² de superficie cubierta</p></div>
            <div><span>50</span><p>Nuevos puestos de trabajo</p></div>
            <div><span>150</span><p>Meta de colaboradores</p></div>
            <div><span>41.000</span><p>kWh generados anualmente</p></div>
            <div><span>200</span><p>Días de operación al año</p></div>
            <div><span>19,8</span><p>Toneladas de CO₂ evitadas</p></div>
            <div><span>13,39</span><p>MWh producidos</p></div>
            <div><span>8,25</span><p>Toneladas de CO₂ compensadas</p></div>
            <div><span>+100</span><p>Empleos indirectos generados</p></div>
            <p class="pmas">Y vamos por muchos más...</p>
        </section>

        <h3>Detrás de estos números, hay humanos comprometidos.</h3>
        <p>Sabemos que la onda de la ropa no es lo único que te importa de tu marca favorita.</p>
        <p><b>A nosotros tampoco.</b></p>

        <section class="imagenes">
            <img src="{{ 'images/solar park/bottom-grid/1.webp' | static_url }}" alt="Solar Park Team">
            <img src="{{ 'images/solar park/bottom-grid/2.webp' | static_url }}" alt="Solar Park Team">
            <img src="{{ 'images/solar park/bottom-grid/3.webp' | static_url }}" alt="Solar Park Team">
            <img src="{{ 'images/solar park/bottom-grid/5.webp' | static_url }}" alt="Solar Park Team">
            <img src="{{ 'images/solar park/bottom-grid/6.webp' | static_url }}" alt="Solar Park Team">
            <img src="{{ 'images/solar park/bottom-grid/7.webp' | static_url }}" alt="Solar Park Team">
            <img src="{{ 'images/solar park/bottom-grid/8.webp' | static_url }}" alt="Solar Park Team">
            <img src="{{ 'images/solar park/bottom-grid/9.webp' | static_url }}" alt="Solar Park Team">
        </section>
    </main>
</div>
{% include 'snipplets/home/home-welcome-message.tpl' with {'institutional': true} %}
