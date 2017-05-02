INSERT INTO `accesos` (`codigo`, `reg_estado`, `descripcion`) VALUES ('vyf_cert_digital', 1, 'ventas y facturacion->facturacion electronica->carga certificado digital');
CREATE TABLE `param_fe` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`nombre` VARCHAR(30) NULL DEFAULT NULL,
	`valor` VARCHAR(100) NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

INSERT INTO `param_fe` (`nombre`) VALUES ('cert_password');

CREATE TABLE `caf` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`tipo_caf` INT(11) NULL DEFAULT '0',
	`fd` INT(11) NULL DEFAULT '0',
	`fh` INT(11) NULL DEFAULT '0',
	`archivo` VARCHAR(50) NULL DEFAULT NULL,
	`caf_content` TEXT NULL,
	`created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;


CREATE TABLE `folios_caf` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`folio` INT(11) NULL DEFAULT '0',
	`idcaf` INT(11) NOT NULL DEFAULT '0',
	`estado` ENUM('P','T','O') NOT NULL DEFAULT 'P' COMMENT 'P: pendiente (está libre para ocupar). T: Tomado (existe una factura en el momento que está generando con ese folio). O: Ocupado (Ya se usó el folio)',
	`created_at` DATETIME NOT NULL,
	`updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

INSERT INTO `param_fe` (`nombre`, `valor`) VALUES ('rut_empresa', '76369594-8');
INSERT INTO `tipo_documento` (`id`, `descripcion`, `correlativo`) VALUES (101, 'FACTURA ELECTRONICA', 0);

INSERT INTO `param_fe` (`nombre`) VALUES ('cert_password_encrypt');


CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rut` int(11) DEFAULT '0',
  `dv` char(1) DEFAULT '0',
  `razon_social` varchar(100) DEFAULT '',
  `giro` varchar(100) DEFAULT '',
  `cod_actividad` int(11) DEFAULT '0',
  `dir_origen` varchar(100) DEFAULT '',
  `comuna_origen` varchar(100) DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO `empresa` (`id`, `rut`, `dv`, `razon_social`, `giro`, `cod_actividad`, `dir_origen`, `comuna_origen`, `created_at`, `updated_at`) VALUES
	(1, 76369594, '8', 'SERVICIOS INTEGRALES INFOSYS SPA', 'Insumos de Computacion', 726000, '4 Poniente 0280', 'Talca', '2016-01-12 17:02:14', '2016-01-12 17:02:14');


ALTER TABLE `folios_caf`
	ADD COLUMN `dte` TEXT NOT NULL DEFAULT '' AFTER `estado`;
ALTER TABLE `folios_caf`
	ADD COLUMN `idfactura` INT NOT NULL AFTER `dte`;
ALTER TABLE `folios_caf`
	ADD COLUMN `archivo_dte` VARCHAR(50) NOT NULL AFTER `dte`;
ALTER TABLE `folios_caf`
	ADD COLUMN `path_dte` VARCHAR(50) NOT NULL AFTER `dte`;		

ALTER TABLE `folios_caf`
	ADD COLUMN `pdf` VARCHAR(50) NOT NULL AFTER `archivo_dte`;

/******************** FIN PRIMERA SUBIDA **************************/	

ALTER TABLE `empresa`
	ADD COLUMN `fec_resolucion` DATE NULL DEFAULT NULL AFTER `comuna_origen`;
ALTER TABLE `empresa`
	ADD COLUMN `nro_resolucion` INT NULL DEFAULT NULL AFTER `fec_resolucion`;
ALTER TABLE `empresa`
	ADD COLUMN `logo` VARCHAR(50) NULL DEFAULT NULL AFTER `nro_resolucion`;

ALTER TABLE `folios_caf`
	ADD COLUMN `pdf_cedible` VARCHAR(50) NOT NULL AFTER `pdf`;	
ALTER TABLE `folios_caf`
	ADD COLUMN `trackid` VARCHAR(30) NOT NULL AFTER `pdf_cedible`;		

CREATE TABLE `tipo_caf` (
	`id` INT(11) NOT NULL,
	`nombre` VARCHAR(100) NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;


INSERT INTO `tipo_caf` (`id`, `nombre`) VALUES (33, 'Factura Electrónica');
INSERT INTO `tipo_caf` (`id`, `nombre`) VALUES (34, 'Factura No Afecta Electrónica');
INSERT INTO `tipo_caf` (`id`, `nombre`) VALUES (56, 'Nota de Débito Electrónica');
INSERT INTO `tipo_caf` (`id`, `nombre`) VALUES (61, 'Nota de Crédito Electrónica');


/**************************************************/

CREATE TABLE `dte_proveedores` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`idproveedor` INT(11) NULL DEFAULT '0',
	`dte` TEXT NOT NULL,
	`path_dte` VARCHAR(50) NOT NULL,
	`archivo_dte` VARCHAR(50) NOT NULL,
	`envios_recibos` TEXT NOT NULL,
	`recepcion_dte` TEXT NOT NULL,
	`resultado_dte` TEXT NOT NULL,
	`arch_env_rec` VARCHAR(50) NOT NULL,
	`arch_rec_dte` VARCHAR(50) NOT NULL,
	`arch_res_dte` VARCHAR(50) NOT NULL,
	`created_at` DATETIME NOT NULL,
	`updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
