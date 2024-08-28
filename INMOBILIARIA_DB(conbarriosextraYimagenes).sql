use master
GO

create database INMOBILIARIA_DB
GO

use INMOBILIARIA_DB
GO

set dateformat DMY

create table provincias(
	id_provincia int identity(1,1),
	descripcion varchar(50)
	constraint pk_provincia primary key (id_provincia)
)

create table ciudades(
	id_ciudad int identity(1,1),
	descripcion varchar(50),
	id_provincia int not null
	constraint pk_ciudad primary key (id_ciudad),
	constraint fk_ciudad_provincia foreign key (id_provincia)
		references provincias (id_provincia)
)

create table barrios(
	id_barrio int identity(1,1),
	descripcion varchar(50),
	id_ciudad int not null,
	constraint pk_barrio primary key (id_barrio),
	constraint fk_barrio_ciudad foreign key (id_ciudad)
		references ciudades (id_ciudad)
)

create table tipos_propiedad(
	id_tipo_propiedad int identity(1,1),
	descripcion varchar(50)
	constraint pk_tipo_propiedad primary key (id_tipo_propiedad)
)

create table propiedades(
	id_propiedad int identity(1,10),
	descripcion varchar(255),
	id_tipo_propiedad int not null,
	id_barrio int not null,
	direccion varchar(50) not null,
	nro_calle int,
	mt2_propiedad int,
	cant_ambiente int,
	cant_dormitorio int,
	cant_banio int,
	cochera bit,
	mascota bit,
	patio bit,
	pileta bit,
	terraza bit,
	ascensor bit,
	parrilla bit,
	sala_comun bit,
	recoleccion_dif bit,
	valor_propiedad decimal(10,2),
	valor_expensa decimal(10,2),
	disponible bit not null, -- la propiedad se encuentra alquilada?
	estado bit default 1 not null, -- atributo para la baja logica
	constraint pk_propiedad primary key (id_propiedad),
	constraint fk_propiedad_tipo foreign key (id_tipo_propiedad)
		references tipos_propiedad (id_tipo_propiedad),
	constraint fk_propiedad_barrio foreign key (id_barrio)
		references barrios (id_barrio)
)

create table imagenes_propiedad(
	id_imagen_prop int identity(1,1),
	url_imagen varchar(300),
	id_propiedad int not null,
	constraint pk_imagen_prop primary key (id_imagen_prop),
	constraint fk_imagen_prop_propiedad foreign key (id_propiedad)
		references propiedades (id_propiedad)
)

create table tipos_doc(
	id_tipo_doc int identity(1,1),
	descripcion varchar(50)
	constraint pk_tipo_doc primary key (id_tipo_doc)
)

create table propietarios(
	id_propietario int identity(1,10),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	id_tipo_doc int not null,
	nro_doc int not null,
	fec_nac datetime not null,
	direccion varchar(50),
	nro_calle int,
	id_barrio int not null,
	estado bit default 1 not null, -- atributo para la baja logica
	constraint pk_propietario primary key (id_propietario),
	constraint fk_propietario_tipo_doc foreign key (id_tipo_doc)
		references tipos_doc (id_tipo_doc),
	constraint fk_propietario_barrio foreign key (id_barrio)
		references barrios (id_barrio)
)

create table propiedades_x_propietarios(
	id_propiedad_propietario int identity(1,1),
	id_propiedad int not null,
	id_propietario int not null,
	porc_propiedad decimal(5,2) not null
	constraint fk_props_propiedad foreign key (id_propiedad)
		references propiedades (id_propiedad),
	constraint fk_props_propietario foreign key (id_propietario)
		references propietarios (id_propietario)
)

create table inquilinos(
	id_inquilino int identity(1,10),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	id_tipo_doc int not null,
	nro_doc int not null,
	fec_nac datetime not null,
	direccion varchar(50),
	nro_calle int,
	id_barrio int not null,
	alquilando bit not null,
	estado bit default 1 not null, -- atributo para la baja logica
	constraint pk_inquilino primary key (id_inquilino),
	constraint fk_inquilino_tipo_doc foreign key (id_tipo_doc)
		references tipos_doc (id_tipo_doc),
	constraint fk_inquilino_barrio foreign key (id_barrio)
		references barrios (id_barrio)
)
create table clientes(
	id_cliente int identity(1,1),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	id_tipo_doc int not null,
	nro_doc int not null,
	id_inquilino int -- para saber si es inquilino tambien
	constraint pk_clientes primary key (id_cliente),
	constraint fk_clientes_tipos_doc foreign key (id_tipo_doc)
		references tipos_doc (id_tipo_doc),
	constraint fk_clientes_inquilinos foreign key (id_inquilino)
		references inquilinos (id_inquilino)
)
--Se debe llevar un registro de sus preferencias y necesidades de búsqueda, como el tipo de propiedad que buscan, 
--ubicación, presupuesto y características específicas que necesitan en la propiedad.

create table preferencias_clientes(
	id_preferencia int identity(1,1),
	id_cliente int not null,
	id_tipo_propiedad int not null,
	id_barrio int not null,
	cant_ambiente int,
	cant_dormitorio int,
	cant_banio int,
	cochera bit,
	mascota bit,
	patio bit,
	pileta bit,
	terraza bit,
	ascensor bit,
	parrilla bit,
	sala_comun bit,
	recoleccion_dif bit,
	min_mt2 int,
	max_mt2 int,
	min_valor_propiedad decimal(10,2),
	max_valor_propiedad decimal(10,2),
	constraint pk_preferencia primary key (id_preferencia),
	constraint fk_preferencias_clientes_clientes foreign key (id_cliente)
		references clientes (id_cliente),
	constraint fk_preferencias_clientes_tipos_propiedad foreign key (id_tipo_propiedad)
		references tipos_propiedad (id_tipo_propiedad),
	constraint fk_preferencias_clientes_barrios foreign key (id_barrio)
		references barrios (id_barrio)
)

create table tipos_garantia(
	id_tipo_garantia int identity(1,1),
	descripcion varchar(255)
	constraint pk_tipo_garantia primary key (id_tipo_garantia)
)

create table contratos(
	id_contrato int identity(1,10),
	id_propiedad int not null,
	id_propietario int not null,
	id_inquilino int not null,
	fec_inicio datetime not null,
	fec_fin datetime not null,
	anios_contrato int not null,
	descripcion_pago varchar(255),  
	monto_alquiler decimal(10,2) not null, -- monto inicial del alquiler
	aumento_fijo decimal(5,2) not null,  -- porcentaje de aumento 'FIJO QUE SE PACTA EN EL CONTRATO'
	condicion_aumento int not null,  -- tiempo que define cuantas veces se va a aplicar el aumento y cada cuanto. 3 en un contrato de 3 años seria 1 aumento cada año / 6 en un contrato de 2 años serian 3 aumentos al año
	senia_alquilier bit ,  -- dependiendo el contrato se puede pedir una senia par alquilar el mismo
	monto_senia decimal(10,2),
	vigente bit, -- nos permite distuinguir si esta activo el contrato o finalizo.
	constraint pk_contrato primary key (id_contrato),
	constraint fk_contrato_propiedad foreign key (id_propiedad)
		references propiedades (id_propiedad),
	constraint fk_contrato_propietario foreign key (id_propietario)
		references propietarios (id_propietario),
	constraint fk_contrato_inquilino foreign key (id_inquilino)
		references inquilinos (id_inquilino),
)

create table garantes(
	id_garante int identity(1,1),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	id_tipo_doc int not null,
	nro_doc int not null,
	fec_nac datetime,
	direccion varchar(50) not null,
	nro_calle int not null,
	id_barrio int not null,
	estado bit default 1 not null, -- atributo para la baja logica
	constraint pk_garante primary key (id_garante),
	constraint fk_garante_tipo_doc foreign key (id_tipo_doc)
		references tipos_doc (id_tipo_doc),
	constraint fk_garante_barrio foreign key (id_barrio)
		references barrios (id_barrio)
)
-- Aca tenemos en cuenta que un garante un mismo garante puede tener varias garantias ej: una es una propiedad y la otra un recibo de sueldo
create table garantias(
	id_garantia int identity(1,1),
	id_garante int not null,
	id_tipo_garantia int not null,
	monto_garantia decimal(10,2) not null,
	constraint pk_garantia primary key (id_garantia),
	constraint fk_garantia_garante foreign key (id_garante)
		references garantes (id_garante),
	constraint fk_garantia_tipo_garantia foreign key (id_tipo_garantia)
		references tipos_garantia (id_tipo_garantia),
)

create table contratos_x_garantias(
	id_contrato_garantia int identity(1,1),
	id_contrato int not null,
	id_garantia int not null,
	constraint pk_contratos_garantias primary key (id_contrato_garantia), 
	constraint fk_contrato_gararantias_contratos foreign key (id_contrato)
		references contratos (id_contrato),
	constraint fk_contratos_garantias_garantias foreign key (id_garantia)
		references garantias (id_garantia)
)

create table roles_empleado(
	id_rol int identity(1,1),
	rol varchar(50),
	desc_rol varchar(255),
	constraint pk_roles_empleado primary key (id_rol)
)
create table empleados(
	legajo_empleado int identity(1,1),
	id_rol int not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	id_tipo_doc int not null,
	nro_doc int not null,
	fec_nac datetime,
	fec_ingreso datetime,
	direccion varchar(50),
	nro_calle int,
	id_barrio int,
	estado bit default 1 not null, -- atributo para la baja logica
	constraint pk_empleado primary key (legajo_empleado),
	constraint fk_empleado_rol foreign key (id_rol)
		references roles_empleado (id_rol),
	constraint fk_responsable_tipo_doc foreign key (id_tipo_doc)
		references tipos_doc (id_tipo_doc),
	constraint fk_responsable_barrio foreign key (id_barrio)
		references barrios (id_barrio)
)
create table sedes(
	id_sede int identity(1,1),
	nombre varchar(50),
	id_responsable int not null,
	direccion varchar(50),
	nro_calle int,
	id_barrio int not null,
	estado bit default 1 not null, -- atributo para la baja logica
	constraint pk_sede primary key (id_sede),
	constraint fk_sede_responsable foreign key (id_responsable)
		references empleados (legajo_empleado),
	constraint fk_sede_barrio foreign key (id_barrio)
		references barrios (id_barrio)
)
-- Tabla que nos va a permitir saber en que sedes trabajan los distintos empleados,
-- tenemos en cuenta que los empleados pueden trabajar en más de una sede al mismo tiempo. 
create table empleados_sedes(
	id_empleado_sede int identity(1,1),
	id_empleado int,
	id_sede int,
	constraint pk_empleados_sedes primary key (id_empleado_sede),
	constraint fk_empleado_sedes_empleados foreign key (id_empleado)
		references empleados (legajo_empleado),
	constraint fk_empleados_sedes_sedes foreign key (id_sede)
		references sedes (id_sede)
)


create table tipos_contactos(
	id_tipo_contacto int identity(1,1),
	descripcion varchar(50),
	constraint pk_tipos_contactos primary key (id_tipo_contacto)
)

create table contactos(
	id_contacto int identity (1,1),
	id_propietario int,
	id_inquilino int,
	id_garante int,
	id_sede int,
	id_empleado int,
	id_cliente int,
	contacto varchar(50), 
	id_tipo_contacto int,
	constraint pk_contactos_propietarios primary key (id_contacto),
	constraint fk_contactos_propietarios foreign key (id_propietario)
		references propietarios (id_propietario),
	constraint fk_contactos_inquilinos foreign key (id_inquilino)
		references inquilinos (id_inquilino),
	constraint fk_contactos_garantes foreign key (id_garante)
		references garantes (id_garante),
	constraint fk_contactos_sedes foreign key (id_sede)
		references sedes (id_sede),
	constraint fk_contactos_empleados foreign key (id_empleado)
		references empleados (legajo_empleado),
	constraint fk_contactos_clientes foreign key (id_cliente)
		references clientes (id_cliente),
	constraint fk_contactos_tipos_contactos foreign key (id_tipo_contacto)
		references tipos_contactos (id_tipo_contacto)
)

create table formas_pago(
	id_forma_pago int identity(1,1),
	descripcion varchar(50),
	recargo bit not null,
	porc_recargo decimal(5,2),
	constraint pk_forma_pago primary key (id_forma_pago)
)

create table recargos_mora(
	id_mora int identity(1,1),
	dias_mora int,
	porc_recargo decimal(5,2) not null,
	constraint pk_mora primary key (id_mora)
)

create table servicios(
	id_servicio int identity(1,1),
	desc_serv varchar(50),
	constraint pk_serv primary key (id_servicio)
)

create table impuestos(
	id_impuesto int identity(1,1),
	desc_impuesto varchar(50),
	constraint pk_impuesto primary key (id_impuesto)
)

