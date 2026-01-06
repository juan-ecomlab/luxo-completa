{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
	{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
{% endembed %}
<div class="empresab">
    <img src="{{ 'images/empresab/banner-empresab.webp' | static_url }}" alt="" class="bannerDesktop">
     <img src="{{ 'images/empresab/b-mobile.png' | static_url }}" alt="" class="bannerMobile">
    <section class="responsabilidad">
        <h2>RESPONSABILIDAD - TRANSPARENCIA - CONSCIENCIA</h2>
        <P>Nuestro mundo actual está evolucionando hacia modelos de negocio más conscientes, sostenibles y responsables y en LUXO estamos firmemente comprometidos en ser parte de este cambio.</P>
        <div class="responsabilidad-grid">
            <img src="{{ 'images/empresab/triangulo.webp' | static_url }}" alt="">
            <div>
                <p>Certificar B significa que logramos un impacto positivo en tres áreas claves: social, ambiental y económica. Para obtener la distintiva, tuvimos que cumplir algunos requisitos y también comprometernos a otros:</p>
                <p>Sacar 80 puntos o + en una evaluación sobre nuestro impacto en el medio ambiente, los empleados, los clientes y la comunidad. Lo medimos cuando no solo a los accionistas, sino también a todos nuestros grupos de interés: empleados, clientes, proveedores y adversarios organizacionales dentro y fuera de nuestra empresa. Vamos a recibir auditorías aleatorias y verificaciones presenciales para garantizar el cumplimiento de los estándares que mantenemos.</p>
                <p>Por último, debemos renovar nuestro estado cada tres años y cumplir con un requisito adicional, la transparencia. Esto implica que toda la información sobre nuestro desempeño está fácilmente disponible en el sitio web de la ONG estadounidense que nos otorgó la certificación B. B. Lab.</p>
                <p>Ahora que ya sabés de qué se trata ser B, cada vez que veas el logo vas a entender el valor que tiene y porqué es tan importante para nosotros poder decir "SOMOS EMPRESA B CERTIFICADA".</p>
            </div>
        </div>
    </section>
    <section class="carbono">
        <h2>SOMOS CARBONO NEUTRAL</h2>
        <P>Por nuestra <b>Huella de Carbono</b> del 2022, medida en 37,76 TnCO2e, decidimos <b>compensar el 100% de nuestras emisiones</b> contribuyendo económicamente a los siguientes proyectos:</P>
        <div>
            <article>
                <span class="proyecto-header">PROYECTO</span>
                <h2>PARQUE EÓLICO</h2>
                <h4>CHUBUT ARGENTINA</h4>
                <p>Se compenso 16 ThCO2e, <b>representa un 40%</b></p>
                <span class="farm-name">[Merrimás Báir Wind Farm]</span>
            </article>
            <article>
                <span class="proyecto-header">PROYECTO</span>
                <h2>FORESTACIÓN</h2>
                <h4>URUGUAY ORIENTAL</h4>
                <p>Se compensó 8 TnCO2e, <b>representa un 20%</b></p>
                <span class="farm-name">[Lumin/Euquipie Uruguay Forest]</span>
            </article>
            <article>
                <span class="proyecto-header">PROYECTO</span>
                <h2>BIOMASA</h2>
                <h4>TUCUMÁN ARGENTINA</h4>
                <p>Se compensó 16 TnCO2e, <b>representa un 40%</b></p>
                <span class="farm-name">[Fuel Switching Project]</span>
            </article>
        </div>
        <div class="logos">
            <img src="{{ 'images/empresab/carbon_neutral_B.svg' | static_url }}" alt="">
            <img src="{{ 'images/empresab/verra.svg' | static_url }}" alt="">
            <img src="{{ 'images/empresab/VCSLogoColor.png' | static_url }}" alt="">
        </div>
    </section>
    <section class="adicional">
        <h2>ADICIONALMENTE</h2>
        <p>Contribuimos económicamente para que se planten 10 árboles con BAUM–Fábrica de Árboles, 31 árboles con Asociación Amigos de Patagonia y 9 árboles con Seamos Bosques.</p>
        <div>
            <article>
                <div class="image-container">
                    <img src="{{ 'images/empresab/baumfda_logo.jfif' | static_url }}" alt="">
                </div>
                <div class="text-container">
                    <h3>PROYECTO FORESTACIÓN:</h3>
                    <p>Adicionalmente ha generado un plus de impacto: <br>
                    La plantación de 10 árboles junto a BAUM – Fábrica de Árboles.</p>
                </div>
            </article>
            <article>
                <div class="image-container">
                    <img src="{{ 'images/empresab/Logo-Seamos-Bosques.png' | static_url }}" alt="">
                </div>
                <div class="text-container">
                    <h3 class="distinto">PROYECTO FORESTACIÓN:</h3>
                    <p>Adicionalmente ha generado un plus de impacto: <br>
                    La plantación de 9 árboles junto a SeamosBosques.</p>
                </div>
            </article>
            <article>
                <div class="image-container">
                    <img src="{{ 'images/empresab/LOGO-AAP-EN-PNG.png' | static_url }}" alt="">
                </div>
                <div class="text-container">
                    <h3>PROYECTO FORESTACIÓN:</h3>
                    <p>Adicionalmente ha generado un plus de impacto: <br>
                    La plantación de 31 árboles junto a la Asociación Amigos de la Patagonia.</p>
                </div>
            </article>
        </div>
            
        </section>
    </div>
    {% include 'snipplets/home/home-welcome-message.tpl' with {'institutional': true} %}