ROW_FORMAT=COMPACT
AUTO_INCREMENT=1
;


/*******************************************************/
ALTER TABLE `dte_proveedores`
	ADD COLUMN `fecha_documento` DATE NOT NULL AFTER `arch_res_dte`;

/**********************************************************/

INSERT INTO `tipo_documento` (`id`, `descripcion`, `correlativo`) VALUES (102, 'NOTAS DE CREDITO ELECTRONICA', 1);

/******************************************************************/

INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (19, 'FACTURA EXENTA', 0);
ALTER TABLE `factura_clientes`
	ADD COLUMN `forma` INT(11) NOT NULL AFTER `estado`;
INSERT INTO `tipo_documento` (`id`, `descripcion`) VALUES (19, 'FACTURA EXENTA');	

CREATE TABLE `detalle_factura_glosa` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`glosa` VARCHAR(300) NOT NULL,
	`id_factura` INT(11) NOT NULL,
	`id_guia` INT(11) NOT NULL,
	`num_guia` TINYINT(10) NOT NULL,
	`neto` INT(10) NOT NULL,
	`iva` INT(10) NOT NULL,
	`total` INT(10) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
/***********************************************************************************/
INSERT INTO `tipo_documento` (`id`, `descripcion`) VALUES (103, 'FACTURA EXENTA ELECTRONICA');

/*************************************************************************************/

INSERT INTO `param_fe` (`nombre`, `valor`) VALUES ('envio_sii', 'manual');



/******************************************************************************************/
CREATE TABLE `contribuyentes_autorizados_1` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`rut` INT(11) NULL DEFAULT NULL,
	`dv` CHAR(1) NULL DEFAULT NULL,
	`razon_social` VARCHAR(250) NULL DEFAULT NULL,
	`nro_resolucion` INT(11) NULL DEFAULT NULL,
	`fec_resolucion` DATE NULL DEFAULT NULL,
	`mail` VARCHAR(100) NULL DEFAULT NULL,
	`url` VARCHAR(250) NULL DEFAULT NULL,
	`fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;



CREATE TABLE `contribuyentes_autorizados_2` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`rut` INT(11) NULL DEFAULT NULL,
	`dv` CHAR(1) NULL DEFAULT NULL,
	`razon_social` VARCHAR(250) NULL DEFAULT NULL,
	`nro_resolucion` INT(11) NULL DEFAULT NULL,
	`fec_resolucion` DATE NULL DEFAULT NULL,
	`mail` VARCHAR(100) NULL DEFAULT NULL,
	`url` VARCHAR(250) NULL DEFAULT NULL,
	`fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
ROW_FORMAT=COMPACT
;


CREATE TABLE `log_cargas_bases_contribuyentes` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`nombre_archivo` VARCHAR(100) NULL DEFAULT NULL,
	`ruta` VARCHAR(50) NULL DEFAULT NULL,
	`fecha_carga` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;


INSERT INTO `param_fe` (`nombre`, `valor`) VALUES ('tabla_contribuyentes', 'contribuyentes_autorizados_2');

CREATE TABLE `contribuyentes_autorizados` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`rut` VARCHAR(20) NOT NULL DEFAULT '0',
	`razon_social` VARCHAR(500) NULL DEFAULT NULL,
	`nro_resolucion` VARCHAR(50) NULL DEFAULT NULL,
	`fec_resolucion` VARCHAR(50) NULL DEFAULT NULL,
	`mail` VARCHAR(100) NULL DEFAULT NULL,
	`url` VARCHAR(250) NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