create table cobros(
	id_cobro int identity(1,1),
	fec_pago datetime not null,
	id_sede int not null,
	legajo_cobrador int not null,
	id_cliente int not null,
	id_mora int,
	constraint pk_cobros primary key (id_cobro),
	constraint fk_cobros_sedes foreign key (id_sede)
		references sedes (id_sede),
	constraint fk_cobros_empleados foreign key (legajo_cobrador)
		references empleados (legajo_empleado),
	constraint fk_cobros_clientes foreign key (id_cliente)
		references clientes (id_cliente),
	constraint fk_mora foreign key (id_mora)
		references recargos_mora (id_mora)
)
-- TABLA QUE PERMITE PAGAR CON UNA O MAS FORMAS EL MONTO TOTAL DEL ALQUILER
-- EJEMPLO:
	-- MONTO DEL ALQUILER ES 100 PESOS
	-- PAGO 90% CON TRANSF (INTERES 0%) 
	-- 10% CON CREDITO (INTERES 10%)  
	-- (ALQUILER * (Porcentaje_pagado / 100)) * (porc_regargo/100) + (ALQUILER * (Porcentaje_pagado / 100) = 90 pesos
	-- ((ALQUILER * (Porcentaje_pagado / 100)) * (porc_regargo/100) ) + (ALQUILER * (Porcentaje_pagado / 100) = 11 pesos
	-- TOTAL A PAGAR = 101
create table cobros_formas_pago(
	id_cobro_forma_pago int identity(1,1),
	id_cobro int not null,
	id_forma_pago int not null,
	porcentaje_pagado decimal(5,2) not null,
	constraint pk_cobros_formas_pago primary key (id_cobro_forma_pago),
	constraint fk_cobros_formas_pago_cobros foreign key (id_cobro)
		references cobros (id_cobro),
	constraint fk_cobros_formas_pagos_formas_pago foreign key (id_forma_pago)
		references formas_pago (id_forma_pago),
)

create table detalles_cobro(
	id_detalle_cobro int identity (1,1),
	id_cobro int not null,
	id_contrato int not null,
	id_serv int,
	monto_serv decimal (10,2),
	id_imp int,
	monto_imp decimal (10,2),
	monto_alquiler decimal(10,2) not null, -- Monto que se tiene que abonar ese mes
	mes_pagado int not null,-- mes del contrato que se esta pagando
	anio_contrato int not null,-- del año del contrato que se esta pagando.
	constraint pk_detalles_cobro primary key(id_detalle_cobro),
	constraint fk_detalles_cobro foreign key (id_cobro)
		references cobros (id_cobro),
	constraint fk_cobros_contratos foreign key (id_contrato)
		references contratos (id_contrato),
	constraint fk_cobros_servicios foreign key (id_serv)
		references servicios (id_servicio),
	constraint fk_cobros_impuestos foreign key (id_imp)
		references impuestos (id_impuesto),
)

-- Tabla que nos va a permitir llevar un registro de los servicios con los que cuenta una propiedad.
create table servicios_propiedades(
	id_serv_prop int identity(1,1),
	id_propiedad int not null,
	id_servicio int not null,
	constraint pk_servicios_propiedades primary key (id_serv_prop),
	constraint fk_servicios_propiedades_propiedades foreign key (id_propiedad)
		references propiedades (id_propiedad),
	constraint fk_servicios_propiedades_servicios foreign key (id_servicio)
		references servicios (id_servicio)
)


-- INSERTS --


-- PROVINCIAS
insert into provincias (descripcion)
        values ('Buenos Aires');
insert into provincias (descripcion)
        values ('Catamarca');
insert into provincias (descripcion)
        values ('Chaco');
insert into provincias (descripcion)
        values ('Chubut');
insert into provincias (descripcion)
        values ('Ciudad Autónoma de Buenos Aires');
insert into provincias (descripcion)
        values ('Córdoba');
insert into provincias (descripcion)
        values ('Corrientes');
insert into provincias (descripcion)
        values ('Entre Ríos');
insert into provincias (descripcion)
        values ('Formosa');
insert into provincias (descripcion)
        values ('Jujuy');
insert into provincias (descripcion)
		values ('La Pampa');
insert into provincias (descripcion)
        values ('La Rioja');
insert into provincias (descripcion)
        values ('Mendoza');
insert into provincias (descripcion)
        values ('Misiones');
insert into provincias (descripcion)
        values ('Neuquén');
insert into provincias (descripcion)
        values ('Río Negro');
insert into provincias (descripcion)
        values ('Salta');
insert into provincias (descripcion)
        values ('San Juan');
insert into provincias (descripcion)
        values ('San Luis');
insert into provincias (descripcion)
        values ('Santa Cruz');
insert into provincias (descripcion)
        values ('Santa Fe');
insert into provincias (descripcion)
        values ('Santiago del Estero');
insert into provincias (descripcion)
        values ('Tierra del Fuego');
insert into provincias (descripcion)
        values ('Tucumán');


-- CIUDADES
--
insert into ciudades (descripcion, id_provincia)
        values ('La Plata', 1);
insert into ciudades (descripcion, id_provincia)
        values ('Mar del Plata', 1);
insert into ciudades (descripcion, id_provincia)
        values ('Bahía Blanca', 1);

insert into ciudades (descripcion, id_provincia)
        values ('San Fernando del Valle de Catamarca', 2);
insert into ciudades (descripcion, id_provincia)
        values ('San Isidro', 2);
insert into ciudades (descripcion, id_provincia)
        values ('San Fernando', 2);

insert into ciudades (descripcion, id_provincia)
        values ('Resistencia', 3);
insert into ciudades (descripcion, id_provincia)
        values ('Barranqueras', 3);
insert into ciudades (descripcion, id_provincia)
        values ('Fontana', 3);

insert into ciudades (descripcion, id_provincia)
        values ('Comodoro Rivadavia', 4);
insert into ciudades (descripcion, id_provincia)
        values ('Trelew', 4);
insert into ciudades (descripcion, id_provincia)
        values ('Rawson', 4);

insert into ciudades (descripcion, id_provincia)
        values ('Córdoba', 5);
insert into ciudades (descripcion, id_provincia)
        values ('Villa Carlos Paz', 5);
insert into ciudades (descripcion, id_provincia)
        values ('Río Cuarto', 5);

insert into ciudades (descripcion, id_provincia)
        values ('Corrientes', 6);
insert into ciudades (descripcion, id_provincia)
        values ('Goya', 6);
insert into ciudades (descripcion, id_provincia)
        values ('Mercedes', 6);

insert into ciudades (descripcion, id_provincia)
        values ('Paraná', 7);
insert into ciudades (descripcion, id_provincia)
        values ('Concordia', 7);
insert into ciudades (descripcion, id_provincia)
        values ('Gualeguaychú', 7);

insert into ciudades (descripcion, id_provincia)
        values ('Formosa', 8);
insert into ciudades (descripcion, id_provincia)
        values ('Clorinda', 8);
insert into ciudades (descripcion, id_provincia)
        values ('Pirané', 8);

insert into ciudades (descripcion, id_provincia)
        values ('San Salvador de Jujuy', 9);
insert into ciudades (descripcion, id_provincia)
        values ('Palpalá', 9);
insert into ciudades (descripcion, id_provincia)
        values ('San Pedro', 9);

insert into ciudades (descripcion, id_provincia)
        values ('Santa Rosa', 10);
insert into ciudades (descripcion, id_provincia)
        values ('General Pico', 10);
insert into ciudades (descripcion, id_provincia)
        values ('Toay', 10);

insert into ciudades (descripcion, id_provincia)
        values ('La Rioja', 11);
insert into ciudades (descripcion, id_provincia)
        values ('Chilecito', 11);
insert into ciudades (descripcion, id_provincia)
        values ('Aimogasta', 11);

insert into ciudades (descripcion, id_provincia)
        values ('Mendoza', 12);
insert into ciudades (descripcion, id_provincia)
        values ('San Rafael', 12);
insert into ciudades (descripcion, id_provincia)
        values ('Godoy Cruz', 12);

insert into ciudades (descripcion, id_provincia)
        values ('Posadas', 13);
insert into ciudades (descripcion, id_provincia)
        values ('Oberá', 13);
insert into ciudades (descripcion, id_provincia)
        values ('Eldorado', 13);

insert into ciudades (descripcion, id_provincia)
        values ('Neuquén', 14);
insert into ciudades (descripcion, id_provincia)
        values ('Cutral Có', 14);
insert into ciudades (descripcion, id_provincia)
        values ('Plottier', 14);

insert into ciudades (descripcion, id_provincia)
        values ('Viedma', 15);
insert into ciudades (descripcion, id_provincia)
        values ('San Carlos de Bariloche', 15);
insert into ciudades (descripcion, id_provincia)
        values ('General Roca', 15);

insert into ciudades (descripcion, id_provincia)
        values ('Salta', 16);
insert into ciudades (descripcion, id_provincia)
        values ('Orán', 16);
insert into ciudades (descripcion, id_provincia)
        values ('Tartagal', 16);

insert into ciudades (descripcion, id_provincia)
        values ('San Juan', 17);
insert into ciudades (descripcion, id_provincia)
        values ('Rawson', 17);
insert into ciudades (descripcion, id_provincia)
        values ('Caucete', 17);

insert into ciudades (descripcion, id_provincia)
        values ('San Luis', 18);
insert into ciudades (descripcion, id_provincia)
        values ('Villa Mercedes', 18);
insert into ciudades (descripcion, id_provincia)
        values ('Merlo', 18);

insert into ciudades (descripcion, id_provincia)
        values ('Río Gallegos', 19);
insert into ciudades (descripcion, id_provincia)
        values ('Caleta Olivia', 19);
insert into ciudades (descripcion, id_provincia)
        values ('El Calafate', 19);

insert into ciudades (descripcion, id_provincia)
        values ('Santa Fe', 20);
insert into ciudades (descripcion, id_provincia)
        values ('Rosario', 20);
insert into ciudades (descripcion, id_provincia)
        values ('Venado Tuerto', 20);

insert into ciudades (descripcion, id_provincia)
        values ('Santa Rosa', 21);
insert into ciudades (descripcion, id_provincia)
        values ('Villa Constitución', 21);
insert into ciudades (descripcion, id_provincia)
        values ('San Lorenzo', 21);

insert into ciudades (descripcion, id_provincia)
        values ('Santiago del Estero', 22);
insert into ciudades (descripcion, id_provincia)
        values ('La Banda', 22);
insert into ciudades (descripcion, id_provincia)
        values ('Termas de Río Hondo', 22);

insert into ciudades (descripcion, id_provincia)
        values ('Ushuaia', 23);
insert into ciudades (descripcion, id_provincia)
        values ('Río Grande', 23);
insert into ciudades (descripcion, id_provincia)
        values ('Tolhuin', 23);

insert into ciudades (descripcion, id_provincia)
        values ('San Miguel de Tucumán', 24);
insert into ciudades (descripcion, id_provincia)
        values ('Tafí Viejo', 24);
insert into ciudades (descripcion, id_provincia)
        values ('Yerba Buena', 24);


-- BARRIOS
-- La Plata, Buenos Aires
insert into barrios (descripcion, id_ciudad) 
	values ('Casco Urbano', 1);
insert into barrios (descripcion, id_ciudad) 
	values ('Tolosa', 1);
insert into barrios (descripcion, id_ciudad) 
	values ('Los Hornos', 1);
-- Mar del Plata, Buenos Aires
insert into barrios (descripcion, id_ciudad) 
    values ('Centro', 2);
-- Bahía Blanca, Buenos Aires
insert into barrios (descripcion, id_ciudad) 
    values ('Centro', 3);

-- San Fernando del Valle de Catamarca, Catamarca
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 4);
insert into barrios (descripcion, id_ciudad) 
	values ('La Chacarita', 4);
insert into barrios (descripcion, id_ciudad) 
	values ('Parque América', 4);

-- Resistencia, Chaco
insert into barrios (descripcion, id_ciudad) 
	values ('Villa San Martín', 7);
insert into barrios (descripcion, id_ciudad) 
	values ('Barrio España', 7);
insert into barrios (descripcion, id_ciudad) 
	values ('Villa Alvear', 7);

-- Comodoro Rivadavia, Chubut
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 10);
insert into barrios (descripcion, id_ciudad) 
	values ('Rada Tilly', 10);
insert into barrios (descripcion, id_ciudad) 
	values ('General Mosconi', 10);

-- Ciudad Autónoma de Buenos Aires
insert into barrios (descripcion, id_ciudad) 
	values ('Palermo', 13);
insert into barrios (descripcion, id_ciudad) 
	values ('Recoleta', 13);
insert into barrios (descripcion, id_ciudad) 
	values ('Belgrano', 13);

-- Córdoba, Córdoba
insert into barrios (descripcion, id_ciudad) 
	values ('Nueva Córdoba', 16);
insert into barrios (descripcion, id_ciudad) 
	values ('Alberdi', 16);
insert into barrios (descripcion, id_ciudad) 
	values ('Cerro de las Rosas', 16);

-- Corrientes, Corrientes
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 19);
insert into barrios (descripcion, id_ciudad) 
	values ('Boca Unidos', 19);
insert into barrios (descripcion, id_ciudad) 
	values ('Libertad', 19);

-- Paraná, Entre Ríos
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 22);
insert into barrios (descripcion, id_ciudad) 
	values ('San Agustín', 22);
insert into barrios (descripcion, id_ciudad) 
	values ('General Belgrano', 22);

-- Formosa, Formosa
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 25);
insert into barrios (descripcion, id_ciudad) 
	values ('San Martín', 25);
insert into barrios (descripcion, id_ciudad) 
	values ('Eva Perón', 25);

-- San Salvador de Jujuy, Jujuy
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 28);
insert into barrios (descripcion, id_ciudad) 
	values ('Cuyaya', 28);
insert into barrios (descripcion, id_ciudad) 
	values ('Alto Comedero', 28);

-- Santa Rosa, La Pampa
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 31);
insert into barrios (descripcion, id_ciudad) 
	values ('Villa Alonso', 31);
insert into barrios (descripcion, id_ciudad) 
	values ('Villa Santillán', 31);

-- La Rioja, La Rioja
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 34);
insert into barrios (descripcion, id_ciudad) 
	values ('Vargas', 34);
insert into barrios (descripcion, id_ciudad) 
	values ('Mataderos', 34);

-- Mendoza, Mendoza
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 37);
insert into barrios (descripcion, id_ciudad) 
	values ('Godoy Cruz', 37);
insert into barrios (descripcion, id_ciudad) 
	values ('Las Heras', 37);

-- Posadas, Misiones
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 40);
insert into barrios (descripcion, id_ciudad) 
	values ('Villa Urquiza', 40);
insert into barrios (descripcion, id_ciudad) 
	values ('El Palomar', 40);

-- Neuquén, Neuquén
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 43);
insert into barrios (descripcion, id_ciudad) 
	values ('Confluencia', 43);
insert into barrios (descripcion, id_ciudad) 
	values ('Villa María', 43);

-- Viedma, Río Negro
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 46);
insert into barrios (descripcion, id_ciudad) 
	values ('Zatti', 46);
insert into barrios (descripcion, id_ciudad) 
	values ('Guido', 46);

-- Salta, Salta
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 49);
insert into barrios (descripcion, id_ciudad) 
	values ('Tres Cerritos', 49);
insert into barrios (descripcion, id_ciudad) 
	values ('El Huaico', 49);

-- San Juan, San Juan
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 52);
insert into barrios (descripcion, id_ciudad) 
	values ('Rawson', 52);
insert into barrios (descripcion, id_ciudad) 
	values ('Rivadavia', 52);

-- San Luis, San Luis
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 55);
insert into barrios (descripcion, id_ciudad) 
	values ('La Punta', 55);
insert into barrios (descripcion, id_ciudad) 
	values ('El Trapiche', 55);

-- Río Gallegos, Santa Cruz
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 58);
insert into barrios (descripcion, id_ciudad) 
	values ('Güemes', 58);
