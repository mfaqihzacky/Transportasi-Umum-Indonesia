CREATE DATABASE [TRANSPORTASI UMUM]

DROP TABLE IF EXISTS [P_ONLINE];
DROP TABLE IF EXISTS [P_OFFLINE];
DROP TABLE IF EXISTS [PEMBAYARAN];
DROP TABLE IF EXISTS [PENUMPANG];
DROP TABLE IF EXISTS [MELAKUKAN];
DROP TABLE IF EXISTS [MENGEMUDIKAN];
DROP TABLE IF EXISTS [PENGEMUDI];
DROP TABLE IF EXISTS [PERJALANAN];
DROP TABLE IF EXISTS [K_LAUT];
DROP TABLE IF EXISTS [K_UDARA];
DROP TABLE IF EXISTS [K_DARAT];
DROP TABLE IF EXISTS [KENDARAAN];
DROP TABLE IF EXISTS [K_LAUT];
DROP TABLE IF EXISTS [MENGEMUDIKAN];
DROP TABLE IF EXISTS [PERJALANAN];
DROP TABLE IF EXISTS [LOKASI];
DROP TABLE IF EXISTS [RUTE];
DROP TABLE IF EXISTS [MEMILIKI_CABANG];
DROP TABLE IF EXISTS [MENENTUKAN];
DROP TABLE IF EXISTS [PERUSAHAAN];

CREATE TABLE [PERUSAHAAN](
 [KdPerusahaan] NVARCHAR (50) ,
 [NamaPerusahaan] NVARCHAR(100),
 [AlamatKantorPusat] NVARCHAR(200),
 [Email] NVARCHAR(50),
 [Telp] NVARCHAR(50),
 [ThBerdiri] INT,

 CONSTRAINT [PK_KdPerusahaan] PRIMARY KEY ([KdPerusahaan]),
 );

CREATE TABLE [LOKASI](
 [KdLokasi] NVARCHAR (50),
 [Jenis] NVARCHAR(20),
 [NamaLokasi] NVARCHAR(50),
 [Kota] NVARCHAR(50),
 [Negara] NVARCHAR(50),
 [NamaJalan] NVARCHAR(50),

 CONSTRAINT [PK_KdLokasi] PRIMARY KEY ([KdLokasi])
);


CREATE TABLE [RUTE](
 [KdRute] NVARCHAR (50) ,
 
 CONSTRAINT [PK_KdRute] PRIMARY KEY ([KdRute])
);

CREATE TABLE [MENENTUKAN](
 [Per_KdPerusahaan] NVARCHAR (50),
 [R_KdRute] NVARCHAR (50),

 CONSTRAINT [PK_Menentukan] PRIMARY KEY ([Per_KdPerusahaan],[R_KdRute]),
 CONSTRAINT [FK_Menentukan_Perusahaan] FOREIGN KEY ([Per_KdPerusahaan]) REFERENCES [PERUSAHAAN] ([KdPerusahaan]),
 CONSTRAINT [FK_Menentukan_Rute] FOREIGN KEY ([R_KdRute]) REFERENCES [RUTE] ([KdRute])
);

CREATE TABLE [MEMILIKI_CABANG](
 [Per_KdPerusahaan] NVARCHAR (50),
 [L_KdLokasi] NVARCHAR (50),

 CONSTRAINT [PK_Memiliki_Cabang] PRIMARY KEY ([Per_KdPerusahaan],[L_KdLokasi]),
 CONSTRAINT [FK_Memiliki_Cabang_Perusahaan] FOREIGN KEY ([Per_KdPerusahaan]) REFERENCES [PERUSAHAAN] ([KdPerusahaan]),
 CONSTRAINT [FK_Memiliki_Cabang_Lokasi] FOREIGN KEY ([L_KdLokasi]) REFERENCES [LOKASI] ([KdLokasi])
);

CREATE TABLE [KENDARAAN](
 [KdKendaraan] NVARCHAR (50) ,
 [TahunPembuatan] INT,
 [JenisKendaraan] NVARCHAR(20),
 [NamaKendaraan] NVARCHAR(50),
 [Per_KdPerusahaan] NVARCHAR (50),

 CONSTRAINT [PK_Kendaraan] PRIMARY KEY ([KdKendaraan]),
 CONSTRAINT [FK_Kendaraan_Perusahaan] FOREIGN KEY ([Per_KdPerusahaan]) REFERENCES [PERUSAHAAN] ([KdPerusahaan]),
);

CREATE TABLE [K_DARAT](
 [K_KdKendaraan] NVARCHAR (50),
 [JenisJalur] NVARCHAR(30),

 CONSTRAINT [PK_K_DARAT] PRIMARY KEY ([K_KdKendaraan]),
 CONSTRAINT [FK_K_DARAT] FOREIGN KEY ([K_KdKendaraan]) REFERENCES [KENDARAAN] ([KdKendaraan])
);

CREATE TABLE [K_UDARA](
 [K_KdKendaraan] NVARCHAR (50),
 [KetinggianMaksimum] NVARCHAR(30),

 CONSTRAINT [PK_K_UDARA] PRIMARY KEY ([K_KdKendaraan]),
 CONSTRAINT [FK_K_UDARA] FOREIGN KEY ([K_KdKendaraan]) REFERENCES [KENDARAAN] ([KdKendaraan])
);

CREATE TABLE [K_LAUT](
 [K_KdKendaraan] NVARCHAR (50),
 [BanyakLambung] INT,

 CONSTRAINT [PK_K_LAUT] PRIMARY KEY ([K_KdKendaraan]),
 CONSTRAINT [FK_K_LAUT] FOREIGN KEY ([K_KdKendaraan]) REFERENCES [KENDARAAN] ([KdKendaraan])
);


CREATE TABLE [PERJALANAN](
 [KdPerjalanan] NVARCHAR (50) ,
 [R_KdRute] NVARCHAR (50),
 [L_KdLokasiBerangkatDari] NVARCHAR (50),
 [L_KdLokasiSampaiDi] NVARCHAR (50),

 CONSTRAINT [PK_Perjalanan] PRIMARY KEY ([KdPerjalanan]),
 CONSTRAINT [FK_Perjalanan_LokasiBerangkatDari] FOREIGN KEY ([L_KdLokasiBerangkatDari]) REFERENCES [LOKASI] ([KdLokasi]),
 CONSTRAINT [FK_Perjalanan_LokasiSampaiDi] FOREIGN KEY ([L_KdLokasiSampaiDi]) REFERENCES [LOKASI] ([KdLokasi]),
 CONSTRAINT [FK_Perjalanan_Rute] FOREIGN KEY ([R_KdRute]) REFERENCES [RUTE] ([KdRute])
);


CREATE TABLE [PENGEMUDI](
 [ID_Pengemudi] NVARCHAR (50) ,
 [NamaPengemudi] NVARCHAR(50),
 [Lisensi] NVARCHAR(20),
 [Per_KdPerusahaan] NVARCHAR (50),

 CONSTRAINT [PK_Pengemudi] PRIMARY KEY ([ID_Pengemudi]),
 CONSTRAINT [FK_Pengemudi_Perusahaan] FOREIGN KEY ([Per_KdPerusahaan]) REFERENCES [PERUSAHAAN] ([KdPerusahaan]),
);

CREATE TABLE [MENGEMUDIKAN](
[K_KdKendaraan] NVARCHAR (50),
[Peng_ID_Pengemudi] NVARCHAR (50),

CONSTRAINT [PK_Mengemudikan] PRIMARY KEY ([K_KdKendaraan],[Peng_ID_Pengemudi]),
CONSTRAINT [FK_Mengemudikan_Kendaraan] FOREIGN KEY ([K_KdKendaraan]) REFERENCES [KENDARAAN] ([KdKendaraan]),
CONSTRAINT [FK_Mengemudikan_Pengemudi] FOREIGN KEY ([Peng_ID_Pengemudi]) REFERENCES [PENGEMUDI] ([ID_Pengemudi])

);

CREATE TABLE [MELAKUKAN](
[K_KdKendaraan] NVARCHAR (50),
[Pjl_KdPerjalanan] NVARCHAR (50),

CONSTRAINT [PK_Melakukan] PRIMARY KEY ([K_KdKendaraan],[Pjl_KdPerjalanan]),
CONSTRAINT [FK_Melakukan_Kendaraan] FOREIGN KEY ([K_KdKendaraan]) REFERENCES [KENDARAAN] ([KdKendaraan]),
CONSTRAINT [FK_Melakukan_Perjalanan] FOREIGN KEY ([Pjl_KdPerjalanan]) REFERENCES [PERJALANAN] ([KdPerjalanan])
);