ROW_FORMAT=COMPACT
;



post_max_size 30


/********************************************************/

CREATE TABLE `log_libros` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`mes` INT(11) NULL DEFAULT NULL,
	`anno` INT(11) NULL DEFAULT NULL,
	`tipo_libro` ENUM('COMPRA','VENTA') NULL DEFAULT NULL,
	`archivo` VARCHAR(50) NULL DEFAULT NULL,
	`created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;


/**************************************************************/
CREATE TABLE `email_fe` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`email_contacto` VARCHAR(50) NOT NULL DEFAULT '0',
	`pass_contacto` VARCHAR(50) NOT NULL DEFAULT '0',
	`tserver_contacto` ENUM('smtp','imap') NOT NULL,
	`port_contacto` INT(11) NOT NULL DEFAULT '0',
	`host_contacto` VARCHAR(250) NOT NULL DEFAULT '0',
	`email_intercambio` VARCHAR(50) NOT NULL DEFAULT '0',
	`pass_intercambio` VARCHAR(50) NOT NULL DEFAULT '0',
	`tserver_intercambio` ENUM('smtp','imap') NOT NULL,
	`port_intercambio` INT(11) NOT NULL DEFAULT '0',
	`host_intercambio` VARCHAR(250) NOT NULL DEFAULT '0',
	`created_at` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
 /******************************************************************/
 INSERT INTO `tipo_documento` (`id`, `descripcion`, `correlativo`) VALUES (104, 'NOTA DE DEBITO ELECTRONICA', 0);
 INSERT INTO `tipo_documento` (`id`, `descripcion`, `correlativo`) VALUES (16, 'NOTAS DE DEBITO', 0);

 INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (101, 'FACTURA ELECTRONICA', 0);
 INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (103, 'FACTURA EXENTA ELECTRONICA', 0);
 INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (105, 'GUIA DE DESPACHO ELECTRONICA', 0);

 /**********************************************************************/

 ALTER TABLE `cod_activ_econ`
	CHANGE COLUMN `nombre` `nombre` VARCHAR(100) NOT NULL AFTER `codigo`;
UPDATE `cod_activ_econ` SET `nombre`='VENTAS AL POR MENOR DE OTROS PRODUCTOS EN ALMACENES ESPECIALIZADOS N.C.P.' WHERE  `id`=430;


/*************************************************************************************/

CREATE TABLE `guarda_csv` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`tipocaf` INT(11) NOT NULL DEFAULT '0',
	`folio` INT(11) NOT NULL DEFAULT '0',
	`fechafactura` DATE NOT NULL DEFAULT '0000-00-00',
	`condicion` VARCHAR(50) NOT NULL DEFAULT '0',
	`rut` INT(10) NOT NULL DEFAULT '0',
	`dv` CHAR(1) NOT NULL DEFAULT '0',
	`razonsocial` VARCHAR(150) NOT NULL DEFAULT '0',
	`giro` VARCHAR(150) NOT NULL DEFAULT '0',
	`direccion` VARCHAR(150) NOT NULL DEFAULT '0',
	`comuna` VARCHAR(100) NOT NULL DEFAULT '0',
	`ciudad` VARCHAR(100) NOT NULL DEFAULT '0',
	`cuenta` VARCHAR(100) NOT NULL DEFAULT '0',
	`neto` INT(11) NOT NULL DEFAULT '0',
	`iva` INT(11) NOT NULL DEFAULT '0',
	`total` INT(11) NOT NULL DEFAULT '0',
	`codigo` VARCHAR(50) NOT NULL DEFAULT '0',
	`cantidad` INT(11) NOT NULL DEFAULT '0',
	`unidad` VARCHAR(50) NOT NULL DEFAULT '0',
	`nombre` VARCHAR(150) NOT NULL DEFAULT '0',
	`preciounit` INT(11) NOT NULL DEFAULT '0',
	`totaldetalle` INT(11) NOT NULL DEFAULT '0',
	`codigoproceso` VARCHAR(30) NOT NULL DEFAULT '',
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

/*****************************************************************************************************/

ALTER TABLE `folios_caf`
	ADD COLUMN `dte_cliente` TEXT NOT NULL AFTER `dte`;
ALTER TABLE `folios_caf`
	ADD COLUMN `archivo_dte_cliente` VARCHAR(50) NOT NULL AFTER `archivo_dte`;	


/******************************************************************************************************/


ALTER TABLE `log_libros`
	ADD COLUMN `estado` ENUM('P','G') NULL DEFAULT 'P' COMMENT 'P: Pendiente, G: Generado' AFTER `tipo_libro`;	
ALTER TABLE `log_libros`
	ADD COLUMN `fecha_solicita` DATETIME NOT NULL AFTER `archivo`,
	ADD COLUMN `fecha_procesa` DATETIME NULL DEFAULT NULL AFTER `fecha_solicita`;	


/******************************************************************************************************/


ALTER TABLE `log_libros`
	ADD COLUMN `trackid` VARCHAR(30) NULL AFTER `estado`;
ALTER TABLE `log_libros`
	ADD COLUMN `xml_libro` TEXT NULL DEFAULT NULL AFTER `trackid`;	
	

/***************************************************************************************************/

ALTER TABLE `mae_medida`
	ADD COLUMN `cantidad` DECIMAL(10,3) NOT NULL AFTER `nombre`;

CREATE TABLE `listaprecios` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`id_producto` INT(11) NOT NULL,
	`nombre` VARCHAR(30) NOT NULL,
	`valor` INT(10) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

ALTER TABLE `orden_compra`
	ADD COLUMN `id_vendedor` INT(11) NOT NULL AFTER `fecha`;


CREATE TABLE `ordencompra_original` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`recepcionada` VARCHAR(2) NOT NULL,
	`num_orden` INT(10) NOT NULL,
	`id_proveedor` INT(11) NOT NULL,
	`id_bodega` INT(11) NOT NULL,
	`nombre_contacto` VARCHAR(40) NOT NULL,
	`telefono_contacto` VARCHAR(15) NOT NULL,
	`mail_contacto` VARCHAR(30) NOT NULL,
	`emitida` VARCHAR(2) NOT NULL,
	`descuento` INT(11) NOT NULL,
	`neto` INT(11) NOT NULL,
	`afecto` INT(11) NOT NULL,
	`iva` INT(11) NOT NULL,
	`total` INT(11) NOT NULL,
	`fecha` DATE NOT NULL,
	`fecha_recepcion` DATE NOT NULL,
	`id_vendedor` INT(11) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `recepcion_compra` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`num_recepcion` INT(11) NOT NULL,
	`id_orden` INT(11) NOT NULL,
	`id_proveedor` INT(11) NOT NULL,
	`num_doc` INT(11) NOT NULL,
	`tip_documento` INT(11) NOT NULL,
	`id_bodega` INT(11) NOT NULL,
	`forzada` VARCHAR(2) NOT NULL,
	`descuento` DECIMAL(10,3) NOT NULL,
	`neto` DECIMAL(10,3) NOT NULL,
	`afecto` DECIMAL(10,3) NOT NULL,
	`iva` DECIMAL(10,3) NOT NULL,
	`total` DECIMAL(10,3) NOT NULL,
	`fecha_recepcion` DATE NOT NULL,
	`fecha` DATE NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;


/***********************************************************************************/

INSERT INTO `tipo_documento` (`id`, `descripcion`, `correlativo`) VALUES ('106', 'BOLETA ELECTRONICA', '0');
INSERT INTO `tipo_caf` (`id`, `nombre`) VALUES ('39', 'Boleta Electrónica');
ALTER TABLE `empresa`
	ADD COLUMN `url` VARCHAR(50) NULL DEFAULT NULL AFTER `nro_resolucion`;
UPDATE `empresa` SET `url`='angus.agricultorestalca.cl' WHERE  `id`=1;	
ALTER TABLE `folios_caf`
	ADD COLUMN `consumo_folios` TEXT NOT NULL AFTER `dte_cliente`;
ALTER TABLE `folios_caf`
	ADD COLUMN `archivo_consumo_folios` VARCHAR(50) NOT NULL AFTER `archivo_dte_cliente`;	

ALTER TABLE `preventa`
	ADD COLUMN `id_pago` INT(11) NOT NULL AFTER `id_tip_docu`;	
ALTER TABLE `existencia`
	ADD COLUMN `id_bodega` INT(11) NOT NULL AFTER `stock`;	

/****************************************************************************************/

ALTER TABLE `preventa`
	ADD COLUMN `id_observa` INT(11) NOT NULL AFTER `observaciones`;

CREATE TABLE `observacion_preventa` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`id_documento` INT(11) NOT NULL,
	`rut` VARCHAR(9) NOT NULL,
	`nombre` VARCHAR(30) NOT NULL,
	`pat_camion` VARCHAR(10) NOT NULL,
	`pat_carro` VARCHAR(10) NOT NULL,
	`fono` VARCHAR(10) NOT NULL,
	`observacion` TEXT NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;


CREATE TABLE `recaudacion_general` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`id_recaudacion` INT(11) NOT NULL,
	`id_forma` INT(11) NOT NULL,
	`contado` INT(10) NOT NULL,
	`chequealdia` INT(10) NOT NULL,
	`chequeafecha` INT(10) NOT NULL,
	`credito` INT(10) NOT NULL,
	`tarjetadebito` INT(10) NOT NULL,
	`tarjetacredito` INT(10) NOT NULL,
	`transferencia` INT(10) NOT NULL,
	`credito30dias` INT(10) NOT NULL,
	`credito60dias` INT(10) NOT NULL,
	`num_documento` INT(10) NOT NULL,
	`id_caja` INT(11) NOT NULL,
	`id_cajero` INT(11) NOT NULL,
	`fecha` DATE NOT NULL,
	`estado` VARCHAR(3) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
 

 INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (20, 'TARJETAS DE CREDITO', 3751);
INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (22, 'RECEPCIONES', 211);
INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (24, 'DEVOLUCIONES', 0);
INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (101, 'FACTURA ELECTRONICA', 6752);
INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (102, 'NOTA DE CREDITO ELECTRONICA', 165);
INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (103, 'FACTURA EXENTA ELECTRONICA', 0);
INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (105, 'GUIA DE DESPACHO ELECTRONICA', 84);
INSERT INTO `correlativos` (`id`, `nombre`, `correlativo`) VALUES (106, 'BOLETA ELECTRONICA', 0);


/***********************************************************************************************************/

ALTER TABLE `folios_caf`
	DROP COLUMN `consumo_folios`,
	DROP COLUMN `archivo_consumo_folios`;
ALTER TABLE `folios_caf`
	ADD COLUMN `idconsumofolios` INT NOT NULL AFTER `pdf_cedible`;
ALTER TABLE `folios_caf`
	CHANGE COLUMN `idconsumofolios` `idconsumofolios` INT(11) NOT NULL DEFAULT '0' AFTER `pdf_cedible`;

CREATE TABLE `consumo_folios` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`fecha` DATE NOT NULL,
	`path` VARCHAR(50) NOT NULL,
	`archivo` VARCHAR(50) NOT NULL,
	`xml` TEXT NOT NULL,
	`trackid` VARCHAR(30) NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=MyISAM
;
			

/*****************************************************************************************************************/

CREATE TABLE `datos_factura_ws` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`tipocaf` INT(11) NOT NULL DEFAULT '0',
	`folio` INT(11) NOT NULL DEFAULT '0',
	`referencia` INT(11) NOT NULL DEFAULT '0',
	`fechafactura` DATE NOT NULL DEFAULT '0000-00-00',
	`condicion` VARCHAR(50) NOT NULL DEFAULT '0',
	`vendedor` VARCHAR(250) NOT NULL DEFAULT '0',
	`rut` INT(10) NOT NULL DEFAULT '0',
	`dv` CHAR(1) NOT NULL DEFAULT '0',
	`razonsocial` VARCHAR(150) NOT NULL DEFAULT '0',
	`giro` VARCHAR(150) NOT NULL DEFAULT '0',
	`direccion` VARCHAR(150) NOT NULL DEFAULT '0',
	`comuna` VARCHAR(100) NOT NULL DEFAULT '0',
	`ciudad` VARCHAR(100) NOT NULL DEFAULT '0',
	`cuenta` VARCHAR(100) NOT NULL DEFAULT '0',
	`neto` INT(11) NOT NULL DEFAULT '0',
	`iva` INT(11) NOT NULL DEFAULT '0',
	`total` INT(11) NOT NULL DEFAULT '0',
	`codigo` VARCHAR(50) NOT NULL DEFAULT '0',
	`cantidad` DOUBLE NOT NULL DEFAULT '0',
	`unidad` VARCHAR(50) NOT NULL DEFAULT '0',
	`nombre` VARCHAR(150) NOT NULL DEFAULT '0',
	`preciounit` INT(11) NOT NULL DEFAULT '0',
	`totaldetalle` INT(11) NOT NULL DEFAULT '0',
	`oreferencia` VARCHAR(250) NOT NULL,
	`codigoproceso` VARCHAR(30) NOT NULL DEFAULT '',
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
ROW_FORMAT=COMPACT
AUTO_INCREMENT=28
;


INSERT INTO `datos_factura_ws` (`id`, `tipocaf`, `folio`, `referencia`, `fechafactura`, `condicion`, `vendedor`, `rut`, `dv`, `razonsocial`, `giro`, `direccion`, `comuna`, `ciudad`, `cuenta`, `neto`, `iva`, `total`, `codigo`, `cantidad`, `unidad`, `nombre`, `preciounit`, `totaldetalle`, `oreferencia`, `codigoproceso`, `created_at`) VALUES (1, 61, 3, 0, '2016-12-29', '', '', 91537000, '4', 'BAYER S.A.', 'INDUSTRIA QUIMICA', 'AV.ANDRES BELLO N? 2457 PISO 21 OF 2101', 'PROVIDENCIA', 'SANTIAGO', '      ', 4860690, 923531, 5784221, '           ', 1, 'UNI', 'COMISION POR COMPRAS 2016                                   ', 4860690, 4860690, '', 'Na8EJBYRPa', '2017-01-12 16:17:27');
INSERT INTO `datos_factura_ws` (`id`, `tipocaf`, `folio`, `referencia`, `fechafactura`, `condicion`, `vendedor`, `rut`, `dv`, `razonsocial`, `giro`, `direccion`, `comuna`, `ciudad`, `cuenta`, `neto`, `iva`, `total`, `codigo`, `cantidad`, `unidad`, `nombre`, `preciounit`, `totaldetalle`, `oreferencia`, `codigoproceso`, `created_at`) VALUES (26, 33, 1140, 0, '2017-02-14', 'CONTADO', 'COBRANZA DE OFICINA', 9017126, '7', 'LOYOLA VALDES MANUEL ANTONIO', 'AGRICOLA', 'PARC. 317 HIJUELA 2 LOTE A LOS MONTES', 'SAN CLEMENTE', 'SAN CLEMENTE', '      ', 84960, 16142, 101103, '00FFA090', 4, 'SAC', 'NITRATO POTASIO SOLUB SQM', 15210, 60840, '', 'O3vJOlnwhA', '2017-02-15 10:12:20');
INSERT INTO `datos_factura_ws` (`id`, `tipocaf`, `folio`, `referencia`, `fechafactura`, `condicion`, `vendedor`, `rut`, `dv`, `razonsocial`, `giro`, `direccion`, `comuna`, `ciudad`, `cuenta`, `neto`, `iva`, `total`, `codigo`, `cantidad`, `unidad`, `nombre`, `preciounit`, `totaldetalle`, `oreferencia`, `codigoproceso`, `created_at`) VALUES (27, 33, 1140, 0, '2017-02-14', 'CONTADO', 'COBRANZA DE OFICINA', 9017126, '7', 'LOYOLA VALDES MANUEL ANTONIO', 'AGRICOLA', 'PARC. 317 HIJUELA 2 LOTE A LOS MONTES', 'SAN CLEMENTE', 'SAN CLEMENTE', '      ', 84960, 16142, 101103, '00PF0124', 1, 'LTS', 'BIOZYME TF (1 LT)', 24120, 24120, '', 'O3vJOlnwhA', '2017-02-15 10:12:20');


ALTER TABLE `factura_clientes`
	ADD COLUMN `cond_venta` VARCHAR(50) NOT NULL AFTER `id_cond_venta`;

ALTER TABLE `factura_clientes`
	ADD COLUMN `vendedor` VARCHAR(250) NOT NULL AFTER `cond_venta`;

ALTER TABLE `factura_clientes`
	ADD COLUMN `oreferencia` VARCHAR(250) NOT NULL AFTER `forma`;