insert into barrios (descripcion, id_ciudad) 
	values ('El Carmen', 58);

-- Santa Fe, Santa Fe
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 61);
insert into barrios (descripcion, id_ciudad) 
	values ('Candioti', 61);
insert into barrios (descripcion, id_ciudad) 
	values ('Guadalupe', 61);

-- Santiago del Estero, Santiago del Estero
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 64);
insert into barrios (descripcion, id_ciudad) 
	values ('Banda', 64);
insert into barrios (descripcion, id_ciudad) 
	values ('Yanda', 64);

-- Ushuaia, Tierra del Fuego
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 67);
insert into barrios (descripcion, id_ciudad) 
	values ('Andorra', 67);
insert into barrios (descripcion, id_ciudad) 
	values ('Alakalufes', 67);

-- San Miguel de Tucumán, Tucumán
insert into barrios (descripcion, id_ciudad) 
	values ('Centro', 70);
insert into barrios (descripcion, id_ciudad) 
	values ('Yerba Buena', 70);
insert into barrios (descripcion, id_ciudad) 
	values ('Barrio Sur', 70);

-- BARRIOS EXTRAS
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Los Troncos', 2);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Palihue', 3);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Villa Cubas', 5);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('La Chacarita', 6);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Villa Libertad', 8);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Las Malvinas', 9);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Stella Maris', 11);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Don Bosco', 12);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Nueva Córdoba', 14);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('San Vicente', 15);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Esperanza', 17);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Laguna Seca', 18);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Mosconi', 20);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Pompeya', 21);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Namqom', 23);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Evita', 24);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Alto Comedero', 26);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('20 de Julio', 27);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Los Olivos', 29);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Fiske Menuko', 30);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Ciudad del Milagro', 32);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('San Martín', 33);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Aeropuerto', 35);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Guadalupe', 36);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Luján', 38);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio San Fernando', 39);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Tafí Viejo', 41);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Lomas de Tafí', 42);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Ceferino', 46);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Tiro Federal', 48);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio San Martín', 49);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio del Carmen', 51);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Cerrillos', 52);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio 20 de Junio', 54);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Eusebio', 55);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Favaloro', 57);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('María del Carmen', 58);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Guadalupe Oeste', 60);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Santa Rosa', 61);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Don Bosco', 63);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Villa Inés', 64);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Bajo Pueyrredón', 66);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Barrio Belgrano', 67);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Chacra II', 69);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('Villa 9 de Julio', 71);
INSERT INTO barrios (descripcion, id_ciudad) VALUES ('San Felipe', 72);



-- TIPOS_PROPIEDAD
insert into tipos_propiedad (descripcion)
		values ('Bodega / Galpón');
insert into tipos_propiedad (descripcion)
		values ('Campo');
insert into tipos_propiedad (descripcion)
		values ('Casa');
insert into tipos_propiedad (descripcion)
		values ('Departamento');
insert into tipos_propiedad (descripcion)
		values ('Depósito');
insert into tipos_propiedad (descripcion)
		values ('Garage');
insert into tipos_propiedad (descripcion)
		values ('Local comercial');
insert into tipos_propiedad (descripcion)
		values ('Oficina comercial');
insert into tipos_propiedad (descripcion)
		values ('PH');
insert into tipos_propiedad (descripcion)
		values ('Quinta');
insert into tipos_propiedad (descripcion)
		values ('Terreno / lote');


-- PROPIEDADES
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Galpón céntrico, perfecto para almacenaje o taller.', 1, 60, 'Balcarce', 300, 75, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 210000, 25000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio amplio y estratégico para negocios o almacén.', 1, 1, 'San Martín', 488, 58, 3, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 160000, 25000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Almacén bien situado, ideal para negocios o depósito', 1, 1, 'Pueyrredón', 1380, 72, 4, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130000, 15000, 0, 0)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Galpón bien iluminado y espacioso, perfecto para negocios.', 1, 1, 'Sol de mayo', 875, 85, 4, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130000, 15000, 0, 0)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio amplio y versátil, ideal para almacenamiento.', 1, 1, 'Rivadavia', 731, 65, 3, 2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 120000, 20000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Galpón bien ubicado, perfecto para actividades comerciales.', 1, 1, 'Belgrano', 654, 75, 4, 2, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 140000, 18000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Amplio galpón, óptimo para almacén o logística.', 1, 37, 'Roca', 123, 95, 4, 3, 2, 1, 1, 0, 1, 1, 0, 1, 1, 1, 280000, 34000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Galpón estratégico, ideal para negocios o depósito.', 1, 4, 'Avenida San Martín', 887, 90, 4, 2, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 210000, 25000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio amplio y funcional, perfecto para almacenamiento.', 1, 65, 'Santa Fe', 1800, 110, 5, 3, 2, 1, 0, 1, 1, 1, 1, 1, 1, 1, 270000, 32000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Galpón bien acondicionado, óptimo para actividades comerciales.', 1, 60, 'Avenida Balcarce', 300, 75, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 210000, 25000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio versátil y bien ubicado para negocios o depósito.', 1, 1, 'San Lorenzo', 1211, 80, 4, 2, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 135000, 22000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Galpon ideal para almacenar trigo.', 1, 1, 'San José', 973, 70, 3, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 125000, 17000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Campo vasto, ideal para cultivo o ganadería.', 2, 1, 'Rivadavia', 731, 65, 3, 2, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 120000, 20000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Tierra fértil, perfecta para agricultura sostenible.', 2, 4, 'Avenida Belgrano', 2100, 95, 5, 3, 2, 1, 1, 1, 0, 1, 1, 1, 1, 1, 250000, 32000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Rancho pintoresco, refugio perfecto en la naturaleza.', 2, 70, 'Entre Ríos', 200, 100, 5, 3, 2, 1, 1, 1, 0, 1, 1, 1, 1, 1, 290000, 35000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Campo tranquilo, ideal para retiros o ecoturismo', 2, 24, 'Entre Ríos', 456, 110, 5, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 320000, 38000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Extensión verde, hogar perfecto para vida campestre.', 2, 70, 'Avenida Santa Fe', 1800, 105, 5, 3, 2, 1, 0, 1, 1, 1, 1, 1, 1, 1, 280000, 35000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Terreno amplio, oportunidad única para desarrollo rural.', 2, 70, 'Santa Fe', 1800, 105, 5, 3, 2, 1, 0, 1, 1, 1, 1, 1, 1, 1, 280000, 35000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Casa moderna, elegante y luminosa.', 3, 1, 'Belgrano', 654, 75, 4, 2, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 140000, 18000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Acogedora residencia en zona tranquila.', 3, 15, 'Entre Ríos', 200, 95, 5, 3, 2, 1, 1, 1, 0, 1, 1, 1, 1, 1, 250000, 30000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Hogar familiar con jardín espacioso.', 3, 4, 'Avenida Córdoba', 1800, 105, 5, 3, 2, 1, 0, 1, 1, 1, 1, 1, 1, 1, 280000, 35000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Estilo contemporáneo con vistas panorámicas.', 3, 15, 'Avenida Entre Ríos', 200, 95, 5, 3, 2, 1, 1, 1, 0, 1, 1, 1, 1, 1, 250000, 30000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Chalé encantador con detalles rústicos.', 3, 35, 'Callao', 800, 115, 6, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 310000, 38000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Casa céntrica, perfecto para urbanitas.', 3, 50, 'Bartolomé Mitre', 123, 95, 4, 3, 2, 1, 1, 0, 1, 1, 0, 1, 1, 1, 280000, 34000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Casa adosada, ideal para vida comunitaria.', 3, 51, 'Urquiza', 789, 105, 6, 3, 2, 1, 0, 1, 1, 1, 1, 1, 1, 1, 320000, 38000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Loft urbano con diseño vanguardista.', 4, 1, 'San Lorenzo', 1211, 80, 4, 2, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 135000, 22000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Piso luminoso en corazón de la ciudad.', 4, 25, 'Callao', 800, 110, 6, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 300000, 40000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Ático moderno con terraza privada.', 4, 4, 'Avenida Corrientes', 1500, 110, 6, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 300000, 40000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Estudio funcional en zona céntrica.', 4, 25, 'Avenida Callao', 800, 110, 6, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 300000, 40000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Apartamento elegante, listo para habitar.', 4, 55, 'Entre Ríos', 456, 110, 5, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 320000, 38000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Dúplex contemporáneo con vistas impresionantes.', 4, 12, 'Sarmiento', 987, 100, 5, 3, 2, 1, 0, 0, 1, 0, 1, 1, 1, 1, 300000, 36000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Almacén amplio para logística eficiente.', 5, 1, 'San José', 973, 70, 3, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 125000, 17000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Depósito seguro con acceso conveniente.', 5, 35, 'San Martín', 500, 85, 4, 2, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 220000, 27000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Espacio de almacenamiento versátil.', 5, 60, 'Urquiza', 789, 105, 6, 3, 2, 1, 0, 1, 1, 1, 1, 1, 1, 1, 320000, 38000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Bodega industrial lista para uso.', 5, 60, 'Belgrano', 654, 85, 4, 2, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 250000, 30000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
	    values ('Garaje privado con espacio adicional.', 6, 2, 'Avenida 9 de Julio', 1001, 90, 4, 3, 2, 1, 1, 0, 1, 0, 1, 1, 1, 1, 260000, 30000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Cochera segura para dos vehículos.', 6, 10, 'Avenida Constitución', 500, 78, 3, 2, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 190000, 22000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Estacionamiento techado y conveniente.', 6, 38, 'Alberdi', 321, 80, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 240000, 29000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Garaje amplio con área de almacenamiento.', 6, 10, 'Mitre', 500, 78, 3, 2, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 190000, 22000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Cochera doble con puertas automáticas.', 6, 40, 'Belgrano', 220, 100, 5, 3, 2, 1, 1, 1, 0, 1, 1, 1, 1, 1, 270000, 32000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Espacio de estacionamiento cubierto y protegido.', 6, 65, 'Sarmiento', 987, 100, 5, 3, 2, 1, 0, 0, 1, 0, 1, 1, 1, 1, 300000, 36000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio comercial en zona céntrica.', 7, 2, 'Avenida de Mayo', 605, 80, 3, 2, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 200000, 25000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Local moderno con gran visibilidad.', 7, 45, 'Rivadavia', 900, 75, 3, 2, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 200000, 25000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Tienda bien ubicada con mucho tráfico.', 7, 70, 'Belgrano', 654, 85, 4, 2, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 250000, 30000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Local en esquina con amplias vitrinas.', 7, 20, 'Avenida Alvear', 180, 95, 4, 2, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 210000, 28000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Espacio versátil para negocios variados.', 7, 17, 'San Martín', 456, 92, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 220000, 27000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Local comercial listo para su marca.', 7, 20, 'Alsina', 180, 95, 4, 2, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 210000, 28000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Oficina en edificio corporativo.', 8, 2, 'Avenida Rivadavia', 1500, 100, 5, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 280000, 35000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio ejecutivo con vistas panorámicas.', 8, 30, 'Avenida Libertador', 1500, 110, 5, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 320000, 40000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Ambiente profesional con todas las comodidades.', 8, 30, 'Belgrano', 1500, 110, 5, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 320000, 40000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Oficina amueblada en ubicación estratégica.', 8, 25, 'Alberdi', 321, 80, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 240000, 29000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Entorno de trabajo inspirador y funcional.', 8, 50, 'San Juan', 700, 85, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 230000, 28000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Oficina lista para negocios dinámicos.', 8, 49, 'Lavalle', 789, 80, 3, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 220000, 27000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('PH renovado con estilo moderno.', 9, 72, 'Roca', 1489, 98, 5, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 210000, 32000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio único con terraza privada.', 9, 3, 'Avenida Pellegrini', 220, 75, 3, 2, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 180000, 20000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Ambiente acogedor en planta baja.', 9, 40, 'Avenida San Juan', 700, 68, 3, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 180000, 21000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('PH luminoso con diseño contemporáneo.', 9, 40, 'San Juan', 700, 68, 3, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 180000, 21000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Casa tipo PH en vecindario tranquilo.', 9, 55, 'Dorrego', 1600, 92, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 240000, 29000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Residencia espaciosa con entrada independiente.', 9, 1, 'San Martín', 456, 92, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 220000, 27000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('PH con encanto original y comodidades modernas.', 9, 8, 'Bolívar', 654, 75, 4, 2, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 250000, 30000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Quinta con jardines exuberantes.', 10, 72, 'Independencia', 2145, 110, 6, 3, 2, 1, 1, 0, 1, 0, 1, 1, 1, 1, 240000, 35000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Espacio rural con piscina y árboles frutales.', 10, 3, 'Avenida Oroño', 1325, 85, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 220000, 30000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Refugio campestre con vistas panorámicas.', 10, 50, 'Avenida Dorrego', 1600, 88, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 230000, 26000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Casa de campo con huerto orgánico.', 10, 60, 'Balcarce', 300, 80, 3, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 220000, 27000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Quinta privada rodeada de naturaleza.', 10, 50, 'Dorrego', 1600, 88, 4, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 230000, 26000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
        values ('Retiro sereno con amplios espacios al aire libre.', 10, 6, 'Lavalle', 789, 80, 3, 2, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 220000, 27000, 1, 1);
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Terreno llano, ideal para construcción.', 11, 72, 'San Marcos', 2893, 102, 5, 2, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 195000, 28000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Lote en área residencial tranquila.', 11, 72, 'Roca', 1489, 98, 5, 3, 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, 210000, 32000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Parcela con servicios públicos cercanos.', 11, 72, 'Independencia', 2145, 110, 6, 3, 2, 1, 0, 1, 0, 1, 1, 1, 1, 1, 240000, 35000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Solar en desarrollo urbanístico prometedor.', 11, 72, 'San Martín', 3698, 85, 4, 2, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 200000, 30000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Terreno amplio con potencial comercial.', 11, 72, 'Belgrano', 422, 95, 5, 2, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 230000, 28000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Lote en zona de crecimiento inmobiliario.', 11, 72, 'General Paz', 155, 105, 5, 3, 2, 1, 1, 0, 1, 1, 1, 1, 1, 1, 250000, 32000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Parcela con acceso a carretera principal.', 11, 72, 'San Martín', 3698, 85, 4, 2, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 200000, 30000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Solar con vistas panorámicas.', 11, 72, 'Belgrano', 422, 95, 5, 2, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 230000, 28000, 1, 1)
insert into propiedades (descripcion, id_tipo_propiedad, id_barrio, direccion, nro_calle, mt2_propiedad, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, valor_propiedad, valor_expensa, disponible, estado)
		values ('Terreno elevado con excelente drenaje.', 11, 72, 'General Paz', 155, 105, 5, 3, 2, 1, 0, 1, 1, 1, 1, 1, 1, 1, 250000, 32000, 1, 1)