CREATE TABLE [PENUMPANG](
 [NIK] NVARCHAR (50) ,
 [NamaPenumpang] NVARCHAR(50),
 [Umur] INT,
 [K_KdKendaraan] NVARCHAR (50),

 CONSTRAINT [PK_Penumpang] PRIMARY KEY ([NIK]),
 CONSTRAINT [FK_Penumpang_Kendaraan] FOREIGN KEY ([K_KdKendaraan]) REFERENCES [KENDARAAN] ([KdKendaraan])
);

CREATE TABLE [PEMBAYARAN](
 [KdPembayaran] NVARCHAR (50) ,
 [Tarif] INT,
 [TanggalPembayaran] NVARCHAR (50),
 [Pen_NIK] NVARCHAR (50),
 [K_KdKendaraan] NVARCHAR (50),
 
 CONSTRAINT [PK_Pembayaran] PRIMARY KEY ([KdPembayaran]),
 CONSTRAINT [FK_Pembayaran_Kendaraan] FOREIGN KEY ([K_KdKendaraan]) REFERENCES [KENDARAAN] ([KdKendaraan]),
 CONSTRAINT [FK_Pembayaran_Penumpang] FOREIGN KEY ([Pen_NIK]) REFERENCES [PENUMPANG] ([NIK]),
);
	
CREATE TABLE [P_OFFLINE](
[Pem_KdPembayaran] NVARCHAR (50),
[JenisPembayaran] NVARCHAR (50),
[L_KdLokasi] NVARCHAR (50),

CONSTRAINT [PK_P_Offline] PRIMARY KEY ([Pem_KdPembayaran]),
CONSTRAINT [FK_P_Offline_Lokasi] FOREIGN KEY ([L_KdLokasi]) REFERENCES [LOKASI] ([KdLokasi])
);

CREATE TABLE [P_ONLINE](
[Pem_KdPembayaran] NVARCHAR (50),
[NamaAplikasi] NVARCHAR (50),

CONSTRAINT [PK_P_Online] PRIMARY KEY ([Pem_KdPembayaran])
);

USE [TRANSPORTASI UMUM]

--Perusahaan
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('GJ2315','GoJek','Pasaraya Blok M Gedung B, Jakarta Selatan','customerservice@go-jek.com',1900636252,2010);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('HY0989','PO.Haryanto','Jl. Lingkar Luar Ngembal, Kudus',' poharyanto@gmail.com','082137333345',2002);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('SJ0221','PO.Sinar Jaya','Jalan Diponegoro 75 - Tambun, Bekasi, Indonesia',' humas@sinarjayagroup.co.id','21883255502',1982);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('NY6823','NYK Lines','Plaza BII 2, Lantai 14, Jakarta Pusat','nyksm.s.joinus@nykgroup.com','80861234',1885);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('KL0119','K Line Indonesia','Ruko Inkopal Blok G No. 26, Kelapa Gading','jakarta@id.klinelogistics.com','02155911757',1996);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('SI6556','Synergy Indonesia','Jl. Duyung No. 01. Batu Ampar, Batam','info@synergyproindonesia.com','081931233571',2000);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('TB7724','PT. Trio Bintang Samudra','Taman Harapan Baru Blok: 1-3, Bekasi','bagir@bsus.co.id','0214269261',1997);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('RI5532','PT. Radiant Utama Interinsco Tbk','Jl Kapten Tendean No. 24, Jakarta','office@supraco.com','0217191070',1984);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('BB8796','BlueBird','Mampang. Jl. Mampang Prapatan Raya No.60, Jakarta.','customercare@bluebirdgroup.com','0217971245',1972);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('KA0978','PT.KAI','Jl. Perintis Kemerdekaan No. 1. Bandung',' cs@kai.id','021121',1945);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('GA1231','Garuda Indonesia','Jl. Kebon Sirih,Jakarta ','investor@garuda-indonesia.coml','08041807807',1949);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('LI2345','Lion Air','Jl. KH. Hasyim Ashari, Jakarta','customercare@lionair.co.id.','02163798000',1999);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('PA2315','Pelita Air','Jl. Abdul Muis,Jakarta', 'customercare@pelita-air.com', '0212312030',1970);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('SJ22115','Super Air Jett','jl. Gajah Mada, Jakarta','customercare@superairjet.com','081119380888',2021);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('TN2551','Trans Nusa','Terminal 3 Bandara International Soekarno Hatta', 'sales@transnusa.co.id.','0216318709' ,2005);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('PN6556','PT. Pelayaran Nasional Indonesia','Jl. Gajah Mada No.14, RT.6/RW.2, Petojo Utara, Kecamatan Gambir, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta','infopelni162@pelni.co.id',02121887000,1952);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('JF7724','PT. PT. Jelma Ferry','Jl. Wolter Monginsidi No 91, Kebayoran Baru, Jakarta Selatan','info@jemlaferry.com',02217266777,1976);
INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES ('AI6456','PT. ASDP Indonesia Ferry','Jl. Jend. Achmad Yani Kav. 52A Jakarta','cs@indonesiaferry.com',08111021191,1973);





--Lokasi Udara
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('DPS','BANDARA','I Gusti Ngurah Rai','Bali','INDONESIA','Jl.Badung Regency');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('CGK','BANDARA','Soekarno Hatta','Cengkareng','INDONESIA','Jl.Pajang');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('HLP','BANDARA','Halim Perdana Kusuma','Jakarta Selatan','INDONESIA','Jl.Halim Perdana Kusuma');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('YIA','BANDARA',' Yogyakarta International Airport','Kulon Progo','INDONESIA','Jl.Kulon Progo');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('JOG','BANDARA','Adi Soecipto','Yogyakarta','INDONESIA','Jl.Raya Solo');

--Lokasi Darat
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('TTN','Terminal','Tirtonadi','Surakarta','Indonesia','Jalan Ahmad Yani Nomor 262');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('TBO','Terminal','Terboyo','Semarang','Indonesia','Jalan Raya Semarang-Surabaya');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('PLG','Terminal','Pulogebang','Jakarta','Indonesia','Jalan Raya Bekasi');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('GWN','Terminal','Giwangan','Yogyakarta','Indonesia','Jalan Imogiri Timur');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('LBK','Terminal','Lebak Bulus','Jakarta','Indonesia','Jalan Lebak Bulus Raya');

INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('SLO','Stasiun','Solo Balapan','Surakarta','Indonesia','Jalan Wolter Monginsidi No. 112');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('GMR','Stasiun','Gambir','Jakarta','Indonesia','Jalan Medan Merdeka Timur No. 7');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('BD','Stasiun','Bandung','Bandung','Indonesia','Jalan Stasiun No. 1');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('TUG','Stasiun','Tugu','Yogyakarta','Indonesia','Jalan Mangkubumi No. 1');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('ML','Stasiun','Malang','Malang','Indonesia','Jalan Trunojoyo No. 41');

INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('-7.559803252025726, 110.83639576653093','Hotel','Hotel Asia','Surakarta','Indonesia','Jl. Monginsidi No.1');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('-7.548248275194625, 110.85874799536677','Cafe','Bento Kopi UNS','Surakarta','Indonesia','Jl. Agung Timur No.14');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('-7.551593845550375, 110.86069801846344','Restaurant','Nice Spice UNS','Surakarta','Indonesia','Jl. Kartika No.16');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('-7.5609646599458555, 110.85858570832038','Kebun Binatang','Solo Safari','Surakarta','Indonesia','Jl. Ir. Sutami No.109');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) 
VALUES ('-7.560428347228102, 110.84881078991822','Cafe','Cafe Almamater UNS','Surakarta','Indonesia','Jl. Ir. Sutami No.32');

--LOKASI LAUT
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDTPR','Pelabuhan','Tanjung Priok','Jakarta Utara','Indonesia','Jl. RE Martadinata');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDBTH','Pelabuhan','Batam Centre','Batam','Indonesia','Jl. Engku Putri');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDTPE','Pelabuhan','Tanjung Perak','Surabaya','Indonesia','Jl. Tanjung Perak');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDBPN','Pelabuhan','Semayang','Balikpapan','Indonesia','Jl. A Yani');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDMAK','Pelabuhan','Soekarno-Hatta','Makassar','Indonesia','Jl. Soekarno-Hatta');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDSRG','Pelabuhan','Tanjung Emas','Semarang','Indonesia','Jl. Tanjung Emas');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDMRK','Pelabuhan','Merak','Cilegon','Indonesia','Jl. Pelabuhan Merak');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDTKG','Pelabuhan','Bakauheni','Lampung Selatan','Indonesia','Jl. Raya Lintas Sumatra');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDBJU','Pelabuhan','Ketapang','Banyuwangi','Indonesia','Jl. Raya Banyuwangi Situbondo');
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('IDGIL','Pelabuhan','Gilimanuk','Denpasar','Indonesia','Jl. Raya Denpasar');



