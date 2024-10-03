USE [TRANSPORTASI UMUM]

INSERT INTO [PERUSAHAAN] ([KdPerusahaan],[NamaPerusahaan],[AlamatKantorPusat],[Email],[Telp],[ThBerdiri]) VALUES (N'2312313123',N'Bento',N'SOLO',N'bento@gmail',011121212,2010);
INSERT INTO [LOKASI] ([KdLokasi],[Jenis],[NamaLokasi],[Kota],[Negara],[NamaJalan]) VALUES ('67676','TERMINAL','TIRTONADI','SOLO','INDONESIA','SLAMET');
INSERT INTO [APLIKASI] ([KdAplikasi],[NamaAplikasi]) VALUES ('2321323211','Traveloka');
INSERT INTO [RUTE] ([KdRute]) VALUES ('yy212');
INSERT INTO [MENENTUKAN] ([Per_KdPerusahaan],[R_KdRute]) VALUES ('2312313123','yy212');
INSERT INTO [MEMILIKI_CABANG] ([Per_KdPerusahaan],[L_KdLokasi]) VALUES ('2312313123','67676');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('asdadasd',2013,'BIS','BUS MERCY','2312313123');
INSERT INTO [K_DARAT] ([K_KdKendaraan],[JenisJalur]) VALUES ('asdadasd','Jalan Beraspal');
INSERT INTO [PERJALANAN] ([KdPerjalanan],[K_KdKendaraan],[R_KdRute],[L_KdLokasiMenujuKe,[L_KdLokasiMenujuKe]) VALUES ('sfdfdsa33','67676','yy212','asdadasd');
INSERT INTO [PENGEMUDI] ([ID_Pengemudi],[NamaPengemudi],[Lisensi],[K_KdKendaraan],[Per_KdPerusahaan]) VALUES ('54546','joko','SIM B','asdadasd','2312313123');
INSERT INTO [MENGEMUDIKAN] ([K_KdKendaraan],[Peng_ID_Pengemudi]) VALUES ('asdadasd','54546');
INSERT INTO [MELAKUKAN] ([K_KdKendaraan],[Pjl_KdPerjalanan]) VALUES ('asdadasd','sfdfdsa33');
INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('001212','handoko','45','asdadasd');
INSERT INTO [PEMBAYARAN] ([KdPembayaran],[Tarif],[Pen_NIK],[K_KdKendaraan]) VALUES ('8786674765',1000,'001212','asdadasd');
INSERT INTO [TEMPAT_MEMBAYAR] ([Pem_KdPembayaran],[Ap_KdAplikasi],[L_KdLokasi]) VALUES ('8786674765','2321323211','67676');
INSERT INTO [KENDARAAN] ([KdKendaraan],[TahunPembuatan],[JenisKendaraan],[NamaKendaraan],[Per_KdPerusahaan]) VALUES ('assd',2013,'BIS','BUS SET','2312313123');

INSERT INTO [PENUMPANG] ([NIK],[NamaPenumpang],[Umur],[K_KdKendaraan]) VALUES ('001212','Handoko','45','JS852');
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