-- IMAGENES_PROPIEDAD
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 1);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/2631746/pexels-photo-2631746.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 1);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/2724748/pexels-photo-2724748.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 1);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=600', 11);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?auto=compress&cs=tinysrgb&w=600', 11);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/1115804/pexels-photo-1115804.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 21);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg?auto=compress&cs=tinysrgb&w=600', 21);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/1974596/pexels-photo-1974596.jpeg?auto=compress&cs=tinysrgb&w=600', 31);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/7174114/pexels-photo-7174114.jpeg?auto=compress&cs=tinysrgb&w=600', 31);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/5029310/pexels-photo-5029310.jpeg?auto=compress&cs=tinysrgb&w=600', 41);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/6527069/pexels-photo-6527069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 41);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/3245120/pexels-photo-3245120.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 51);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/1921035/pexels-photo-1921035.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 51);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/2102587/pexels-photo-2102587.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 61);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/4947031/pexels-photo-4947031.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 71);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/4582568/pexels-photo-4582568.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 81);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/5813019/pexels-photo-5813019.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 91);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/12663608/pexels-photo-12663608.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 101);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/9475550/pexels-photo-9475550.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 111);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/6848895/pexels-photo-6848895.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 121);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/3965528/pexels-photo-3965528.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 131);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/3197765/pexels-photo-3197765.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 141);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/3765404/pexels-photo-3765404.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 151);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/7031602/pexels-photo-7031602.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 161);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/5997992/pexels-photo-5997992.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 171);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/7031406/pexels-photo-7031406.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 181);

insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/5178055/pexels-photo-5178055.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 191);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://images.pexels.com/photos/16446849/pexels-photo-16446849/free-photo-of-coches-casas-jardin-arboles.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 191);

---------------------------------------------------
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image21.jpg', 201);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image22.jpg', 211);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image23.jpg', 221);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image24.jpg', 231);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image25.jpg', 241);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image26.jpg', 251);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image27.jpg', 261);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image28.jpg', 271);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image29.jpg', 281);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image30.jpg', 291);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image31.jpg', 301);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image32.jpg', 311);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image33.jpg', 321);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image34.jpg', 331);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image35.jpg', 341);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image36.jpg', 351);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image37.jpg', 361);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image38.jpg', 371);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image39.jpg', 381);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image40.jpg', 391);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image41.jpg', 401);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image42.jpg', 411);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image43.jpg', 421);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image44.jpg', 431);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image45.jpg', 441);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image46.jpg', 451);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image47.jpg', 461);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image48.jpg', 471);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image49.jpg', 481);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image50.jpg', 491);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image51.jpg', 501);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image52.jpg', 511);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image53.jpg', 521);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image54.jpg', 531);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image55.jpg', 541);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image56.jpg', 551);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image57.jpg', 561);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image58.jpg', 571);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image59.jpg', 581);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image60.jpg', 591);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image61.jpg', 601);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image62.jpg', 611);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image63.jpg', 621);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image64.jpg', 631);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image65.jpg', 641);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image66.jpg', 651);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image67.jpg', 661);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image68.jpg', 671);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image69.jpg', 681);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image70.jpg', 691);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image71.jpg', 701);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image72.jpg', 711);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image73.jpg', 721);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image74.jpg', 731);
insert into imagenes_propiedad (url_imagen, id_propiedad)
		values ('https://example.com/image75.jpg', 741);

-- TIPOS_DOC
insert into tipos_doc (descripcion)
		values ('Documento Nacional de Identidad (D.N.I.)');
insert into tipos_doc (descripcion)
		values ('Libreta de Enrolamiento (L.E.)');
insert into tipos_doc (descripcion)
		values ('Libreta Cívica (L.I.)');
insert into tipos_doc (descripcion)
		values ('Pasaporte');


-- PROPIETARIOS
set dateformat dmy
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Juan', 'Pérez', 1, 12345678, '15/06/1980', 'San Martín', 5000, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('María', 'Gómez', 2, 23456789, '20/09/1990', 'Belgrano', 250, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carlos', 'López', 3, 34567890, '03/04/1985', 'Rivadavia', 3500, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Ana', 'Rodríguez', 4, 45678901, '12/11/1975', 'San Juan', 1500, 20, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Pedro', 'Martínez', 1, 56789012, '25/08/1995', 'San Lorenzo', 3000, 55, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Laura', 'Fernández', 2, 67890123, '18/02/1982', 'San José', 600, 8, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Jorge', 'Díaz', 3, 78901234, '07/07/1990', 'San Luis', 2000, 25, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Silvia', 'Alvarez', 4, 89012345, '29/12/1988', 'Sarmiento', 4500, 60, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Martina', 'López', 1, 90123456, '15/06/1998', 'San Martín', 1500, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Lucas', 'García', 2, 12345678, '20/09/1987', 'Belgrano', 300, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Valentina', 'Martínez', 3, 23456789, '03/04/1992', 'Rivadavia', 4000, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Facundo', 'Rodríguez', 4, 34567890, '12/11/1980', 'San Juan', 1700, 20, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Catalina', 'Fernández', 1, 45678901, '25/08/1990', 'San Lorenzo', 3500, 55, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Agustín', 'Gómez', 2, 56789012, '18/02/1985', 'San José', 700, 8, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Victoria', 'Pérez', 3, 67890123, '07/07/1979', 'San Luis', 2200, 25, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Juan', 'Alvarez', 4, 78901234, '29/12/1996', 'Sarmiento', 5000, 60, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('María', 'López', 1, 89012345, '15/06/1995', 'San Martín', 1800, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carlos', 'García', 2, 90123456, '20/09/1982', 'Belgrano', 400, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Ana', 'Martínez', 3, 12345678, '03/04/1987', 'Rivadavia', 4500, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Pedro', 'Rodríguez', 4, 23456789, '12/11/1975', 'San Juan', 1900, 20, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Laura', 'Fernández', 1, 34567890, '25/08/1993', 'San Lorenzo', 400, 17, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Ricardo', 'Gómez', 2, 45678901, '18/02/1988', 'San José', 750, 19, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Marcela', 'Pérez', 3, 56789012, '07/07/1983', 'San Luis', 2300, 22, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Diego', 'Alvarez', 4, 67890123, '29/12/1990', 'Sarmiento', 5500, 66, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carolina', 'López', 1, 78901234, '15/06/1987', 'San Martín', 2000, 30, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Jorge', 'García', 2, 89012345, '20/09/1989', 'Belgrano', 500, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Luisa', 'Martínez', 3, 90123456, '03/04/1994', 'Rivadavia', 4700, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Juan', 'Gómez', 1, 23456789, '15/06/1992', 'San Martín', 2500, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Lucía', 'Pérez', 2, 34567890, '20/09/1984', 'Belgrano', 600, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Gabriel', 'Martínez', 3, 45678901, '03/04/1978', 'Rivadavia', 4200, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('María', 'Rodríguez', 4, 56789012, '12/11/1997', 'San Juan', 2000, 20, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Diego', 'Fernández', 1, 67890123, '25/08/1991', 'San Lorenzo', 3800, 55, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Valeria', 'Gómez', 2, 78901234, '18/02/1986', 'San José', 900, 8, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carlos', 'Pérez', 3, 89012345, '07/07/1975', 'San Luis', 2400, 25, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Luisa', 'Alvarez', 4, 90123456, '29/12/1989', 'Sarmiento', 5300, 60, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Andrés', 'López', 1, 12345678, '15/06/1988', 'San Martín', 2700, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Ana', 'García', 2, 23456789, '20/09/1983', 'Belgrano', 700, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Santiago', 'Martínez', 3, 34567890, '03/04/1990', 'Rivadavia', 4300, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('María', 'Rodríguez', 4, 45678901, '12/11/1981', 'San Juan', 2100, 20, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carlos', 'Fernández', 1, 56789012, '25/08/1996', 'San Lorenzo', 3900, 55, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Valentina', 'Gómez', 2, 67890123, '18/02/1982', 'San José', 950, 8, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Pedro', 'Pérez', 3, 78901234, '07/07/1977', 'San Luis', 2500, 25, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Laura', 'Alvarez', 4, 89012345, '29/12/1994', 'Sarmiento', 5400, 60, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Jorge', 'López', 1, 90123456, '15/06/1985', 'San Martín', 2800, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Lucía', 'García', 2, 12345678, '20/09/1980', 'Belgrano', 800, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Gabriel', 'Martínez', 3, 23456789, '03/04/1974', 'Rivadavia', 4400, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carlos', 'Fernández', 1, 56789012, '25/08/1996', 'San Lorenzo', 3900, 55, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Valentina', 'Gómez', 2, 67890123, '18/02/1982', 'San José', 950, 8, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Pedro', 'Pérez', 3, 78901234, '07/07/1977', 'San Luis', 2500, 25, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Laura', 'Alvarez', 4, 89012345, '29/12/1994', 'Sarmiento', 5400, 60, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Jorge', 'López', 1, 90123456, '15/06/1985', 'San Martín', 2800, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Lucía', 'García', 2, 12345678, '20/09/1980', 'Belgrano', 800, 12, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Gabriel', 'Martínez', 3, 23456789, '03/04/1974', 'Rivadavia', 4400, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('María', 'Rodríguez', 4, 34567890, '12/11/1993', 'San Juan', 2100, 20, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Diego', 'Fernández', 1, 45678901, '25/08/1981', 'San Lorenzo', 4000, 55, 0);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Valeria', 'Gómez', 2, 56789012, '18/02/1976', 'San José', 1000, 8, 0);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carlos', 'Pérez', 3, 67890123, '07/07/1987', 'San Luis', 2600, 25, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Luisa', 'Alvarez', 4, 78901234, '29/12/1995', 'Sarmiento', 5500, 60, 0);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Andrés', 'López', 1, 89012345, '15/06/1986', 'San Martín', 2900, 35, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Ana', 'García', 2, 90123456, '20/09/1983', 'Belgrano', 900, 12, 0);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Santiago', 'Martínez', 3, 12345678, '03/04/1979', 'Rivadavia', 4500, 40, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('María', 'Rodríguez', 4, 23456789, '12/11/1998', 'San Juan', 2200, 20, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Carlos', 'Fernández', 1, 34567890, '25/08/1985', 'San Lorenzo', 4100, 55, 1);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Valentina', 'Gómez', 2, 45678901, '18/02/1980', 'San José', 1050, 8, 0);
insert into propietarios (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, estado)
		values ('Pedro', 'Pérez', 3, 56789012, '07/07/1997', 'San Luis', 2700, 25, 1);


-- PROPIEDADES_PROPIETARIOS
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (1, 231, 20);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (1, 251, 80);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (11, 161, 40);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (11, 171, 60);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (21, 151, 30);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (21, 121, 70);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (31, 191, 10);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (31, 121, 90);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (41, 251, 25);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (41, 201, 75);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (51, 81, 50);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (51, 111, 50);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (61, 221, 15);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (61, 291, 85);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (321, 101, 40);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (321, 81, 60);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (331, 61, 30);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (331, 31, 70);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (341, 1, 25);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (341, 31, 75);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (351, 61, 20);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (351, 111, 80);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (361, 141, 10);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (361, 171, 90);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (371, 191, 50);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (371, 251, 50);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (381, 301, 35);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (381, 311, 65);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (391, 91, 80);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (391, 71, 20);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (401, 151, 45);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (401, 161, 55);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (411, 191, 70);
insert into propiedades_x_propietarios (id_propiedad, id_propietario, porc_propiedad)
		values (411, 211, 30);