--Rute Udara
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-SJ12');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-SH33');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-SY99');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-SJ87');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-AJ95');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-AH09');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-AY90');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-AJ87');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-AJ90');
INSERT INTO [RUTE] ([KdRute]) VALUES ('P-AH19');

--Rute Darat
INSERT INTO [RUTE] ([KdRute]) VALUES ('M-SS65');
INSERT INTO [RUTE] ([KdRute]) VALUES ('M-SS87');
INSERT INTO [RUTE] ([KdRute]) VALUES ('M-SS52');
INSERT INTO [RUTE] ([KdRute]) VALUES ('M-SS77');
INSERT INTO [RUTE] ([KdRute]) VALUES ('M-SS94');

INSERT INTO [RUTE] ([KdRute]) VALUES ('KA-SY47');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KA-JB97');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KA-MS52');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KA-YM77');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KA-SS65');

INSERT INTO [RUTE] ([KdRute]) VALUES ('B-JS47');
INSERT INTO [RUTE] ([KdRute]) VALUES ('B-SY91');
INSERT INTO [RUTE] ([KdRute]) VALUES ('B-JY55');
INSERT INTO [RUTE] ([KdRute]) VALUES ('B-KS74');
INSERT INTO [RUTE] ([KdRute]) VALUES ('B-SA83');

--RUTE	LAUT
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-JB31');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-BJ32');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-SB58');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-BS57');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-MS98');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-SM99');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-CL45');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-LC44');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-BD16');
INSERT INTO [RUTE] ([KdRute]) VALUES ('KL-DB17');



--Menentukan Udara
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('GA1231','P-SJ12');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('GA1231','P-SH33');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('LI2345','P-SY99');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('LI2345','P-SJ87');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('PA2315','P-AJ95');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('PA2315','P-AH09');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('SJ22115','P-AY90');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('SJ22115','P-AJ87');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('TN2551','P-AJ90');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('TN2551','P-AH19');

--Menentukan Darat
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('GJ2315','M-SS65');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('GJ2315','M-SS52');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('BB8796','M-SS77');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('BB8796','M-SS94');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('BB8796','M-SS87');

INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('KA0978','KA-SY47');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('KA0978','KA-JB97');

INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('HY0989','B-JS47');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('HY0989','B-JY55');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('SJ0221','B-SA83');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('SJ0221','B-SY91');

--MENENTUKAN LAUT
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('NY6823','KL-JB31');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('NY6823','KL-BJ32');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('NY6823','KL-SB58');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('KL0119','KL-BS57');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('PN6556','KL-MS98');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('PN6556','KL-SM99');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('JF7724','KL-CL45');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('JF7724','KL-LC44');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('AI6456','KL-BD16');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('AI6456','KL-DB17');




--Memiliki Cabang1
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('GA1231','DPS');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('LI2345','DPS');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PA2315','DPS');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('SJ22115','DPS');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('TN2551','DPS');

INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('GA1231','CGK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('LI2345','CGK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PA2315','CGK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('SJ22115','CGK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('TN2551','CGK');


INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('GA1231','HLP');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('LI2345','HLP');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PA2315','HLP');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('SJ22115','HLP');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('TN2551','HLP');


INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('GA1231','YIA');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('LI2345','YIA');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PA2315','YIA');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('SJ22115','YIA');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('TN2551','YIA');


INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('GA1231','JOG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('LI2345','JOG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PA2315','JOG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('SJ22115','JOG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('TN2551','JOG');

--Memiliki Cabang Darat
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('HY0989', 'TTN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('SJ0221', 'TTN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('HY0989', 'TBO');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('SJ0221', 'TBO');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('HY0989', 'PLG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('SJ0221', 'PLG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('HY0989', 'GWN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('SJ0221', 'GWN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('HY0989', 'LBK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan], [L_KdLokasi])
VALUES ('SJ0221', 'LBK');

--MEMILIKI CABANG LAUT
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDTPR');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDBTH');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDTPE');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDBPN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDMAK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDSRG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDMRK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDTKG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDBJU');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('NY6823','IDGIL');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDTPR');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDBTH');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDTPE');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDBPN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDMAK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDSRG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDMRK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDTKG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDBJU');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('KL0119','IDGIL');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDTPR');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDBTH');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDTPE');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDBPN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDMAK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDSRG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDMRK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDTKG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDBJU');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('PN6556','IDGIL');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDTPR');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDBTH');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDTPE');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDBPN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDMAK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDSRG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDMRK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDTKG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDBJU');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('JF7724','IDGIL');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDTPR');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDBTH');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDTPE');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDBPN');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDMAK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDSRG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDMRK');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDTKG');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDBJU');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('AI6456','IDGIL');



--Kendaraan Udara
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-ZJI',2019,'PESAWAT','Boeing 737','GA1231');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-GSI',2019,'PESAWAT','Boeing 737','GA1231');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-LKP',2019,'PESAWAT','Boeing 737-800','LI2345');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-LOO',2019,'PESAWAT','Boeing 737-800','LI2345');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-PWI',2018,'PESAWAT','Airbus A320','PA2315');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-PWL',2018,'PESAWAT','Airbus A320','PA2315');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-SAA',2013,'PESAWAT','Airbus A320','SJ22115');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-SAC',2013,'PESAWAT','Airbus A320','SJ22115');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-TLB',2013,'PESAWAT','Airbus A320-214','TN2551');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('PK-TLC',2013,'PESAWAT','Airbus A320-214','TN2551');

--Kendaraan Darat
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('AD 1305 KC',2023,'Motor','Honda Beat','GJ2315');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('F 9876 EF', 2021, 'Motor', 'Yamaha NMAX', 'GJ2315');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('D 5678 XY', 2022, 'Mobil', 'Toyota Avanza', 'BB8796');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('AB 4891 JK',2022,'Mobil','Toyota Vios','BB8796');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('JS852', 1997, 'Kereta Api', 'KA Argo Bromo Anggrek', 'KA0978');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('KA14',1997,'Kereta Api','KA Argo Muria','KA0978');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('B 7134 VGA',2010,'Bus','Bus Sensation','HY0989');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('B 6524 KL',2015,'Bus','Bus Sun Breaker','HY0989');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('B 9853 JN',2006,'Bus','Bus Hino RK8','SJ0221');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('B 5129 DA',2019,'Bus','Bus Hino RN 285','SJ0221');

--Kendaraan Laut
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 8806204',1990,'Kapal Pesiar','Asuka II','NY6823');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 9160011',1998,'Kapal Pesiar','Pacific Venus','NY6823');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 8817631',1984,'Kapal Pesiar','Nippon Maru','NY6823');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 9158575',1998,'Kapal Roro','Highway','KL0119');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 6793756',1994,'Kapal Penumpang','KM Bukit Raya','PN6556');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 9032159',2021,'Kapal Penumpang','KM Leuser','PN6556');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 8921755',1990,'Kapal Roro','Virgo 18','JF7724');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 8504703',1985,'Kapal Ferry','Jemala Fajar','JF7724');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 8666147',2013,'Kapal Roro','KMP Port Link V','AI6456');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('IMO 7818638',1980,'Kapal Ferry','KMP Jatra II','AI6456');

--K_UDARA
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-ZJI','29000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-GSI','28000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-LKP','27000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-LOO','26000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-PWI','30000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-PWL','31000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-SAA','33000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-SAC','34000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-TLB','35000ft');
INSERT INTO [K_UDARA] ([K_KdKendaraan],[KetinggianMaksimum]) VALUES ('PK-TLC','38000ft');

--K_DARAT

INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('AD 1305 KC','Jalan Beraspal');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('F 9876 EF','Jalan Beraspal');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('D 5678 XY','Jalan Beraspal');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('AB 4891 JK','Jalan Beraspal');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('JS852', 'Rel Kereta');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('KA14', 'Rel Kereta');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('B 7134 VGA','Jalan Beraspal');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('B 6524 KL','Jalan Beraspal');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('B 9853 JN','Jalan Beraspal');
INSERT INTO [K_DARAT] ([K_KdKendaraan],JenisJalur) VALUES ('B 5129 DA','Jalan Beraspal');

--K_LAUT
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 8806204', 2);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 9160011', 2);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 8817631', 2);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 9158575', 1);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 6793756', 1);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 9032159', 1);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 8921755', 1);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 8504703', 1);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 8666147', 1);
INSERT INTO [K_LAUT] ([K_KdKendaraan],[BanyakLambung]) VALUES ('IMO 7818638', 1);



