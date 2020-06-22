
Use SpotifyDB;

CREATE TABLE `User` (
  `IdUser` int PRIMARY KEY NOT NULL,
  `nombre_u` varchar(20) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `CorreoElectronico` varchar(50),
  `FechaNacimiento` date NOT NULL,
  `Ingreso` datetime,
  `Idlog` int
);

CREATE TABLE `Login` (
  `Idlog` int PRIMARY KEY NOT NULL,
  `login` timestamp,
  `logout` timestamp,
  `IdUser` int
  );

ALTER TABLE `Login` ADD FOREIGN KEY (`IdUser`) REFERENCES `User` (`IdUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;
CREATE INDEX `IdUser_idx` ON `Login` (`IdUser`);

create view vista as
select nombre_u, login, logout from User, Login where User.IdUser = Login.IdUser;

select * from vista;



CREATE TABLE `Cuenta` (
  `IdCuenta` int PRIMARY KEY,
  `active` boolean,
  `fecha_Create` timestamp,
  `IdUser` int,
  `Idlog` int
);

CREATE TABLE `TipoUser` (
  `IdTipo` int primary key,
  `Premium` tinyint(1),
  `Free` tinyint(1),
  `Familiar` tinyint(1),
  `IdUser` int,
  `active` timestamp
);

CREATE TABLE `Discography` (
  `IdDiscography` int primary key,
  `Nombre` varchar(255) NOT NULL,
  `IdAlbum` int
);

CREATE TABLE `Genero` (
  `IdGenero` int primary key,
  `TipoGenero` varchar(255) NOT NULL,
  `IdCancion` int,
  `IdAlbum` int
);

CREATE TABLE `Albumes` (
  `IdAlbum` int primary key,
  `Nombre` varchar(255) NOT NULL,
  `Anio` smallint NOT NULL,
  `IdDiscography` int,
  `IdCancion` int,
  `IdArtista` int
);

CREATE TABLE `Canciones` (
  `IdCancion` int primary key,
  `Nombre` varchar(255) NOT NULL,
  `Artista` varchar(255) NOT NULL,
  `Anio` smallint NOT NULL,
  `TipoGenero` varchar(255) NOT NULL,
  `Album` varchar(255) NOT NULL,
  `IdGenero` int,
  `IdAlbum` int,
  `IdPlaylist` int,
  `IdArtista` int,
  `IdDescargas` int
);

CREATE TABLE `Artistas` (
  `IdArtista` int primary key,
  `Nombre` varchar(255) NOT NULL,
  `Apellido` varchar(255) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  `NumeroDiscos` tinyint NOT NULL,
  `NumeroCanciones` tinyint NOT NULL,
  `Discography` varchar(255) NOT NULL,
  `IdAlbum` int,
  `IdCancion` int,
  `IdRoles` int
);

CREATE TABLE `Roles` (
  `IdRoles` int primary key ,
  `Name` varchar(255),
  `IdUser` int,
  `IdArtista` int
);

CREATE TABLE `Playlist` (
  `IdPlaylist` int primary key,
  `Nombre` varchar(255) NOT NULL,
  `IdUser` int,
  `IdCancion` int
);

CREATE TABLE `Descargas` (
  `IdDescargas` int primary key,
  `Nombre` varchar(255) NOT NULL,
  `IdCancion` int
);