-- INQUILINOS
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Juan', 'Perez', 2, 123456789, '15/05/1990', 'Falsa', 123, 5, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Ana', 'Gonzalez', 3, 987654321, '25/09/1985', 'Siempre Viva', 2345, 12, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Pedro', 'Rodriguez', 1, 567891234, '10/11/1970', 'Mayor', 4321, 32, 1, 0);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Laura', 'Lopez', 4, 345678912, '20/04/1995', 'Primavera', 987, 45, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Diego', 'Martinez', 2, 219876543, '05/07/1983', 'de los Pinos', 645, 19, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Maria', 'Sanchez', 3, 876543219, '30/10/1978', 'del Sol', 3500, 63, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Carlos', 'Fernandez', 1, 456789123, '18/02/1988', 'del Bosque', 987, 28, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Sofia', 'Alvarez', 2, 567891234, '12/11/1990', 'de los Olivos', 1500, 51, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Javier', 'Gomez', 3, 345678912, '28/09/1985', 'del Rio', 4563, 10, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Luisa', 'Diaz', 4, 123456789, '05/07/1973', 'Libertad', 2750, 42, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Marcos', 'Hernandez', 1, 678912345, '20/04/1992', 'Nueva', 350, 8, 1, 0);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Valeria', 'Romero', 2, 891234567, '15/06/1981', 'Central', 2900, 38, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Raul', 'Perez', 3, 678912345, '10/12/1970', 'del Carmen', 1200, 23, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Alejandra', 'Gutierrez', 4, 456789123, '25/08/1977', 'del Trabajo', 5000, 68, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Fernando', 'Suarez', 1, 219876543, '05/03/1998', 'Mayor', 3200, 49, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Julia', 'Diaz', 2, 345678912, '28/11/1983', 'del Sol', 420, 14, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Roberto', 'Lopez', 3, 123456789, '02/07/1971', 'del Mar', 3700, 57, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Natalia', 'Martinez', 4, 891234567, '19/09/1986', 'del Rio', 650, 21, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Camila', 'Fernandez', 1, 789123456, '10/08/1995', 'San Martin', 2100, 28, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Mariano', 'Garcia', 2, 987654321, '05/06/1992', 'San Lorenzo', 1400, 40, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Lucia', 'Alvarez', 3, 654321987, '20/04/1987', 'Belgrano', 500, 15, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Jorge', 'Perez', 4, 456789123, '15/09/1980', 'San Juan', 4200, 62, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Valentina', 'Rojas', 1, 123789456, '03/12/1988', 'Santa Fe', 1900, 33, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Gabriel', 'Lopez', 2, 987654789, '18/10/1975', 'Mitre', 3200, 47, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Catalina', 'Gomez', 3, 369258147, '25/07/1996', 'Bolivar', 3800, 52, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Andres', 'Martinez', 4, 654123789, '10/04/1979', 'Belgrano', 1400, 18, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Agustina', 'Suarez', 1, 789456123, '22/11/1991', 'Urquiza', 2900, 37, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Daniel', 'Lopez', 2, 654987321, '15/08/1984', 'Mitre', 4100, 57, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Carolina', 'Torres', 3, 147852369, '28/06/1983', 'Rivadavia', 2500, 42, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Ezequiel', 'Garcia', 4, 852369147, '10/02/1978', 'Pueyrredon', 3600, 48, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Delfina', 'Fernandez', 1, 963852741, '12/09/1993', 'Belgrano', 1200, 23, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Facundo', 'Martinez', 2, 741852963, '20/07/1977', 'San Juan', 3700, 56, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Antonella', 'Sanchez', 3, 369741852, '15/04/1985', 'Mitre', 2100, 30, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Ignacio', 'Lopez', 4, 852963147, '05/11/1982', 'Belgrano', 3100, 40, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Martina', 'Gutierrez', 1, 741852963, '28/10/1989', 'Rivadavia', 4200, 65, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Lucas', 'Fernandez', 2, 963147852, '10/06/1996', 'Urquiza', 1800, 25, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Sofia', 'Alvarez', 3, 582963147, '15/07/1990', 'Mitre', 3800, 47, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Juan', 'Gonzalez', 1, 951357852, '22/05/1984', 'San Martin', 2700, 35, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Valeria', 'Lopez', 4, 753951852, '18/03/1993', 'Belgrano', 2300, 28, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Alejandro', 'Rodriguez', 2, 369258147, '25/09/1995', 'Rivadavia', 3200, 44, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Marina', 'Perez', 3, 159263487, '12/12/1990', 'Pueyrredon', 4500, 56, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Diego', 'Sanchez', 1, 258963147, '28/10/1991', 'San Juan', 3800, 48, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Luciana', 'Martinez', 2, 753951852, '18/07/1997', 'Urquiza', 2700, 36, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Pedro', 'Gutierrez', 4, 159263487, '05/06/1988', 'San Martin', 3200, 42, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Sol', 'Fernandez', 3, 258963147, '20/11/1987', 'Mitre', 4500, 58, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Emilio', 'Garcia', 1, 753951852, '15/08/1982', 'Belgrano', 1800, 27, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Camila', 'Lopez', 2, 159263487, '03/09/1994', 'Rivadavia', 3800, 40, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Marcos', 'Rodriguez', 4, 258963147, '28/12/1985', 'Pueyrredon', 2700, 35, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Elena', 'Sanchez', 3, 753951852, '10/06/1992', 'San Juan', 3200, 42, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Facundo', 'Gutierrez', 1, 159263487, '25/02/1989', 'Urquiza', 4500, 58, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Natalia', 'Martinez', 2, 258963147, '18/05/1986', 'Mitre', 1800, 27, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Luis', 'Garcia', 4, 753951852, '05/04/1990', 'Belgrano', 3800, 40, 0, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Martina', 'Rodriguez', 3, 159263487, '22/08/1996', 'Rivadavia', 3200, 42, 1, 1);
insert into inquilinos (nombre, apellido, id_tipo_doc, nro_doc, fec_nac, direccion, nro_calle, id_barrio, alquilando, estado)
		values('Carlos', 'Sanchez', 1, 258963147, '17/11/1984', 'Pueyrredon', 4500, 58, 0, 1);

-- CLIENTES
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Marcelo', 'Garcia', 2, 987654321, 301);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Valeria', 'Perez', 3, 123456789, 441);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Lucas', 'Fernandez', 4, 456789123, 101);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Andrea', 'Rodriguez', 1, 654321987, 131);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Alejandro', 'Lopez', 2, 789456123, 251);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Laura', 'Martinez', 3, 987123456, 421);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Juan', 'Gomez', 4, 852369147, 511);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Maria', 'Sanchez', 1, 369852147, 471);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Facundo', 'Diaz', 2, 963852741, 211);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Camila', 'Gutierrez', 3, 741852963, 91);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Diego', 'Torres', 4, 852963741, 321);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Lucia', 'Rojas', 1, 147258369, 371);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Martin', 'Suarez', 2, 369147852, 51);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Natalia', 'Lopez', 3, 258369147, 431);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Pablo', 'Martinez', 4, 741963852, 181);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Carolina', 'Gonzalez', 1, 852741963, 241);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Matias', 'Fernandez', 2, 963741852, 501);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Valentina', 'Perez', 3, 369741852, 361);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Ezequiel', 'Diaz', 4, 741852963, 281);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Antonella', 'Rojas', 1, 852963147, 471);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Santiago', 'Lopez', 2, 258963147, 511);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Catalina', 'Garcia', 3, 147852369, 301);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Marcos', 'Martinez', 4, 741258963, 401);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Ana', 'Fernandez', 1, 963741258, 111);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Joaquin', 'Sanchez', 2, 369741258, 161);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Belen', 'Rodriguez', 3, 852369741, 211);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Gaston', 'Diaz', 4, 147963258, 361);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc, id_inquilino)
		values('Agustina', 'Gutierrez', 1, 369147963, 471);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Ignacio', 'Suarez', 2, 852741963);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Lautaro', 'Lopez', 3, 741258963);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Florencia', 'Gonzalez', 4, 258963147);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Dario', 'Perez', 1, 963147852);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Carla', 'Rojas', 2, 147852963);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Emiliano', 'Martinez', 3, 741963258);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Micaela', 'Diaz', 4, 963258147);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Tomas', 'Garcia', 1, 258147963);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Antonia', 'Sanchez', 2, 147963258);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Juan Pablo', 'Fernandez', 3, 852369147);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Victoria', 'Lopez', 4, 369741258);
insert into clientes (nombre, apellido, id_tipo_doc, nro_doc)
		values('Nicolas', 'Rodriguez', 1, 741258963);