--Perjalanan Udara
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('GA-187','P-SJ12','DPS','CGK');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('GA-146','P-SH33','DPS','HLP');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('JT-387','P-SY99','DPS','YIA');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('JT-399','P-SJ87','DPS','JOG');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('IU-505','P-AJ95','YIA','CGK');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('IU-745','P-AH09','YIA','HLP');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('IP-325','P-AY90','HLP','YIA');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('IP-243','P-AJ87','HLP','JOG');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]) VALUES ('8B-5109','P-AJ90','JOG','CGK');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari], [L_KdLokasiSampaiDi]	) VALUES ('8B-652','P-AH19','JOG','HLP');

--Perjalanan Darat
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('RO-21463','M-SS65','-7.559803252025726, 110.83639576653093','-7.5609646599458555, 110.85858570832038');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('BT-34215','M-SS87','-7.560428347228102, 110.84881078991822','-7.559803252025726, 110.83639576653093');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('RO-21464','M-SS52','-7.5609646599458555, 110.85858570832038','-7.548248275194625, 110.85874799536677');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('BT-76559','M-SS77','-7.559803252025726, 110.83639576653093','-7.560428347228102, 110.84881078991822');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('BT-97372','M-SS94','-7.551593845550375, 110.86069801846344','-7.559803252025726, 110.83639576653093');

INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('KAI-20875','KA-SY47','SLO','TUG');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('KAI-34970','KA-JB97','GMR','BD');

INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('JS-21273','B-JS47','LBK','TTN');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('YJ-45229','B-JY55','GWN','PLG');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('SS-89773','B-SA83','TTN','TBO');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('YB-62412','B-SY91','GWN','LBK');

--PERJALANAN LAUT
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('BC 7739','KL-JB31','IDTPR','IDBTH');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('TP 8438','KL-BJ32','IDBTH','IDTPR');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('BP 9387','KL-SB58','IDTPE','IDBPN');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('TR 2947','KL-BS57','IDBPN','IDTPE');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('TE 7490','KL-MS98','IDMAK','IDSRG');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('SH 9473','KL-SM99','IDSRG','IDMAK');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('LS 8023','KL-CL45','IDMRK','IDTKG');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('CI 8923','KL-LC44','IDTKG','IDMRK');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('GI 1306','KL-BD16','IDBJU','IDGIL');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[R_KdRute],[L_KdLokasiBerangkatDari],[L_KdLokasiSampaiDi]) VALUES ('TB 1306','KL-DB17','IDGIL','IDBJU');


--Pengemudi Udara
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54544', 'Yutre Siregar', 'MIR', 'GA1231');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54545', 'Enico Wayer', 'CLP', 'GA1231');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54546', 'Reti Woyuno', 'PPL', 'GA1231');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54547', 'Rina Wijaya', 'PPL', 'GA1231');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54548', 'Budi Santoso', 'MIR', 'LI2345');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54549', 'Lia Putri', 'CLP', 'LI2345');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54550', 'Agus Kurniawan', 'PPL', 'LI2345');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54551', 'Siti Rahayu', 'MIR', 'LI2345');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54552', 'Fandi Wirawan', 'CLP', 'PA2315');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54553', 'Dian Fitri', 'PPL', 'PA2315');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54554', 'Rudi Setiawan', 'MIR', 'PA2315');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54555', 'Nina Haryanto', 'CLP', 'PA2315');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54556', 'Hendra Wijaya', 'PPL', 'SJ22115');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54557', 'Dewi Anggraini', 'MIR', 'SJ22115');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54558', 'Surya Perdana', 'CLP', 'SJ22115');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54559', 'Rizky Saputra', 'PPL', 'SJ22115');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54560', 'Ratna Sari', 'MIR', 'TN2551');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54561', 'Ilham Ramadhan', 'CLP', 'TN2551');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54562', 'Eva Suryani', 'PPL', 'TN2551');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi], [NamaPengemudi], [Lisensi], [Per_KdPerusahaan]) VALUES
('54563', 'Adi Prabowo', 'MIR', 'TN2551');

--Pengemudi Darat
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44541', 'Joko Sudirman', 'SIM B', 'SJ0221');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44542', 'Budi Harjanto', 'SIM B', 'SJ0221');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44543', 'Agus Wibowo', 'CoC', 'KA0978');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44544', 'Dewi Rahayu', 'CoC', 'KA0978');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44545', 'Firman Putra', 'SIM A', 'BB8796');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44546', 'Rini Wijaya', 'SIM A', 'BB8796');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44547', 'Hendra Gunawan', 'SIM C', 'GJ2315');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44548', 'Lina Susanto', 'SIM C', 'GJ2315');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44549', 'Ivan Santoso', 'SIM B', 'HY0989');

INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) 
VALUES ('44550', 'Rita Cahyani', 'SIM B', 'HY0989');

--PENGEMUDI LAUT
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6720','Dadang Apriyanto','COC','NY6823');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6721','Anita Susanti','COC','NY6823');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6722','Hadi Susanto','COC','NY6823');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6723','Siti Rahayu','COC','KL0119');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6724','Agus Santoso','COC','PN6556');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6725','Siti Maryati','COC','PN6556');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6726','Ahmad Ridwan','COC','JF7724');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6727','Rina Susanti','COC','JF7724');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6728','Budi Santoso','COC','AI6456');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[Per_KdPerusahaan]) VALUES ('6729','Dewi Susanti','COC','AI6456');


--Mengemudikan Udara
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-ZJI','54544');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-ZJI','54545');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-GSI','54546');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-GSI','54547');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-LKP','54548');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-LKP','54549');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-LOO','54550');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-LOO','54551');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-PWI','54552');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-PWI','54553');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-PWL','54554');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-PWL','54555');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-SAA','54556');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-SAA','54557');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-SAC','54558');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-SAC','54559');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-TLB','54560');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-TLB','54561');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-TLC','54562');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('PK-TLC','54563');

--MENGEMUDIKAN DARAT
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('B 5129 DA', '44541');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('B 9853 JN', '44542');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('KA14', '44543');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('JS852', '44544');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('AB 4891 JK', '44545');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('D 5678 XY', '44546');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('F 9876 EF', '44547');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('AD 1305 KC', '44548');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('B 6524 KL', '44549');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('B 7134 VGA', '44550');



--MENGEMUDIKAN LAUT
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 8806204','6720');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 9160011','6721');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 8817631','6722');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 9158575','6723');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 6793756','6724');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 9032159','6725');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 8921755','6726');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 8504703','6727');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 8666147','6728');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('IMO 7818638','6729');



--Melakukan
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-GSI','GA-187');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-ZJI','GA-146');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-LKP','JT-387');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-LOO','JT-399');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-SAA','IU-505');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-SAC','IU-745');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-PWI','IP-325');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-PWL','IP-243');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-TLB','8B-5109');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('PK-TLC','8B-652');

--Melakukan Darat

INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('AD 1305 KC', 'RO-21463');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('AB 4891 JK', 'BT-34215');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('F 9876 EF', 'RO-21463');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('D 5678 XY', 'BT-76559');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('AB 4891 JK', 'BT-97372');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('JS852', 'KAI-20875');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('KA14', 'KAI-34970');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('B 7134 VGA', 'JS-21273');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('B 6524 KL', 'YJ-45229');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('B 5129 DA', 'SS-89773');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('B 9853 JN', 'YB-62412');

--MELAKUKAN LAUT
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 8806204','BC 7739');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 9160011','TP 8438');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 8817631','BP 9387');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 9158575','TR 2947');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 6793756','TE 7490');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 9032159','SH 9473');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 8921755','LS 8023');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 8504703','CI 8923');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 8666147','GI 1306');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('IMO 7818638','TB 1306');



--Penumpang
INSERT INTO [PENUMPANG] ([NIK], [NamaPenumpang], [Umur], [K_KdKendaraan]) 
VALUES 
    ('001212', 'Handoko Setiawan', '45', 'PK-GSI'),
    ('002323', 'Budi Santoso', '28', 'PK-GSI'),
    ('003434', 'Cindy Wijaya', '35', 'PK-GSI'),
    ('004545', 'Dedy Nugroho', '40', 'PK-GSI'),
    ('005656', 'Eva Susanti', '32', 'PK-GSI'),
    ('006767', 'Feriawan Pratama', '27', 'PK-GSI'),
    ('007878', 'Gita Permata', '48', 'PK-GSI'),
    ('008989', 'Hendra Kurniawan', '39', 'PK-GSI'),
    ('009090', 'Ika Putri', '29', 'PK-GSI'),
    ('010101', 'Joko Santoso', '42', 'PK-GSI');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan])