-- PREFERENCIAS_CLIENTES
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
		values (1, 7, 42, 3, 2, 2, 1, 0, 1, 1, 0, 1, 1, 0, 1, 30, 100, 18000, 100000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
		values (2, 5, 18, 2, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 35, 70, 15000, 80000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
		values (3, 10, 64, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 40, 120, 22000, 150000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
		values (4, 3, 27, 3, 2, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 50, 150, 25000, 180000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
		values (5, 9, 10, 2, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 25, 60, 12000, 40000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (6, 6, 34, 3, 2, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 40, 80, 20000, 100000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (7, 2, 22, 2, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 30, 70, 18000, 90000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (8, 11, 50, 4, 3, 2, 1, 1, 0, 1, 1, 1, 0, 1, 1, 45, 120, 25000, 150000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (9, 8, 15, 2, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 35, 80, 20000, 100000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (10, 3, 42, 3, 2, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 50, 100, 18000, 120000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (11, 7, 27, 2, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 30, 60, 15000, 80000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (12, 10, 55, 4, 3, 2, 1, 0, 1, 1, 0, 1, 1, 0, 1, 40, 100, 22000, 130000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (13, 5, 12, 2, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 30, 70, 18000, 90000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (14, 11, 63, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 50, 120, 25000, 150000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (15, 6, 35, 3, 2, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 40, 80, 20000, 100000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (16, 8, 16, 2, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 35, 80, 20000, 100000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (17, 3, 43, 3, 2, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 50, 100, 18000, 120000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (18, 7, 28, 2, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 30, 60, 15000, 80000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (19, 10, 56, 4, 3, 2, 1, 0, 1, 1, 0, 1, 1, 0, 1, 40, 100, 22000, 130000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (20, 5, 13, 2, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 30, 70, 18000, 90000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (21, 11, 64, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 50, 120, 25000, 150000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (22, 6, 36, 3, 2, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 40, 80, 20000, 100000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (23, 8, 17, 2, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 35, 80, 20000, 100000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (24, 3, 44, 3, 2, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 50, 100, 18000, 120000);
insert into preferencias_clientes (id_cliente, id_tipo_propiedad, id_barrio, cant_ambiente, cant_dormitorio, cant_banio, cochera, mascota, patio, pileta, terraza, ascensor, parrilla, sala_comun, recoleccion_dif, min_mt2, max_mt2, min_valor_propiedad, max_valor_propiedad)
    values (25, 7, 29, 2, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 30, 60, 15000, 80000);



-- CONTRATOS
-- Contrato 1
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (1,            1,              1,            '01/01/2024', '01/01/2027', 3,             'Aumentos anuales',         450000.00,       45.00,           3,                 1,              450000.00,      1);

-- Contrato 2
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (11,           11,             11,           '01/02/2024', '01/02/2026', 2,             'Aumentos semestrales',     500000.00,       3.00,           4,                 0,              NULL,        1);

-- Contrato 3
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (21,           21,             21,           '01/03/2024', '01/03/2025', 1,             'Aumentos trimestrales',    315000.00,       4.00,           4,                 1,              315000.00,      1);

-- Contrato 4
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (31,           31,             31,           '01/04/2024', '01/04/2026', 2,             'Aumentos anuales',         210000.00,       2.50,           2,                 0,              NULL,        1);

-- Contrato 5
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (41,           41,             41,           '01/05/2024', '01/05/2028', 4,             'Aumentos cuatrimestrales', 600000.00,        53.50,           12,                1,              600000.00,      1);

-- Contrato 6
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (51,           51,             51,           '01/03/2015', '01/03/2017', 2,             'Aumentos anuales',         80000.00,        2.00,           2,                 1,              40000.00,      0);

-- Contrato 7
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (61,           61,             61,           '01/01/2016', '01/01/2018', 2,             'Aumentos semestrales',     95000.00,        3.00,           4,                 0,              NULL,        0);

-- Contrato 8
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (71,           71,             71,           '01/04/2017', '01/04/2020', 3,             'Aumentos anuales',         120000.00,       5.00,           3,                 1,              600000.00,      0);

-- Contrato 9
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (81,           81,             81,           '01/05/2018', '01/05/2021', 3,             'Aumentos semestrales',     130000.00,       4.00,           6,                 0,              NULL,        0);

-- Contrato 10
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (91,           91,             91,           '01/06/2019', '01/06/2022', 3,             'Aumentos trimestrales',    315000.00,       3.50,           12,                1,              315000.00,      0);

-- Contrato 11
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (101,          101,            101,          '01/07/2010', '01/07/2013', 3,             'Aumentos anuales',         2100.00,       94.00,           3,                 0,              NULL,        0);

-- Contrato 12
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (111,          111,            111,          '01/08/2020', '01/08/2023', 3,             'Aumentos semestrales',     160000.00,       13.00,           6,                 1,              80000.00,      0);

-- Contrato 13
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (121,          121,            121,          '01/09/2021', '01/09/2024', 3,             'Aumentos anuales',         140000.00,       35.00,           3,                 1,              70000.00,      1);

-- Contrato 14
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (131,          131,            131,          '01/10/2022', '01/10/2024', 2,             'Aumentos trimestrales',    125000.00,       14.50,           8,                 0,              NULL,        1);

-- Contrato 15
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (141,          141,            141,          '01/11/2012', '01/11/2015', 3,             'Aumentos anuales',         9000.00,        2.50,           3,                 1,              4500.00,      0);

-- Contrato 16
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (151,          151,            151,          '01/12/2023', '01/12/2026', 3,             'Aumentos semestrales',     180000.00,       4.00,           6,                 1,              90000.00,      1);

-- Contrato 17
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (161,          161,            161,          '01/01/2011', '01/01/2014', 3,             'Aumentos anuales',         10000.00,       33.00,           3,                 0,              NULL,        0);

-- Contrato 18
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (171,          171,            171,          '01/02/2022', '01/02/2024', 2,             'Aumentos cuatrimestrales', 135000.00,       23.50,           6,                 0,              NULL,        0);

-- Contrato 19
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (181,          181,            181,          '01/03/2013', '01/03/2016', 3,             'Aumentos anuales',         11000.00,       12.00,           3,                 1,              55000.00,      0);

-- Contrato 20
INSERT INTO contratos (id_propiedad, id_propietario, id_inquilino, fec_inicio,   fec_fin,    anios_contrato, descripcion_pago,          monto_alquiler, aumento_fijo, condicion_aumento, senia_alquilier, monto_senia, vigente)
VALUES               (191,          191,            191,          '01/04/2014', '01/04/2017', 3,             'Aumentos semestrales',     14000.00,       35.00,           6,                 1,              7000.00,      0);

-- GARANTES

-- Garante 1
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,    nro_calle, id_barrio, estado)
                  VALUES ('Juan',  'Perez',       1,  12345678, '01/01/1990', 'Calle Libertad',   1199,        1,        1);
-- Garante 2
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,         direccion,    nro_calle, id_barrio, estado)
                  VALUES ('Maria', 'Gonzalez',    2,  98765432, '15/05/1985', 'Avenida Mayo',      2200,        50,       1);
-- Garante 3
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Pedro', 'Lopez',       4,  45678912, '30/11/1978', 'Calle San Martin',  3300,        35,       1);
-- Garante 4
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,    nro_calle, id_barrio, estado)
                  VALUES ('Ana',   'Martinez',    2,  32165498, '20/03/1992', 'Calle Dorrego',     444,         10,       1);
-- Garante 5
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,         direccion,      nro_calle, id_barrio, estado)
                  VALUES ('Carlos','Sanchez',     3,  65498732, '10/07/1980', 'Avenida Belgrano', 3999,        74,       1);
-- Garante 6
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Laura', 'Lopez',       2,  78945612, '10/12/1987', 'Rosario',  1500,        25,       1);

-- Garante 7
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Diego', 'Rodriguez',   1,  98712345, '05/08/1975', 'Entre Rios',265,        45,       1);

-- Garante 8
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,    nro_calle, id_barrio, estado)
                  VALUES ('Silvia', 'Garcia',     1,  65478912, '20/06/1990', 'Mendoza',  734,         5,       1);

-- Garante 9
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,        nro_calle, id_barrio, estado)
                  VALUES ('Marcos', 'Martinez',   1,  12398745, '15/03/1988', 'Santa Fe', 281,        30,       1);

-- Garante 10
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,         direccion,        nro_calle, id_barrio, estado)
                  VALUES ('Carolina','Lopez',     2,  15975328, '25/10/1985', 'Catamarca', 145,        15,       1);

-- Garante 11
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Roberto', 'Diaz',       1,  98765432, '10/01/1976', 'San Juan', 354,        50,       1);

-- Garante 12
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,        nro_calle, id_barrio, estado)
                  VALUES ('Ana', 'Sanchez',        2,  15975328, '15/05/1984', 'La Rioja', 207,        25,       1);

-- Garante 13
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Luis', 'Gutierrez',     1,  65498732, '20/11/1979', 'Jujuy',    187,        20,       1);

-- Garante 14
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Marcela', 'Suarez',    2,  98732165, '05/04/1992', 'Santiago', 370,        40,       1);

-- Garante 15
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Fernando', 'Lopez',    1,  12378945, '10/09/1980', 'Formosa',  505,         10,       1);

-- Garante 16
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Sofia', 'Martinez',    2,  78945632, '15/12/1985', 'Chaco',    2505,        35,       1);

-- Garante 17
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Javier', 'Perez',      1,  98765412, '20/03/1977', 'Tucuman',  1203,        15,       1);

-- Garante 18
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Camila', 'Gomez',      2,  12345698, '25/06/1993', 'Salta',    168,        20,       1);

-- Garante 19
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Lucas', 'Rodriguez',   1,  78965412, '30/09/1978', 'Buenos Aires',  3532,   50,       1);

-- Garante 20
INSERT INTO garantes (nombre, apellido, id_tipo_doc, nro_doc, fec_nac,       direccion,       nro_calle, id_barrio, estado)
                  VALUES ('Valentina', 'Alvarez',2,  98745632, '10/11/1990', 'Misiones', 2257,        30,       1);

-- TIPOS GARANTIAS
insert into tipos_garantia (descripcion)
					values ('título de propiedad de inmueble')
insert into tipos_garantia (descripcion)
					values ('aval bancario')
insert into tipos_garantia (descripcion)
					values ('seguro de caución')
insert into tipos_garantia (descripcion)
					values ('garantía de fianza')
insert into tipos_garantia (descripcion)
					values ('recibo de sueldo')
insert into tipos_garantia (descripcion)
					values ('certificado de ingresos')

-- GARANTIAS
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (5, 3, 260000.50);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (12, 1, 600000.75);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (9, 4, 150000.25);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (17, 5, 780000.30);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (3, 2, 930000.60);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (10, 6, 330000.25);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (14, 1, 870000.45);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (8, 3, 200000.80);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (20, 4, 520000.35);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (1, 2, 720000.90);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (16, 5, 640000.70);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (7, 6, 150000.55);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (19, 1, 390000.65);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (11, 3, 820000.40);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (4, 4, 170000.95);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (15, 5, 480000.50);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (18, 2, 960000.25);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (2, 6, 110000.75);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (13, 1, 350000.60);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (6, 3, 780000.85);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (20, 4, 890000.70);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (1, 2, 230000.40);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (16, 5, 540000.55);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (7, 6, 630000.90);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (19, 1, 460000.75);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (11, 3, 790000.80);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (4, 4, 180000.65);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (15, 5, 590000.70);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (18, 2, 870000.55);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (2, 6, 220000.80);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (13, 1, 420000.95);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (6, 3, 720000.60);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (20, 4, 850000.45);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (1, 2, 320000.70);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (16, 5, 490000.80);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (7, 6, 580000.65);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (19, 1, 510000.75);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (11, 3, 890000.90);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (4, 4, 190000.70);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (15, 5, 680000.85);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (18, 2, 920000.60);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (2, 6, 330000.75);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (13, 1, 470000.80);
INSERT INTO garantias (id_garante, id_tipo_garantia, monto_garantia) VALUES (6, 3, 770000.95);

-- CONTRATO GARANTIAS
-- Inserts para id_contrato = 1
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (1, 1);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (1, 2);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (1, 3);

-- Inserts para id_contrato = 11
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (11, 4);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (11, 5);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (11, 6);

-- Inserts para id_contrato = 21
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (21, 7);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (21, 8);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (21, 9);

-- Inserts para id_contrato = 31
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (31, 10);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (31, 11);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (31, 12);

-- Inserts para id_contrato = 41
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (41, 13);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (41, 14);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (41, 15);

-- Inserts para id_contrato = 51
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (51, 16);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (51, 17);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (51, 18);

-- Inserts para id_contrato = 61
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (61, 19);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (61, 20);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (61, 21);

-- Inserts para id_contrato = 71
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (71, 22);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (71, 23);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (71, 24);

-- Inserts para id_contrato = 81
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (81, 25);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (81, 26);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (81, 27);

-- Inserts para id_contrato = 91
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (91, 28);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (91, 29);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (91, 30);

-- Inserts para id_contrato = 101
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (101, 31);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (101, 32);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (101, 33);

-- Inserts para id_contrato = 111
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (111, 34);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (111, 35);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (111, 36);

-- Inserts para id_contrato = 121
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (121, 37);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (121, 38);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (121, 39);

-- Inserts para id_contrato = 131
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (131, 40);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (131, 41);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (131, 42);

-- Inserts para id_contrato = 141
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (141, 43);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (141, 44);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (141, 12);

-- Inserts para id_contrato = 151
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (151, 31);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (151, 13);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (151, 1);

-- Inserts para id_contrato = 161
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (161, 6);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (161, 14);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (161, 25);

-- Inserts para id_contrato = 171
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (171, 2);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (171, 4);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (171, 5);

-- Inserts para id_contrato = 181
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (181, 6);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (181, 43);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (181, 8);

-- Inserts para id_contrato = 191
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (191, 19);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (191, 24);
INSERT INTO contratos_x_garantias (id_contrato, id_garantia) VALUES (191, 21);

-- ROLES EMPLEADOS
insert into roles_empleado (rol, desc_rol)
	values ('Cobrador', 'Responsable de la gestión y recaudación de pagos.');
insert into roles_empleado (rol, desc_rol)
	values ('Asesor inmobiliario', 'Brinda asesoramiento y guía a los clientes sobre propiedades.');
insert into roles_empleado (rol, desc_rol)
	values ('Tasador', 'Realiza la valoración de propiedades para determinar su precio.');
insert into roles_empleado (rol, desc_rol)
	values ('Gerente de ventas', 'Dirige y coordina las actividades del equipo de ventas.');
insert into roles_empleado (rol, desc_rol)
	values ('Asesor legal', 'Proporciona asesoramiento legal en transacciones inmobiliarias.');


-- EMPLEADOS
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (1, 'Juan', 'Pérez', 1, 12345678, '15/03/1985', '10/05/2015', 'Mitre', 1234, 5);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (1, 'María', 'García', 2, 23456789, '20/07/1990', '12/08/2017', 'Belgrano', 2345, 10);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (1, 'Carlos', 'Rodríguez', 3, 34567890, '05/01/1995', '20/03/2019', 'San Martín', 3456, 15);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (1, 'Laura', 'Fernández', 4, 45678901, '28/02/1992', '25/06/2020', 'Sarmiento', 4567, 20);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (2, 'Miguel', 'López', 1, 56789012, '14/05/1993', '30/11/2016', 'Alvear', 5678, 25);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (2, 'Sofía', 'González', 2, 67890123, '09/09/1991', '22/01/2018', 'Rivadavia', 6789, 30);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (2, 'Diego', 'Martínez', 3, 78901234, '17/11/1987', '18/04/2019', 'Saavedra', 7890, 35);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (2, 'Ana', 'Hernández', 4, 89012345, '25/12/1994', '07/09/2015', 'Perón', 8901, 40);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (3, 'Jorge', 'Jiménez', 1, 90123456, '12/06/1986', '15/12/2014', 'Lavalle', 9012, 45);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (3, 'Elena', 'Ruiz', 2, 11234567, '01/08/1993', '10/02/2017', 'Tucumán', 1123, 50);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (4, 'Alberto', 'Díaz', 3, 12345678, '29/03/1990', '28/07/2016', 'Urquiza', 1234, 55);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (4, 'Lucía', 'Moreno', 4, 23456789, '21/11/1989', '15/05/2018', 'Alsina', 2345, 60);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (4, 'Francisco', 'Pérez', 1, 34567890, '30/07/1995', '03/11/2019', 'Laprida', 3456, 65);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (5, 'Marta', 'Sánchez', 2, 45678901, '10/04/1988', '25/03/2020', 'Mitre', 4567, 70);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (5, 'Hugo', 'Ramírez', 3, 56789012, '18/12/1987', '12/08/2021', 'Belgrano', 5678, 5);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (1, 'Carmen', 'Gómez', 4, 67890123, '03/06/1992', '20/01/2018', 'San Martín', 6789, 10);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (2, 'Raúl', 'Vega', 1, 78901234, '15/02/1991', '10/04/2016', 'Sarmiento', 7890, 15);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (2, 'Verónica', 'Torres', 2, 89012345, '11/05/1986', '08/10/2017', 'Alvear', 8901, 20);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (4, 'Javier', 'Suárez', 3, 90123456, '17/09/1988', '18/05/2015', 'Rivadavia', 9012, 25);
insert into empleados (id_rol, nombre, apellido, id_tipo_doc, nro_doc, fec_nac, fec_ingreso, direccion, nro_calle, id_barrio)
		values (4, 'Patricia', 'Mendoza', 4, 11234567, '28/11/1994', '27/03/2019', 'Saavedra', 1123, 30);


-- SEDES
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede San Martín', 11, 'San Martín', 123, 5);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Rivadavia', 12, 'Rivadavia', 456, 10);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Lavalle', 13, 'Lavalle', 789, 15);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Roca', 11, 'Roca', 101, 20);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Mitre', 12, 'Mitre', 202, 25);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Sarmiento', 13, 'Sarmiento', 303, 30);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Alsina', 11, 'Alsina', 404, 35);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Saavedra', 12, 'Saavedra', 505, 40);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Urquiza', 13, 'Urquiza', 606, 45);
insert into sedes (nombre, id_responsable, direccion, nro_calle, id_barrio)
		values ('Sede Bolivar', 13, 'Bolivar', 556, 15);

-- EMPLEADOS_SEDES
insert into empleados_sedes (id_sede, id_empleado)
        values (1, 4);
insert into empleados_sedes (id_sede, id_empleado)
        values (2, 5);
insert into empleados_sedes (id_sede, id_empleado)
        values (3, 6);
insert into empleados_sedes (id_sede, id_empleado)
        values (4, 7);
insert into empleados_sedes (id_sede, id_empleado)
        values (5, 8);
insert into empleados_sedes (id_sede, id_empleado)
        values (6, 9);
insert into empleados_sedes (id_sede, id_empleado)
        values (7, 10);
insert into empleados_sedes (id_sede, id_empleado)
        values (8, 14);
insert into empleados_sedes (id_sede, id_empleado)
        values (9, 15);
insert into empleados_sedes (id_sede, id_empleado)
        values (10, 16);
insert into empleados_sedes (id_sede, id_empleado)
        values (1, 17);
insert into empleados_sedes (id_sede, id_empleado)
        values (2, 18);
insert into empleados_sedes (id_sede, id_empleado)
        values (3, 19);
insert into empleados_sedes (id_sede, id_empleado)
        values (4, 20);
insert into empleados_sedes (id_sede, id_empleado)
        values (5, 1);
insert into empleados_sedes (id_sede, id_empleado)
        values (1, 1);
insert into empleados_sedes (id_sede, id_empleado)
        values (2, 2);
insert into empleados_sedes (id_sede, id_empleado)
        values (3, 3);
insert into empleados_sedes (id_sede, id_empleado)
        values (4, 4);
insert into empleados_sedes (id_sede, id_empleado)
        values (5, 5);
insert into empleados_sedes (id_sede, id_empleado)
        values (6, 6);
insert into empleados_sedes (id_sede, id_empleado)
        values (7, 7);
insert into empleados_sedes (id_sede, id_empleado)
        values (8, 8);
insert into empleados_sedes (id_sede, id_empleado)
        values (9, 9);
insert into empleados_sedes (id_sede, id_empleado)
        values (10, 10);
insert into empleados_sedes (id_sede, id_empleado)
        values (1, 14);
insert into empleados_sedes (id_sede, id_empleado)
        values (2, 15);
insert into empleados_sedes (id_sede, id_empleado)
        values (3, 16);
insert into empleados_sedes (id_sede, id_empleado)
        values (4, 17);
insert into empleados_sedes (id_sede, id_empleado)
        values (5, 18);
insert into empleados_sedes (id_sede, id_empleado)
        values (6, 19);
insert into empleados_sedes (id_sede, id_empleado)
        values (7, 20);
insert into empleados_sedes (id_sede, id_empleado)
        values (1, 11);
insert into empleados_sedes (id_sede, id_empleado)
        values (2, 12);
insert into empleados_sedes (id_sede, id_empleado)
        values (3, 13);


-- TIPOS CONTACTOS
insert into tipos_contactos (descripcion) values ('Email')
insert into tipos_contactos (descripcion) values ('Telefono Fijo')
insert into tipos_contactos (descripcion) values ('Telefono Celular')
insert into tipos_contactos (descripcion) values ('Instagram')
insert into tipos_contactos (descripcion) values ('Facebook')
insert into tipos_contactos (descripcion) values ('WhatsApp')


-- FORMAS_PAGO
insert into formas_pago (descripcion,recargo,porc_recargo)
			values ('Tarjeta Debito', 1,   5.00)
insert into formas_pago (descripcion,recargo,porc_recargo)
			values ('Tarjeta Credito', 1,   10.00)
insert into formas_pago (descripcion,recargo)
			values ('Efectivo', 0)
insert into formas_pago (descripcion,recargo)
			values ('Transferencia', 0)
insert into formas_pago (descripcion,recargo)
			values ('Cheque', 0)

-- RECARGOS_MORA

insert into recargos_mora(dias_mora,porc_recargo)
			values       (1,2.00)
insert into recargos_mora(dias_mora,porc_recargo)
			values       (5,10.00)
insert into recargos_mora(dias_mora,porc_recargo)
			values       (10,15.00)
insert into recargos_mora(dias_mora,porc_recargo)
			values       (15,20.00)
insert into recargos_mora(dias_mora,porc_recargo)
			values       (20,30.00)
insert into recargos_mora(dias_mora,porc_recargo)
			values		 (30,50.00)
insert into recargos_mora(dias_mora,porc_recargo)
			values       (40,50.00)
insert into recargos_mora(dias_mora,porc_recargo)
			values       (60,70.00)

-- SERVICIOS
insert into servicios(desc_serv) values ('Luz')
insert into servicios(desc_serv) values ('Gas')
insert into servicios(desc_serv) values ('Agua')
insert into servicios(desc_serv) values ('Expensas')
insert into servicios(desc_serv) values ('Lavanderia')
insert into servicios(desc_serv) values ('Internet')

-- IMPUESTOS
insert into impuestos(desc_impuesto) values ('Impuesto a la vivienda municipal')
insert into impuestos(desc_impuesto) values ('Impuesto a la propiedad provincial')
insert into impuestos(desc_impuesto) values ('Impuesto a la vivienda ociosa')
insert into impuestos(desc_impuesto) values ('Impuesto al sello')
insert into impuestos(desc_impuesto) values ('Impuesto inmobiliario')

-- COBROS
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('12/05/2016', 1, 1, 6, 2);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('20/08/2018', 1, 4, 7, 5);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('15/07/2020', 2, 2, 8, 3);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('11/11/2021', 2, 2, 9, 1);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('05/02/2019', 3, 3, 10, 7);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('30/03/2017', 3, 16, 11, 4);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('14/09/2022', 4, 4, 12, 6);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('22/01/2020', 4, 4, 13, 2);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('18/10/2018', 5, 1, 14, 8);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('03/06/2016', 5, 1, 15, 3);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('09/04/2021', 10, 16, 16, 5);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('27/12/2019', 10, 16, 17, 4);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('01/08/2018', 1, 1, 18, 1);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('13/03/2017', 1, 4, 19, 7);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('25/11/2020', 3, 3, 20, 6);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('19/05/2015', 1, 1, 21, 3);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('23/11/2016', 1, 4, 22, 5);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('12/08/2017', 2, 2, 23, 2);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('14/07/2019', 2, 2, 24, 6);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('28/02/2018', 3, 3, 25, 8);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('05/04/2021', 3, 16, 26, 4);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('30/10/2020', 4, 4, 27, 1);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('11/09/2019', 4, 4, 28, 7);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('23/03/2018', 5, 1, 29, 5);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('17/06/2017', 5, 1, 30, 3);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('09/12/2022', 10, 16, 31, 6);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('05/05/2020', 10, 16, 32, 2);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('19/01/2017', 1, 1, 33, 4);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('27/08/2021', 1, 4, 34, 8);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('15/11/2019', 2, 2, 35, 7);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('12/06/2020', 2, 2, 36, 5);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('04/02/2024', 3, 3, 37, 1);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('22/09/2016', 3, 16, 38, 3);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('18/10/2015', 4, 4, 39, 2);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('31/12/2018', 4, 4, 40, 6);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('17/04/2023', 1, 1, 11, 4);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('20/06/2015', 1, 4, 2, 7);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('11/10/2018', 2, 2, 33, 6);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('24/08/2020', 2, 2, 24, 5);
insert into cobros (fec_pago, id_sede, legajo_cobrador, id_cliente, id_mora)
        values ('09/11/2019', 3, 3, 15, 3);

-- COBROS_FORMAS_PAGO
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (1, 1, 20);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (1, 2, 80);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (2, 1, 25);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (2, 2, 75);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (3, 1, 30);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (3, 2, 70);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (4, 1, 35);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (4, 2, 65);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (5, 1, 40);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (5, 2, 60);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (6, 1, 45);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (6, 2, 55);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (7, 1, 50);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (7, 2, 50);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (8, 1, 55);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (8, 2, 45);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (9, 1, 60);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (9, 2, 40);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (10, 1, 65);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (10, 2, 35);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (11, 1, 70);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (11, 2, 30);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (12, 1, 75);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (12, 2, 25);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (13, 1, 80);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (13, 2, 20);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (14, 1, 85);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (14, 2, 15);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (15, 1, 90);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (15, 2, 10);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (16, 1, 95);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (16, 2, 5);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (17, 1, 100);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (18, 1, 20);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (18, 2, 80);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (19, 1, 25);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (19, 2, 75);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (20, 1, 30);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (20, 2, 70);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (21, 1, 35);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (21, 2, 65);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (22, 1, 40);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (22, 2, 60);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (23, 1, 45);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (23, 2, 55);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (24, 1, 50);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (24, 2, 50);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (25, 1, 55);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (25, 2, 45);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (26, 1, 60);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (26, 2, 40);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (27, 1, 65);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (27, 2, 35);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (28, 1, 70);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (28, 2, 30);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (29, 1, 75);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (29, 2, 25);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (30, 1, 80);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (30, 2, 20);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (31, 1, 85);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (31, 2, 15);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (32, 1, 90);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (32, 2, 10);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (33, 1, 95);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (33, 2, 5);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (34, 1, 100);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (35, 1, 20);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (35, 2, 80);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (36, 1, 25);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (36, 2, 75);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (37, 1, 30);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (37, 2, 70);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (38, 1, 35);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (38, 2, 65);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (39, 1, 40);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (39, 2, 60);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (40, 1, 45);
INSERT INTO cobros_formas_pago (id_cobro, id_forma_pago, porcentaje_pagado)
    VALUES (40, 2, 55);

-- DETALLES_COBRO

INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (1, 1, 1, 1500, 1, 1000, 9000, 1, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (2, 21, 2, 1750, 2, 1050, 10000, 2, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (3, 31, 3, 2000, 3, 1100, 11000, 3, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (4, 41, 4, 2250, 4, 1150, 12000, 4, 4);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (5, 51, 5, 2500, 5, 1200, 13000, 5, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (6, 61, 6, 2750, 1, 1250, 14000, 6, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (7, 71, 1, 3000, 2, 1300, 15000, 7, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (8, 81, 2, 3250, 3, 1350, 16000, 8, 4);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (9, 91, 3, 3500, 4, 1400, 17000, 9, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (10, 101, 4, 3750, 5, 1450, 18000, 10, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (11, 111, 5, 4000, 1, 1500, 19000, 11, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (12, 121, 6, 4250, 2, 1550, 20000, 12, 4);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (13, 131, 1, 4500, 3, 1600, 21000, 1, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (14, 141, 2, 4750, 4, 1650, 22000, 2, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (15, 151, 3, 5000, 5, 1700, 23000, 3, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (16, 161, 4, 5250, 1, 1750, 24000, 4, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (17, 171, 5, 5500, 2, 1800, 25000, 5, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (18, 181, 6, 5750, 3, 1850, 26000, 6, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (19, 191, 1, 6000, 4, 1900, 27000, 7, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (20, 1, 2, 6250, 5, 1950, 28000, 8, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (21, 11, 3, 6500, 1, 2000, 29000, 9, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (22, 21, 4, 6750, 2, 2050, 30000, 10, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (23, 31, 5, 7000, 3, 2100, 31000, 11, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (24, 41, 6, 7250, 4, 2150, 32000, 12, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (25, 51, 1, 7500, 5, 2200, 33000, 1, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (26, 61, 2, 7750, 1, 2250, 34000, 2, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (27, 71, 3, 8000, 2, 2300, 35000, 3, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (28, 81, 4, 8250, 3, 2350, 36000, 4, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (29, 91, 5, 8500, 4, 2400, 37000, 5, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (30, 101, 6, 8750, 5, 2450, 38000, 6, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (31, 111, 1, 9000, 1, 2500, 39000, 7, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (32, 121, 2, 9250, 2, 2550, 40000, 8, 3);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (33, 131, 3, 9500, 3, 2600, 41000, 9, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (34, 141, 4, 9750, 4, 2650, 42000, 10, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (35, 151, 5, 10000, 5, 2700, 43000, 11, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (36, 161, 6, 10250, 1, 2750, 44000, 12, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (37, 11, 1, 10500, 2, 2800, 45000, 1, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (38, 31, 2, 10750, 3, 2850, 46000, 2, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (39, 191, 3, 11000, 4, 2900, 47000, 3, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (40, 21, 4, 11250, 5, 2950, 48000, 4, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (1, 31, 1, 1500, 1, 1000, 9000, 1, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (2, 71, 2, 1750, 2, 1050, 9500, 2, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (3, 11, 3, 2000, 3, 1100, 10000, 3, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (4, 41, 4, 2250, 4, 1150, 10500, 4, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (5, 151, 5, 2500, 5, 1200, 11000, 5, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (6, 161, 6, 2750, 1, 1250, 11500, 6, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (7, 171, 1, 3000, 2, 1300, 12000, 1, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (8, 181, 2, 3250, 3, 1350, 12500, 8, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (9, 191, 3, 3500, 4, 1400, 13000, 9, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (10, 101, 4, 3750, 5, 1450, 13500, 10, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (11, 111, 5, 4000, 1, 1500, 14000, 11, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (12, 121, 6, 4250, 2, 1550, 14500, 12, 1);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (13, 131, 1, 4500, 3, 1600, 15000, 1, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (14, 141, 2, 4750, 4, 1650, 15500, 2, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (15, 151, 3, 5000, 5, 1700, 16000, 3, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (16, 161, 4, 5250, 1, 1750, 16500, 4, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (17, 71, 5, 5500, 2, 1800, 17000, 5, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (18, 81, 6, 5750, 3, 1850, 17500, 6, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (19, 91, 1, 6000, 4, 1900, 18000, 7, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato) 
		VALUES (20, 11, 2, 6250, 5, 1950, 18500, 8, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (21, 21, 1, 1500, 1, 1000, 9000, 1, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (22, 41, 2, 1750, 2, 1050, 9500, 2, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (23, 31, 3, 2000, 3, 1100, 10000, 3, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (24, 61, 4, 2250, 4, 1150, 10500, 4, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (25, 51, 5, 2500, 5, 1200, 11000, 5, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (31, 61, 6, 2750, 1, 1250, 11500, 6, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (37, 71, 1, 3000, 2, 1300, 12000, 7, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (28, 81, 2, 3250, 3, 1350, 12500, 8, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (29, 91, 3, 3500, 4, 1400, 13000, 9, 2);
INSERT INTO detalles_cobro (id_cobro, id_contrato, id_serv, monto_serv, id_imp, monto_imp, monto_alquiler, mes_pagado, anio_contrato)
		VALUES (30, 181, 4, 3750, 5, 1450, 13500, 10, 2);

-- SERVICIOS_PROPIEDADES
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (1, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (1, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (1, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (1, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (11, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (11, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (11, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (11, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (21, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (21, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (21, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (31, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (31, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (31, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (41, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (41, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (41, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (41, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (51, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (51, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (51, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (61, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (61, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (61, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (61, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (71, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (71, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (71, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (81, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (81, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (81, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (91, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (91, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (91, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (101, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (101, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (101, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (111, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (111, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (111, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (121, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (121, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (121, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (131, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (131, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (131, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (131, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (141, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (141, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (141, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (151, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (151, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (151, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (161, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (161, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (161, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (171, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (171, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (171, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (181, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (181, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (181, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (181, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (191, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (191, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (191, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (201, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (201, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (201, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (211, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (211, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (211, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (211, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (221, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (221, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (221, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (231, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (231, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (231, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (241, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (241, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (241, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (251, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (251, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (251, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (261, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (261, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (261, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (261, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (271, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (271, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (271, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (281, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (281, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (281, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (291, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (291, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (291, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (301, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (301, 2);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (311, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (311, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (321, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (321, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (331, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (331, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (341, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (341, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (351, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (351, 1);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (361, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (361, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (371, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (371, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (381, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (381, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (391, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (391, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (401, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (401, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (411, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (411, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (421, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (421, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (431, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (431, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (441, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (441, 2);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (451, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (451, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (461, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (461, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (471, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (471, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (481, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (481, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (491, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (491, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (501, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (501, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (511, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (511, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (521, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (521, 2);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (531, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (531, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (541, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (541, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (551, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (551, 2);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (561, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (561, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (571, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (571, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (581, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (581, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (591, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (591, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (601, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (601, 6);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (611, 1);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (611, 2);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (621, 3);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (621, 4);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (631, 5);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (631, 1);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (641, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (641, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (651, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (651, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (661, 6);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (661, 1);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (671, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (671, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (681, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (681, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (691, 6);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (691, 1);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (701, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (701, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (711, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (711, 5);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (721, 6);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (721, 1);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (731, 2);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (731, 3);

INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (741, 4);
INSERT INTO servicios_propiedades (id_propiedad, id_servicio) VALUES (741, 5);

-- CONTACTOS PROPIETARIOS
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (1, 1, 'email1@gmail.com'); -- Email
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (1, 2, '01155556666'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (11, 1, 'email11@gmail.com'); -- Email
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (11, 3, '01155557777'); -- Celular

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (21, 2, '01166668888'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (21, 4, '@instagram21'); -- Instagram

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (31, 3, '01166669999'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (31, 5, 'facebook31'); -- Facebook

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (41, 4, '@instagram41'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (41, 6, '541155577777'); -- Whatsapp

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (51, 5, 'facebook51'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (51, 6, '541155588888'); -- Whatsapp

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (61, 2, '01177776666'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (61, 3, '01166661111'); -- Celular

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (71, 4, '@instagram71'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (71, 5, 'facebook71'); -- Facebook

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (81, 6, '541155599999'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (81, 1, 'email81@gmail.com'); -- Email

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (91, 3, '01166662222'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (91, 2, '01188887777'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (101, 5, 'facebook101'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (101, 4, '@instagram101'); -- Instagram

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (111, 6, '541155510101'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (111, 1, 'email111@gmail.com'); -- Email

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (121, 3, '01166663333'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (121, 4, '@instagram121'); -- Instagram

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (131, 2, '01199998888'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (131, 5, 'facebook131'); -- Facebook

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (141, 5, 'facebook141'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (141, 3, '01166664444'); -- Celular

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (151, 4, '@instagram151'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (151, 6, '541155511111'); -- Whatsapp

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (161, 6, '541155512121'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (161, 2, '01177775555'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (171, 3, '01166665555'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (171, 1, 'email171@gmail.com'); -- Email

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (181, 5, 'facebook181'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (181, 4, '@instagram181'); -- Instagram

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (191, 1, 'email191@gmail.com'); -- Email
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (191, 3, '01166666666'); -- Celular

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (201, 4, '@instagram201'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (201, 2, '01188889999'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (211, 2, '01177778888'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (211, 6, '541155513131'); -- Whatsapp

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (221, 3, '01166667777'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (221, 5, 'facebook221'); -- Facebook

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (231, 6, '541155514141'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (231, 1, 'email231@gmail.com'); -- Email

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (241, 5, 'facebook241'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (241, 2, '01199997777'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (251, 4, '@instagram251'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (251, 6, '541155515151'); -- Whatsapp

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (261, 6, '541155516161'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (261, 3, '01166668888'); -- Celular

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (271, 2, '01177773333'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (271, 5, 'facebook271'); -- Facebook

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (281, 6, '541155517171'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (281, 4, '@instagram281'); -- Instagram

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (291, 3, '01166669999'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (291, 2, '01177774444'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (301, 1, 'email301@gmail.com'); -- Email
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (301, 6, '541155518181'); -- Whatsapp


INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (311, 2, '01188882222'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (311, 5, 'facebook311'); -- Facebook

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (321, 4, '@instagram321'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (321, 3, '01166661111'); -- Celular

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (331, 5, 'facebook331'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (331, 1, 'email331@gmail.com'); -- Email

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (341, 1, 'email341@gmail.com'); -- Email
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (341, 6, '541155519191'); -- Whatsapp

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (351, 4, '@instagram351'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (351, 2, '01188883333'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (361, 6, '541155520202'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (361, 3, '01166662222'); -- Celular


INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (371, 2, '01177775555'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (371, 5, 'facebook371'); -- Facebook


INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (381, 3, '01166663333'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (381, 1, 'email381@gmail.com'); -- Email

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (391, 5, 'facebook391'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (391, 4, '@instagram391'); -- Instagram

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (401, 6, '541155521212'); -- Whatsapp
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (401, 2, '01199994444'); -- Teléfono fijo

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (411, 2, '01188884444'); -- Teléfono fijo
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (411, 6, '541155522222'); -- Whatsapp

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (421, 4, '@instagram421'); -- Instagram
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (421, 1, 'email421@gmail.com'); -- Email

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (431, 5, 'facebook431'); -- Facebook
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (431, 3, '01166664444'); -- Celular

INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (441, 3, '01166665555'); -- Celular
INSERT INTO contactos (id_propietario, id_tipo_contacto, contacto)
VALUES (441, 2, '01177776666'); -- Teléfono fijo

-- CONTACTOS INQUILINOS 
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (1, 1, 'email1@gmail.com'); -- Email
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (1, 6, '541155500001'); -- Whatsapp

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (11, 2, '01122221111'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (11, 5, 'facebook11'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (21, 3, '01122223333'); -- Celular
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (21, 4, '@instagram21'); -- Instagram

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (31, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (31, 2, '01122224444'); -- Teléfono fijo

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (41, 1, 'email41@gmail.com'); -- Email
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (41, 3, '01122225555'); -- Celular

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (51, 4, '@instagram51'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (51, 5, 'facebook51'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (61, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (61, 1, 'email61@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (71, 2, '01122226666'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (71, 3, '01122227777'); -- Celular

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (81, 5, 'facebook81'); -- Facebook
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (81, 6, '541155500001'); -- Whatsapp

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (91, 3, '01122228888'); -- Celular
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (91, 2, '01122229999'); -- Teléfono fijo

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (101, 1, 'email101@gmail.com'); -- Email
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (101, 4, '@instagram101'); -- Instagram

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (111, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (111, 5, 'facebook111'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (121, 3, '01122221111'); -- Celular
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (121, 2, '01122223333'); -- Teléfono fijo

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (131, 1, 'email131@gmail.com'); -- Email
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (131, 6, '541155500001'); -- Whatsapp

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (141, 2, '01122224444'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (141, 4, '@instagram141'); -- Instagram

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (151, 3, '01122225555'); -- Celular
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (151, 1, 'email151@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (161, 5, 'facebook161'); -- Facebook
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (161, 6, '541155500001'); -- Whatsapp

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (171, 3, '01122226666'); -- Celular
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (171, 2, '01122227777'); -- Teléfono fijo

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (181, 1, 'email181@gmail.com'); -- Email
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (181, 5, 'facebook181'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (191, 4, '@instagram191'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (191, 6, '541155500001'); -- Whatsapp

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (201, 3, '01122228888'); -- Celular
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (201, 2, '01122229999'); -- Teléfono fijo

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (211, 1, 'email211@gmail.com'); -- Email
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (211, 4, '@instagram211'); -- Instagram

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (221, 4, '@instagram221'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (221, 5, 'facebook221'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (231, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (231, 1, 'email231@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (241, 2, '01122228888'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (241, 3, '01122229999'); -- Celular

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (251, 4, '@instagram251'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (251, 5, 'facebook251'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (261, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (261, 1, 'email261@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (271, 2, '01122221111'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (271, 3, '01122222222'); -- Celular

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (281, 4, '@instagram281'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (281, 5, 'facebook281'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (291, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (291, 1, 'email291@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (301, 2, '01122223333'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (301, 3, '01122224444'); -- Celular

-- CONTACTOS GARANTES
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (221, 4, '@instagram221'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (221, 5, 'facebook221'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (231, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (231, 1, 'email231@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (241, 2, '01122228888'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (241, 3, '01122229999'); -- Celular

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (251, 4, '@instagram251'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (251, 5, 'facebook251'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (261, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (261, 1, 'email261@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (271, 2, '01122221111'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (271, 3, '01122222222'); -- Celular

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (281, 4, '@instagram281'); -- Instagram
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (281, 5, 'facebook281'); -- Facebook

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (291, 6, '541155500001'); -- Whatsapp
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (291, 1, 'email291@gmail.com'); -- Email

INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (301, 2, '01122223333'); -- Teléfono fijo
INSERT INTO contactos (id_inquilino, id_tipo_contacto, contacto)
VALUES (301, 3, '01122224444'); -- Celular


-- CONTACTOS GARANTES
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (1, 1, 'garante1@gmail.com'); -- Email
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (1, 2, '01111111111'); -- Teléfono fijo

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (2, 3, '01122222222'); -- Celular
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (2, 4, '@instagram2'); -- Instagram

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (3, 5, 'facebook3'); -- Facebook
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (3, 6, '541155500003'); -- Whatsapp

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (4, 1, 'garante4@gmail.com'); -- Email
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (4, 3, '01133333333'); -- Celular

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (5, 2, '01144444444'); -- Teléfono fijo
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (5, 4, '@instagram5'); -- Instagram

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (6, 5, 'facebook6'); -- Facebook
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (6, 6, '541155500006'); -- Whatsapp

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (7, 1, 'garante7@gmail.com'); -- Email
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (7, 2, '01177777777'); -- Teléfono fijo

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (8, 3, '01188888888'); -- Celular
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (8, 4, '@instagram8'); -- Instagram

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (9, 5, 'facebook9'); -- Facebook
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (9, 6, '541155500009'); -- Whatsapp

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (10, 1, 'garante10@gmail.com'); -- Email
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (10, 3, '01110101010'); -- Celular

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (11, 2, '01111111111'); -- Teléfono fijo
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (11, 4, '@instagram11'); -- Instagram

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (12, 5, 'facebook12'); -- Facebook
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (12, 6, '541155500012'); -- Whatsapp

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (13, 1, 'garante13@gmail.com'); -- Email
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (13, 2, '01113131313'); -- Teléfono fijo

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (14, 3, '01114141414'); -- Celular
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (14, 4, '@instagram14'); -- Instagram

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (15, 5, 'facebook15'); -- Facebook
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (15, 6, '541155500015'); -- Whatsapp

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (16, 1, 'garante16@gmail.com'); -- Email
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (16, 3, '01116161616'); -- Celular

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (17, 2, '01117171717'); -- Teléfono fijo
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (17, 4, '@instagram17'); -- Instagram

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (18, 5, 'facebook18'); -- Facebook
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (18, 6, '541155500018'); -- Whatsapp

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (19, 1, 'garante19@gmail.com'); -- Email
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (19, 2, '01119191919'); -- Teléfono fijo

INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (20, 3, '01120202020'); -- Celular
INSERT INTO contactos (id_garante, id_tipo_contacto, contacto)
VALUES (20, 4, '@instagram20'); -- Instagram

-- CONTACTOS EMPLEADOS
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (1, 1, 'empleado1@gmail.com'); -- Email
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (1, 2, '01111111111'); -- Teléfono fijo

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (2, 3, '01122222222'); -- Celular
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (2, 4, '@instagram2'); -- Instagram

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (3, 5, 'facebook3'); -- Facebook
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (3, 6, '541155500003'); -- Whatsapp

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (4, 1, 'empleado4@gmail.com'); -- Email
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (4, 3, '01133333333'); -- Celular

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (5, 2, '01144444444'); -- Teléfono fijo
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (5, 4, '@instagram5'); -- Instagram

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (6, 5, 'facebook6'); -- Facebook
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (6, 6, '541155500006'); -- Whatsapp

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (7, 1, 'empleado7@gmail.com'); -- Email
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (7, 2, '01177777777'); -- Teléfono fijo

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (8, 3, '01188888888'); -- Celular
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (8, 4, '@instagram8'); -- Instagram

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (9, 5, 'facebook9'); -- Facebook
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (9, 6, '541155500009'); -- Whatsapp

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (10, 1, 'empleado10@gmail.com'); -- Email
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (10, 3, '01110101010'); -- Celular

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (11, 2, '01111111111'); -- Teléfono fijo
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (11, 4, '@instagram11'); -- Instagram

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (12, 5, 'facebook12'); -- Facebook
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (12, 6, '541155500012'); -- Whatsapp

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (13, 1, 'empleado13@gmail.com'); -- Email
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (13, 2, '01113131313'); -- Teléfono fijo

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (14, 3, '01114141414'); -- Celular
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (14, 4, '@instagram14'); -- Instagram

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (15, 5, 'facebook15'); -- Facebook
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (15, 6, '541155500015'); -- Whatsapp

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (16, 1, 'empleado16@gmail.com'); -- Email
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (16, 3, '01116161616'); -- Celular

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (17, 2, '01117171717'); -- Teléfono fijo
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (17, 4, '@instagram17'); -- Instagram

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (18, 5, 'facebook18'); -- Facebook
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (18, 6, '541155500018'); -- Whatsapp

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (19, 1, 'empleado19@gmail.com'); -- Email
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (19, 2, '01119191919'); -- Teléfono fijo

INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (20, 3, '01120202020'); -- Celular
INSERT INTO contactos (id_empleado, id_tipo_contacto, contacto)
VALUES (20, 4, '@instagram20'); -- Instagram

-- CONTACTOS CLIENTES
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (1, 1, 'cliente1@gmail.com'); -- Email
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (1, 2, '01111111111'); -- Teléfono fijo

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (2, 3, '01122222222'); -- Celular
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (2, 4, '@instagram2'); -- Instagram

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (3, 5, 'facebook3'); -- Facebook
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (3, 6, '541155500003'); -- Whatsapp

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (4, 1, 'cliente4@gmail.com'); -- Email
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (4, 3, '01133333333'); -- Celular

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (5, 2, '01144444444'); -- Teléfono fijo
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (5, 4, '@instagram5'); -- Instagram

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (6, 5, 'facebook6'); -- Facebook
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (6, 6, '541155500006'); -- Whatsapp

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (7, 1, 'cliente7@gmail.com'); -- Email
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (7, 2, '01177777777'); -- Teléfono fijo

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (8, 3, '01188888888'); -- Celular
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (8, 4, '@instagram8'); -- Instagram

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (9, 5, 'facebook9'); -- Facebook
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (9, 6, '541155500009'); -- Whatsapp

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (10, 1, 'cliente10@gmail.com'); -- Email
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (10, 3, '01110101010'); -- Celular

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (11, 2, '01111111111'); -- Teléfono fijo
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (11, 4, '@instagram11'); -- Instagram

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (12, 5, 'facebook12'); -- Facebook
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (12, 6, '541155500012'); -- Whatsapp

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (13, 1, 'cliente13@gmail.com'); -- Email
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (13, 2, '01113131313'); -- Teléfono fijo

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (14, 3, '01114141414'); -- Celular
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (14, 4, '@instagram14'); -- Instagram

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (15, 5, 'facebook15'); -- Facebook
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (15, 6, '541155500015'); -- Whatsapp

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (16, 1, 'cliente16@gmail.com'); -- Email
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (16, 3, '01116161616'); -- Celular

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (17, 2, '01117171717'); -- Teléfono fijo
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (17, 4, '@instagram17'); -- Instagram

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (18, 5, 'facebook18'); -- Facebook
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (18, 6, '541155500018'); -- Whatsapp

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (19, 1, 'cliente19@gmail.com'); -- Email
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (19, 2, '01119191919'); -- Teléfono fijo

INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (20, 3, '01120202020'); -- Celular
INSERT INTO contactos (id_cliente, id_tipo_contacto, contacto)
VALUES (20, 4, '@instagram20'); -- Instagram

-- CONTACTOS SEDES
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (1, 1, 'sede_SanMartín@gmail.com'); -- Email
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (1, 2, '01111111111'); -- Teléfono fijo

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (2, 3, '01122222222'); -- Celular
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (2, 4, '@IMB_Sede Rivadavia'); -- Instagram

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (3, 5, 'IMB Sede Lavalle'); -- Facebook
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (3, 6, '541155500003'); -- Whatsapp

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (4, 1, 'sede_Roca@gmail.com'); -- Email
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (4, 3, '01133333333'); -- Celular

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (5, 2, '01144444444'); -- Teléfono fijo
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (5, 4, '@IMB_Sede_Mitre'); -- Instagram

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (6, 5, 'IMB_sede_Sarmiento'); -- Facebook
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (6, 6, '541155500006'); -- Whatsapp

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (7, 1, 'sede_Saavedra@gmail.com'); -- Email
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (7, 2, '01177777777'); -- Teléfono fijo

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (8, 3, '01188888888'); -- Celular
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (8, 4, '@IMB_SEDE_Urquiza'); -- Instagram

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (9, 5, 'Sede_IMB9'); -- Facebook
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (9, 6, '541155500009'); -- Whatsapp

INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (10, 1, 'Sede_Bolivar@gmail.com'); -- Email
INSERT INTO contactos (id_sede, id_tipo_contacto, contacto)
VALUES (10, 3, '01110101010'); -- Celular