VALUES
    ('002121', 'Budi Santoso', '30', 'PK-ZJI'),
    ('003343', 'Rina Setiawan', '28', 'PK-ZJI'),
    ('004565', 'Tono Sugianto', '35', 'PK-ZJI'),
    ('005787', 'Siti Aminah', '40', 'PK-ZJI'),
    ('006909', 'Joko Prabowo', '32', 'PK-ZJI'),
    ('007131', 'Dewi Murni', '27', 'PK-ZJI'),
    ('008353', 'Yoga Wibowo', '38', 'PK-ZJI'),
    ('009575', 'Sinta Dewi', '33', 'PK-ZJI'),
    ('010797', 'Hadi Santoso', '29', 'PK-ZJI'),
    ('011919', 'Rita Anggraini', '42', 'PK-ZJI');

INSERT INTO [PENUMPANG] ([NIK], [NamaPenumpang], [Umur], [K_KdKendaraan])
VALUES 
  ('100001', 'Budi Santoso', '30', 'PK-LKP'),
  ('100002', 'Citra Utami', '25', 'PK-LKP'),
  ('100003', 'Dedy Pratama', '28', 'PK-LKP'),
  ('100004', 'Eva Putri', '35', 'PK-LKP'),
  ('100005', 'Fandi Raharjo', '22', 'PK-LKP'),
  ('100006', 'Gita Wijaya', '40', 'PK-LKP'),
  ('100007', 'Hendra Gunawan', '32', 'PK-LKP'),
  ('100008', 'Ika Susanti', '27', 'PK-LKP'),
  ('100009', 'Joko Wibowo', '29', 'PK-LKP'),
  ('100010', 'Kartika Dewi', '38', 'PK-LKP');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES 
('200001','John Doe','30','PK-LOO'),
('200002','Jane Doe','25','PK-LOO'),
('200003','Alice Smith','35','PK-LOO'),
('200004','Bob Johnson','40','PK-LOO'),
('200005','Eva Brown','28','PK-LOO'),
('200006','Charlie White','42','PK-LOO'),
('200007','David Black','32','PK-LOO'),
('200008','Grace Lee','29','PK-LOO'),
('200009','Frank Miller','38','PK-LOO'),
('200010','Helen Davis','33','PK-LOO');

INSERT INTO [PENUMPANG] ([NIK], [NamaPenumpang], [Umur], [K_KdKendaraan])
VALUES 
    ('301001', 'Andi Wijaya', '28', 'PK-SAA'),
    ('302002', 'Budi Santoso', '35', 'PK-SAA'),
    ('303003', 'Citra Wulandari', '22', 'PK-SAA'),
    ('304004', 'Dika Pratama', '40', 'PK-SAA'),
    ('305005', 'Eva Fitriani', '30', 'PK-SAA'),
    ('306006', 'Fandi Setiawan', '25', 'PK-SAA'),
    ('307007', 'Gina Rahayu', '33', 'PK-SAA'),
    ('308008', 'Hadi Saputra', '28', 'PK-SAA'),
    ('309009', 'Indra Kusuma', '38', 'PK-SAA'),
    ('310010', 'Joko Susilo', '29', 'PK-SAA');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES 
('400001', 'John Doe', '30', 'PK-SAC'),
('400002', 'Jane Doe', '25', 'PK-SAC'),
('400003', 'Alice Wonderland', '28', 'PK-SAC'),
('400004', 'Bob Marley', '35', 'PK-SAC'),
('400005', 'Charlie Chaplin', '40', 'PK-SAC'),
('400006', 'David Beckham', '32', 'PK-SAC'),
('400007', 'Eva Mendes', '29', 'PK-SAC'),
('400008', 'Frank Sinatra', '38', 'PK-SAC'),
('400009', 'Grace Kelly', '27', 'PK-SAC'),
('400010', 'Harry Potter', '22', 'PK-SAC');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES 
('501234', 'Budi Santoso', '28', 'PK-PWI'),
('512345', 'Dewi Lestari', '35', 'PK-PWI'),
('523456', 'Eko Prabowo', '42', 'PK-PWI'),
('534567', 'Fitri Amelia', '31', 'PK-PWI'),
('545678', 'Gunawan Wijaya', '48', 'PK-PWI'),
('556789', 'Hani Putri', '27', 'PK-PWI'),
('567890', 'Indra Permana', '39', 'PK-PWI'),
('578901', 'Jasmine Putri', '34', 'PK-PWI'),
('589012', 'Krisna Wijaya', '40', 'PK-PWI'),
('590123', 'Lia Anggraeni', '29', 'PK-PWI');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) 
VALUES 
    ('600001', 'Budi Santoso', '28', 'PK-PWL'),
    ('600002', 'Citra Putri', '35', 'PK-PWL'),
    ('600003', 'Dika Surya', '22', 'PK-PWL'),
    ('600004', 'Eka Pratiwi', '40', 'PK-PWL'),
    ('600005', 'Fahmi Anwar', '32', 'PK-PWL'),
    ('600006', 'Gita Rahayu', '29', 'PK-PWL'),
    ('600007', 'Hendro Wijaya', '25', 'PK-PWL'),
    ('600008', 'Indra Perdana', '38', 'PK-PWL'),
    ('600009', 'Jasmine Putri', '31', 'PK-PWL'),
    ('600010', 'Kurnia Sari', '27', 'PK-PWL');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan])
VALUES 
('701234', 'Handoko Adi', '45', 'PK-TLB'),
('702345', 'Dewi Rahayu', '28', 'PK-TLB'),
('703456', 'Budi Santoso', '35', 'PK-TLB'),
('704567', 'Siti Aisyah', '50', 'PK-TLB'),
('705678', 'Hadi Prabowo', '32', 'PK-TLB'),
('706789', 'Rini Cahyani', '40', 'PK-TLB'),
('707890', 'Fajar Setiawan', '28', 'PK-TLB'),
('708901', 'Anita Wijaya', '55', 'PK-TLB'),
('709012', 'Eko Sutrisno', '30', 'PK-TLB'),
('710123', 'Nina Indriani', '42', 'PK-TLB');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan])
VALUES 
  ('700001', 'John Doe', '25', 'PK-TLC'),
  ('700002', 'Jane Smith', '30', 'PK-TLC'),
  ('700003', 'Bob Johnson', '22', 'PK-TLC'),
  ('700004', 'Alice Williams', '28', 'PK-TLC'),
  ('700005', 'Charlie Brown', '35', 'PK-TLC'),
  ('700006', 'Eva Davis', '40', 'PK-TLC'),
  ('700007', 'Frank White', '32', 'PK-TLC'),
  ('700008', 'Grace Lee', '27', 'PK-TLC'),
  ('700009', 'Henry Miller', '38', 'PK-TLC'),
  ('700010', 'Ivy Taylor', '29', 'PK-TLC');

--Penumpang Darat
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('009877','Handoko','45','JS852');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('002345','Putri','30','JS852');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('003678','Budi','28','JS852');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('004901','Lina','35','JS852');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('005234','Rio','40','JS852');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('002313','Irwan','28','KA14');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('002123','Sari','32','KA14');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('003953','Aji','40','KA14');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('004215','Rini','25','KA14');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('002564','Dana','36','KA14');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('008921','Harun','36','AD 1305 KC');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('007381','Aya','36','F 9876 EF');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('009321','Dina','36','D 5678 XY');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('007453','Rian','36','AB 4891 JK');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('010111','Andi','27','B 7134 VGA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('020222','Sinta','31','B 7134 VGA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('030333','Cahyo','39','B 7134 VGA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('040444','Ratna','24','B 7134 VGA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('050555','Dewi','35','B 7134 VGA');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('061111','Indra','28','B 6524 KL');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('072222','Sari','32','B 6524 KL');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('083333','Adi','40','B 6524 KL');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('094444','Rina','25','B 6524 KL');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('105555','Dino','36','B 6524 KL');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('111111','Indah','28','B 9853 JN');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('122222','Surya','32','B 9853 JN');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('133333','Aris','40','B 9853 JN');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('144444','Riana','25','B 9853 JN');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('155555','Dona','36','B 9853 JN');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('211111','Irfan','28','B 5129 DA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('222222','Siska','32','B 5129 DA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('233333','Aditya','40','B 5129 DA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('244444','Rizky','25','B 5129 DA');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('255555','Dina','36','B 5129 DA');

--PENUMPANG LAUT
--1
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3203012503770011','Agus Salim',45,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1446632802040001','Cantika Putri',19,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1446632108070001','Budi Santoso',14,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3980521802901746','Citra Andini',23,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7650131890078234','Dwi Susanto',28,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6182092094629308','Eka Putra',31,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8745031802198650','Farah Nurani',27,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2051981965029187','Galih Prasetyo',32,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1934870230183745','Hesti Putri',29,'IMO 8806204');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6182098180462308','Ilham Maulana',22,'IMO 8806204');
--2
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8745036180219650','Jaka Nuryanto',25,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2051984965029187','Kartika Sari',29,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1594870230183745','Lintang Pratama',26,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5098121837465023','Mia Agustina',34,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7865031802198650','Nanda Putra',30,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3453981965029187','Oki Pratama',25,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('4321985180709236','Putri Ayu',33,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5098131964823015','Rangga Wijaya',27,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6790181964308741','Sigit Pramana',31,'IMO 9160011');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3576920814328506','Udin Syarif',28,'IMO 9160011');
--3
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8052018029017412','Denny Prasetyo',23,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('0131890078234523','Rika Wijaya',28,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2092094629308134','Rudi Hartono',31,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5031802198650245','Intan Purnama',27,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1981965029187456','Ari Wibisono',32,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('4870230183745367','Yanti Susanti',29,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2098180462308734','Eko Prasetya',22,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5036180219650467','Nita Utami',25,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1984965029187689','Fajar Ramadhan',29,'IMO 8817631');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('4870230183745645','Lia Puspita',26,'IMO 8817631');
--4
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8121837465023487','Dedi Susanto',34,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5031802198650534','Siska Melati',30,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1981965029187557','Arif Rahman',25,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1985180709236235','Yuli Astuti',33,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8131964823015457','Didik Setiawan',27,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2181964308741279','Wulan Sari',31,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6920814328506780','Dito Prabowo',28,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3856942701325068','Neni Permadi',26,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5713940857364253','Arief Kurniawan',30,'IMO 9158575');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1245670983215835','Irma Cahyani',32,'IMO 9158575');
--5
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3052018029017462','Dian Septiani',23,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1131890078234543','Rizky Pradipta',28,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('4092094629308164','Ayu Lestari',31,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('0031802198650256','Rendy Wijaya',27,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2981965029187424','Putri Anggraini',32,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5870230183745389','Bayu Kusuma',29,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3098180462308736','Della Safitri',22,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6036180219650490','Ilham Nugraha',25,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5870230183745623','Rina Marliani',26,'IMO 6793756');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3121837465023478','Yogi Saputra',34,'IMO 6793756');
--6
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1031802198650512','Ade Santoso',30,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2981965029187532','Tiara Putri',25,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2985180709236254','Dito Wicaksono',33,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3131964823015463','Maya Dewi',27,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1181964308741263','Fauzi Rizal',31,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8920814328506764','Nia Anggraini',28,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6856942701325023','Aryo Pramono',26,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8713940857364257','Siska Utami',30,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3245670983215832','Rizki Permadi',32,'IMO 9032159');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5092120346729854','Rina Kartika',27,'IMO 9032159');
--7
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7856320194687312','Denny Setiawan',31,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6318209376542072','Devi Lestari',25,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5681203574981958','Agus Riyanto',29,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7120934861582793','Fika Wulandari',32,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3982175460823109','Yoga Pratama',34,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6109834572401869','Nita Rahayu',28,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('1584032967841562','Bayu Surya',33,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8302415786942989','Rika Setyawati',26,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('4968207351684092','Irfan Nugroho',30,'IMO 8921755');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7621940583172400','Sari Putri',31,'IMO 8921755');
--8
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2597031684327812','Andika Prasetyo',27,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('4137596820413745','Rini Puspita',29,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2043917682350956','Dodi Hermawan',33,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7916405827319665','Wulan Kusuma',28,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5874031269870267','Irfan Maulana',26,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3621048795612378','Maya Safitri',30,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('5193876420935765','Agus Setiawan',32,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6570983124507645','Sari Permatasari',34,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('9358102746398565','Bayu Wijaya',27,'IMO 8504703');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7194685230817445','Nia Fitria',25,'IMO 8504703');
--9
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('8762943501827465','Rizki Santoso',29,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3209864175209345','Dina Septiani',31,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('4587023196587176','Yogi Kurniawan',28,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6421305987164298','Rina Permadi',30,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('3802764915823745','Rendy Pratama',33,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2849175630824765','Indah Suryani',26,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('9372605841792367','Faisal Rahman',31,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('7814047985416245','Aldo Amarlo',29,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('6514037985416234','Yanto Teguh',29,'IMO 8666147');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('2314037985682232','Tiara Dewanti',54,'IMO 8666147');
--10
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('87940561327481','Andika Prasetyo',32,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('19382476059183','Rini Puspita',34,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('67840352194875','Dodi Hermawan',28,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('93416805271394','Wulan Kusuma',25,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('51073264891756','Irfan Maulana',29,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('72658132405978','Maya Safitri',32,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('85210493761852','Agus Setiawan',27,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('30948165274309','Sari Permatasari',31,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('47521308942573','Bayu Wijaya',26,'IMO 7818638');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('64317850296431','Nia Fitria',30,'IMO 7818638');




--Pembayaran Udara
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1001',800000,'10 Agustus 2023','001212','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1002',800000,'10 Agustus 2023','002323','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1003',800000,'10 Agustus 2023','003434','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1004',800000,'10 Agustus 2023','004545','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1005',800000,'10 Agustus 2023','005656','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1006',800000,'10 Agustus 2023','006767','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1007',800000,'10 Agustus 2023','007878','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1008',800000,'10 Agustus 2023','008989','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1009',800000,'10 Agustus 2023','009090','PK-GSI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1010',800000,'10 Agustus 2023','010101','PK-GSI');

INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2001',950000,'9 November 2023','002121','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2002',950000,'9 November 2023','003343','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2003',950000,'9 November 2023','004565','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2004',950000,'9 November 2023','005787','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2005',950000,'9 November 2023','006909','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2006',950000,'9 November 2023','007131','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2007',950000,'9 November 2023','008353','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2008',950000,'9 November 2023','009575','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2009',950000,'9 November 2023','010797','PK-ZJI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP2010',950000,'9 November 2023','011919','PK-ZJI');

INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3001',700000,'3 Februari 2023','100001','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3002',700000,'3 Februari 2023','100002','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3003',700000,'3 Februari 2023','100003','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3004',700000,'3 Februari 2023','100004','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3005',700000,'3 Februari 2023','100005','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3006',700000,'3 Februari 2023','100006','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3007',700000,'3 Februari 2023','100007','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3008',700000,'3 Februari 2023','100008','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3009',700000,'3 Februari 2023','100009','PK-LKP');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP3010',700000,'3 Februari 2023','100010','PK-LKP');

INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4001',700000,'24 Januari 2023','200001','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4002',700000,'24 Januari 2023','200002','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4003',700000,'24 Januari 2023','200003','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4004',700000,'24 Januari 2023','200004','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4005',700000,'24 Januari 2023','200005','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4006',700000,'24 Januari 2023','200006','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4007',700000,'24 Januari 2023','200007','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4008',700000,'24 Januari 2023','200008','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4009',700000,'24 Januari 2023','200009','PK-LOO');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP4010',700000,'24 Januari 2023','200010','PK-LOO');


INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5001',850000,'12 Mei 2023','301001','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5002',850000,'12 Mei 2023','302002','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5003',850000,'12 Mei 2023','303003','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5004',850000,'12 Mei 2023','304004','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5005',850000,'12 Mei 2023','305005','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5006',850000,'12 Mei 2023','306006','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5007',850000,'12 Mei 2023','307007','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5008',850000,'12 Mei 2023','308008','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5009',850000,'12 Mei 2023','309009','PK-SAA');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP5010',850000,'12 Mei 2023','310010','PK-SAA');

INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6001',850000,'7 April 2023','400001','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6002',850000,'7 April 2023','400002','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6003',850000,'7 April 2023','400003','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6004',850000,'7 April 2023','400004','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6005',850000,'7 April 2023','400005','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6006',850000,'7 April 2023','400006','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6007',850000,'7 April 2023','400007','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6008',850000,'7 April 2023','400008','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6009',850000,'7 April 2023','400009','PK-SAC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP6010',850000,'7 April 2023','400010','PK-SAC');


INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7001',1000000,'8 September 2023','501234','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7002',1000000,'8 September 2023','512345','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7003',1000000,'8 September 2023','523456','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7004',1000000,'8 September 2023','534567','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7005',1000000,'8 September 2023','545678','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7006',1000000,'8 September 2023','556789','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7007',1000000,'8 September 2023','567890','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7008',1000000,'8 September 2023','578901','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7009',1000000,'8 September 2023','589012','PK-PWI');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP7010',1000000,'8 September 2023','590123','PK-PWI');

INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8001',1250000,'1 Januari 2023','600001','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8002',1250000,'1 Januari 2023','600002','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8003',1250000,'1 Januari 2023','600003','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8004',1250000,'1 Januari 2023','600004','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8005',1250000,'1 Januari 2023','600005','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8006',1250000,'1 Januari 2023','600006','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8007',1250000,'1 Januari 2023','600007','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8008',1250000,'1 Januari 2023','600008','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8009',1250000,'1 Januari 2023','600009','PK-PWL');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP8010',1250000,'1 Januari 2023','600010','PK-PWL');

INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9001',1150000,'30 Maret 2023','701234','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9002',1150000,'30 Maret 2023','702345','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9003',1150000,'30 Maret 2023','703456','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9004',1150000,'30 Maret 2023','704567','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9005',1150000,'30 Maret 2023','705678','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9006',1150000,'30 Maret 2023','706789','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9007',1150000,'30 Maret 2023','707890','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9008',1150000,'30 Maret 2023','708901','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9009',1150000,'30 Maret 2023','709012','PK-TLB');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP9010',1150000,'30 Maret 2023','710123','PK-TLB');

INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1101',1150000,'30 September 2023','700001','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1102',1150000,'30 September 2023','700002','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1103',1150000,'30 September 2023','700003','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1104',1150000,'30 September 2023','700004','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1105',1150000,'30 September 2023','700005','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1106',1150000,'30 September 2023','700006','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1107',1150000,'30 September 2023','700007','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1108',1150000,'30 September 2023','700008','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1109',1150000,'30 September 2023','700009','PK-TLC');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('PP1110',1150000,'30 September 2023','700010','PK-TLC');
--Pemabayran Darat
INSERT INTO [PEMBAYARAN] ([KdPembayaran], [Tarif], [TanggalPembayaran], [Pen_NIK], [K_KdKendaraan])
VALUES	('Ka6371', 10000, '15-02-2023', '002313','KA14'),
		('Ka6372', 10000, '15-02-2023', '002123', 'KA14'),
		('Ka6373', 10000, '15-02-2023', '003953', 'KA14'),
		('Ka6374', 10000, '15-02-2023', '004215', 'KA14'),
		('Ka6375', 10000, '15-02-2023', '002564', 'KA14');

INSERT INTO [PEMBAYARAN] ([KdPembayaran], [Tarif], [TanggalPembayaran], [Pen_NIK], [K_KdKendaraan])
VALUES ('Ka5512', 8000, '21-05-2023', '001212', 'JS852'),
       ('Ka5513', 8000, '21-05-2023', '002345', 'JS852'),
       ('Ka5514', 8000, '21-05-2023', '003678', 'JS852'),
       ('Ka5515', 8000, '21-05-2023', '004901', 'JS852'),
       ('Ka5516', 8000, '21-05-2023', '005234', 'JS852');

INSERT INTO [PEMBAYARAN] ([KdPembayaran], [Tarif], [TanggalPembayaran], [Pen_NIK], [K_KdKendaraan])
VALUES
  ('Hy1761', 110000, '13-07-2023', '061111', 'B 6524 KL'),
  ('Hy1762', 110000, '13-07-2023', '072222', 'B 6524 KL'),
  ('Hy1763', 110000, '13-07-2023', '083333', 'B 6524 KL'),
  ('Hy1764', 110000, '13-07-2023', '094444', 'B 6524 KL'),
  ('Hy1765', 110000, '13-07-2023', '105555', 'B 6524 KL');

INSERT INTO [PEMBAYARAN] ([KdPembayaran], [Tarif], [TanggalPembayaran], [Pen_NIK], [K_KdKendaraan])
VALUES ('Hy2781', 120000, '23-11-2023', '010111', 'B 7134 VGA'),
       ('Hy2782', 120000, '23-11-2023', '020222', 'B 7134 VGA'),
       ('Hy2783', 120000, '23-11-2023', '030333', 'B 7134 VGA'),
       ('Hy2784', 120000, '23-11-2023', '040444', 'B 7134 VGA'),
       ('Hy2785', 120000, '23-11-2023', '050555', 'B 7134 VGA');

INSERT INTO [PEMBAYARAN] ([KdPembayaran], [Tarif], [TanggalPembayaran], [Pen_NIK], [K_KdKendaraan])
VALUES 
  ('Sj2421', 125000, '07-11-2023', '111111', 'B 9853 JN'),
  ('Sj2422', 125000, '07-11-2023', '122222', 'B 9853 JN'),
  ('Sj2423', 125000, '07-11-2023', '133333', 'B 9853 JN'),
  ('Sj2424', 125000, '07-11-2023', '144444', 'B 9853 JN'),
  ('Sj2425', 125000, '07-11-2023', '155555', 'B 9853 JN');

INSERT INTO [PEMBAYARAN] ([KdPembayaran], [Tarif], [TanggalPembayaran], [Pen_NIK], [K_KdKendaraan])
VALUES 
  ('Sj3421', 145000, '16-10-2023', '211111', 'B 5129 DA'),
  ('Sj3422', 145000, '16-10-2023', '222222', 'B 5129 DA'),
  ('Sj3423', 145000, '16-10-2023', '233333', 'B 5129 DA'),
  ('Sj3424', 145000, '16-10-2023', '244444', 'B 5129 DA'),
  ('Sj3425', 145000, '16-10-2023', '255555', 'B 5129 DA');

--PEMBAYARAN LAUT
--1
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1288',379000,'11 Desember 2023','3203012503770011','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1289',379000,'11 Desember 2023','1446632802040001','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1290',379000,'11 Desember 2023','1446632108070001','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1291',379000,'11 Desember 2023','3980521802901746','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1292',379000,'11 Desember 2023','7650131890078234','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1293',379000,'11 Desember 2023','6182092094629308','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1294',379000,'11 Desember 2023','8745031802198650','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1295',379000,'11 Desember 2023','2051981965029187','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1296',379000,'11 Desember 2023','1934870230183745','IMO 8806204');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1297',379000,'11 Desember 2023','6182098180462308','IMO 8806204');

--2
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1298',310000,'12 Desember 2023','8745036180219650','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1299',310000,'12 Desember 2023','2051984965029187','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1300',310000,'12 Desember 2023','1594870230183745','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1301',310000,'12 Desember 2023','5098121837465023','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1302',310000,'12 Desember 2023','7865031802198650','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1303',310000,'12 Desember 2023','3453981965029187','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1304',310000,'12 Desember 2023','4321985180709236','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1305',310000,'12 Desember 2023','5098131964823015','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1306',310000,'12 Desember 2023','6790181964308741','IMO 9160011');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk1307',310000,'12 Desember 2023','3576920814328506','IMO 9160011');

--3
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8367',511000,'23 Agustus 2023','8052018029017412','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8368',511000,'23 Agustus 2023','0131890078234523','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8369',511000,'23 Agustus 2023','2092094629308134','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8370',511000,'23 Agustus 2023','5031802198650245','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8371',511000,'23 Agustus 2023','1981965029187456','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8372',511000,'23 Agustus 2023','4870230183745367','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8373',511000,'23 Agustus 2023','2098180462308734','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8374',511000,'23 Agustus 2023','5036180219650467','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8375',511000,'23 Agustus 2023','1984965029187689','IMO 8817631');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8376',511000,'23 Agustus 2023','4870230183745645','IMO 8817631');

--4
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8377',511000,'25 Agustus 2023','8121837465023487','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8378',511000,'25 Agustus 2023','5031802198650534','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8379',511000,'25 Agustus 2023','1981965029187557','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8380',511000,'25 Agustus 2023','1985180709236235','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8381',511000,'25 Agustus 2023','8131964823015457','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8382',511000,'25 Agustus 2023','2181964308741279','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8383',511000,'25 Agustus 2023','6920814328506780','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8384',511000,'25 Agustus 2023','3856942701325068','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8385',511000,'25 Agustus 2023','5713940857364253','IMO 9158575');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8386',511000,'25 Agustus 2023','1245670983215835','IMO 9158575');

--5
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6533',640000,'4 Juli 2023','3052018029017462','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6534',640000,'4 Juli 2023','1131890078234543','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6535',640000,'4 Juli 2023','4092094629308164','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6536',640000,'4 Juli 2023','0031802198650256','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6537',640000,'4 Juli 2023','2981965029187424','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6538',640000,'4 Juli 2023','5870230183745389','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6539',640000,'4 Juli 2023','3098180462308736','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6540',640000,'4 Juli 2023','6036180219650490','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6542',640000,'4 Juli 2023','5870230183745623','IMO 6793756');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6541',640000,'4 Juli 2023','3121837465023478','IMO 6793756');

--6
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6722',640000,'7 Juli 2023','1031802198650512','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6723',640000,'7 Juli 2023','2981965029187532','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6724',640000,'7 Juli 2023','2985180709236254','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6725',640000,'7 Juli 2023','3131964823015463','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6726',640000,'7 Juli 2023','1181964308741263','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6727',640000,'7 Juli 2023','8920814328506764','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6728',640000,'7 Juli 2023','6856942701325023','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6729',640000,'7 Juli 2023','8713940857364257','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6730',640000,'7 Juli 2023','3245670983215832','IMO 9032159');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk6731',640000,'7 Juli 2023','5092120346729854','IMO 9032159');

--7
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8971',22700,'7 Juli 2023','7856320194687312','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8972',22700,'7 Juli 2023','6318209376542072','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8973',22700,'7 Juli 2023','5681203574981958','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8974',22700,'7 Juli 2023','7120934861582793','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8975',22700,'7 Juli 2023','3982175460823109','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8976',22700,'7 Juli 2023','6109834572401869','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8977',22700,'7 Juli 2023','1584032967841562','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8978',22700,'7 Juli 2023','8302415786942989','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8979',22700,'7 Juli 2023','4968207351684092','IMO 8921755');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8980',22700,'7 Juli 2023','7621940583172400','IMO 8921755');

--8
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8981',22700,'8 Juli 2023','2597031684327812','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8982',22700,'8 Juli 2023','4137596820413745','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8983',22700,'8 Juli 2023','2043917682350956','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8984',22700,'8 Juli 2023','7916405827319665','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8985',22700,'8 Juli 2023','5874031269870267','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8986',22700,'8 Juli 2023','3621048795612378','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8987',22700,'8 Juli 2023','5193876420935765','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8988',22700,'8 Juli 2023','6570983124507645','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8989',22700,'8 Juli 2023','9358102746398565','IMO 8504703');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk8990',22700,'8 Juli 2023','7194685230817445','IMO 8504703');

--9
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2021',9650,'5 Mei 2023','8762943501827465','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2022',9650,'5 Mei 2023','3209864175209345','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2023',9650,'5 Mei 2023','4587023196587176','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2024',9650,'5 Mei 2023','6421305987164298','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2025',9650,'5 Mei 2023','3802764915823745','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2026',9650,'5 Mei 2023','2849175630824765','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2027',9650,'5 Mei 2023','9372605841792367','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2028',9650,'5 Mei 2023','7814047985416245','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2029',9650,'5 Mei 2023','6514037985416234','IMO 8666147');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2030',9650,'5 Mei 2023','2314037985682232','IMO 8666147');

--10
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2054',9650,'5 Mei 2023','8762943501827465','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2055',9650,'5 Mei 2023','3209864175209345','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2056',9650,'5 Mei 2023','4587023196587176','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2057',9650,'5 Mei 2023','6421305987164298','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2058',9650,'5 Mei 2023','3802764915823745','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2059',9650,'5 Mei 2023','2849175630824765','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2060',9650,'5 Mei 2023','9372605841792367','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2061',9650,'5 Mei 2023','7814047985416245','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2062',9650,'5 Mei 2023','6514037985416234','IMO 7818638');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[TanggalPembayaran],[Pen_NIK],[K_KdKendaraan]) VALUES ('Pk2063',9650,'5 Mei 2023','2314037985682232','IMO 7818638');


--P_OFFLINE
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1001','Cash','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1002','Debit','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1003','Cash','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1004','Debit','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1005','Cash','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1006','Debit','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1007','Cash','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1008','Debit','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1009','Cash','DPS');
INSERT INTO P_OFFLINE([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('PP1010','Debit','DPS');

--P_ONLINE
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2003','Tokopedia');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2004','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2006','Tokopedia');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2007','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2008','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2009','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP2010','Agoda');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3003','Tiket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3004','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3006','Tiket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3007','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3008','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3009','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP3010','Pegi-Pegi');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4003','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4004','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4006','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4007','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4008','Pegi-Pegi');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4009','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP4010','Traveloka');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5003','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5004','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5006','Pegi-Pegi');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5007','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5008','TIket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5009','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP5010','TIket.com');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6003','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6004','TIket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6006','Tiket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6007','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6008','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6009','Tiket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP6010','Traveloka');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7003','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7004','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7006','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7007','Tiket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7008','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7009','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP7010','Pegi-Pegi');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8003','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8004','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8006','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8007','Pegi-Pegi');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8008','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8009','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP8010','TIket.com');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9001','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9002','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9003','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9004','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9005','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9006','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9007','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9008','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9009','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP9010','Agoda');

INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1101','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1102','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1103','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1104','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1105','Agoda');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1106','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1107','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1108','TIket.com');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1109','Traveloka');
INSERT INTO P_ONLINE([Pem_KdPembayaran],[NamaAplikasi]) VALUES ('PP1110','Traveloka');

--PEMBAYARAN ONLINE OFFLINE DARAT
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Ka6371','Cash','GMR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Ka6372','Debit','GMR');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Ka6373','KAI Access');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Ka6374','KAI Access');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Ka6375','KAI Access');

INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Ka5512','Debit','SLO');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Ka5513','Cash','SLO');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Ka5514','KAI Access');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Ka5515','KAI Access');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Ka5516','KAI Access');

INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Hy1761','Cash','GWN');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Hy1762','Debit','GWN');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Hy1763','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Hy1764','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Hy1765','Traveloka');

INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Hy2781','Debit','LBK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) 
VALUES ( 'Hy2782','Debit','LBK');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Hy2783','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Hy2784','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Hy2785','Traveloka');

INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Gp7128','Gojek');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Gp8432','Gojek');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Tb7128','BlueBird App');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Tb5216','Bluebird App');

INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj2421','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj2422','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj2423','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj2424','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj2425','Traveloka');

INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj3421','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj3422','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj3423','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj3424','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran],[NamaAplikasi])
VALUES ( 'Sj3425','Traveloka');


--ONLINE LAUT
--1
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1288','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1289','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1290','Pegi-pegi');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1291','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1292','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1293','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1294','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1295','Pegi-pegi');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1296','Tiket.com');

INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1297','Tiket.com');

--2
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1298','Pegi-pegi');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1299','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1300','Pegi-pegi');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1301','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1302','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1303','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1304','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1305','Tiket.com');

INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1306','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk1307','Tiket.com');


--4
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8377','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8378','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8379','Agoda');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8380','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8381','Agoda');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8382','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8383','Agoda');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8384','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8385','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk8386','Agoda');

--5
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6533','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6534','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6535','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6536','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6537','Agoda');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6538','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6539','Tiket.com');

--6
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6722','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6723','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6724','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6725','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6726','Agoda');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6727','Traveloka');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6728','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6729','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6730','Tiket.com');
INSERT INTO [P_ONLINE] ([Pem_KdPembayaran], [NamaAplikasi]) VALUES ('Pk6731','Agoda');

--OFFLINE LAUT
--3
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8367','Cash','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8368','Cash','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8369','Cash','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8370','Debit','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8371','Cash','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8372','Debit','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8373','Debit','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8374','Debit','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8375','Cash','IDTPR');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8376','Cash','IDTPR');

--5
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk6540','Cash','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk6541','Cash','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk6542','Debit','IDMRK');

--7
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8971','Debit','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8972','Debit','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8973','Cash','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8974','Debit','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8975','Cash','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8976','Debit','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8977','Debit','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8978','Cash','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8979','Debit','IDMRK');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8980','Debit','IDMRK');

--8
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8981','Debit','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8982','Cash','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8983','Cash','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8984','Debit','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8985','Cash','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8986','Debit','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8987','Cash','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8988','Cash','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8989','Debit','IDTKG');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk8990','Cash','IDTKG');

--9
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2021','Debit','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2022','Cash','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2023','Debit','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2024','Debit','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2025','Debit','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2026','Debit','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2027','Cash','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2028','Cash','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2029','Debit','IDBJU');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2030','Debit','IDBJU');

--10
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2054','Cash','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2055','Cash','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2056','Cash','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2057','Debit','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2058','Debit','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2059','Debit','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2060','Cash','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2061','Cash','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2062','Cash','IDGIL');
INSERT INTO [P_OFFLINE] ([Pem_KdPembayaran],[JenisPembayaran],[L_KdLokasi]) VALUES ('Pk2063','Cash','IDGIL');










