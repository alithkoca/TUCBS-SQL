CREATE OR REPLACE VIEW tucbs."TUCBS_Bina"
AS SELECT yapi.objectid AS "tucbsNo",
    NULL::numeric AS "duseyGeometriTahminiDogruluk",
    NULL::boolean AS "referansGeometri",
    'toplamBinaIzdusumu'::text AS "yatayGeometriReferansDegeri",
    NULL::numeric AS "yatayGeometriTahminiDogruluk",
    'yapiTabani'::text AS "yukseklikReferansDegeri",
    yapi.isyeri_sayisi + yapi.daire_sayisi AS "bagimsizBolumSayisi",
    yapi.kbs_bina_no AS "binaKimlikNo",
    yapi.isyeri_sayisi AS "BO_isyeriSayisi",
    yapi.daire_sayisi AS "BO_konutBirimSayisi",
    bbolum.kullanim_alani AS "BO_toplamBagimsizBolumAlani",
    bbolum.kullanim_alani AS "BO_toplamOrtakAlan",
        CASE
            WHEN yapi.yapi_grup = ANY (ARRAY[1, 3, 6, 8, 11]) THEN 'AGrubu'::text
            WHEN yapi.yapi_grup = ANY (ARRAY[2, 4, 7, 9, 12]) THEN 'BGrubu'::text
            WHEN yapi.yapi_grup = ANY (ARRAY[5, 10, 13]) THEN 'CGrubu'::text
            WHEN yapi.yapi_grup = 14 THEN 'DGrubu'::text
            ELSE 'diger'::text
        END AS "BO_yapiGrubuTipi",
    yapi.yapikayitbelgetarih AS "BO_yapiKullanimIzniTarihi",
        CASE
            WHEN yapi.yapi_sinif = 1 THEN '1Sinif'::text
            WHEN yapi.yapi_sinif = 2 THEN '2Sinif'::text
            WHEN yapi.yapi_sinif = 3 THEN '3Sinif'::text
            ELSE 'diger'::text
        END AS "BO_yapiSinifiTipi",
    NULL::text AS "BTO_atiksuTipi",
    NULL::text AS "BTO_catiMalzemesiTuru",
    NULL::text AS "BTO_catiTipi",
    NULL::boolean AS "BTO_dogalgazBaglantisi",
    NULL::boolean AS "BTO_elektrikBaglantisi",
    NULL::text AS "BTO_enerjiVerimliligiDegeri",
    NULL::boolean AS "BTO_icmeSuyuBaglantisi",
    NULL::text AS "BTO_icmeSuyuTipi",
    NULL::text AS "BTO_isitmaSistemTipi",
    NULL::text AS "BTO_isitmaYakitTipi",
    NULL::boolean AS "BTO_kanalizasyonBaglantisi",
    NULL::text AS "BTO_ortakKullanimAlanlariTipi",
    NULL::text AS "BTO_sicakSuTeminSekliTipi",
    NULL::text AS "BTO_sicakSuYakitCinsiTipi",
    NULL::text AS "BTO_tesisatTipi",
    NULL::text AS "kullanimAltTuru",
    yapi.katadedi AS "toplamKatsayisi",
    NULL::text AS "yapiTipiDegeri",
    NULL::numeric AS "zeminAltiDerinlik",
    NULL::numeric AS "zeminAltiKatsayisi",
    NULL::integer AS "zeminUstuKatSayisi",
    yapi.yapi_adi AS adi,
    NULL::numeric AS "OY_yukseklikDegeri",
    NULL::text AS "OY_yukseklikReferansDegeri",
    NULL::text AS "RD_dokumanBaglantisi",
    NULL::text AS "RD_dokumanBicimTipi",
    NULL::date AS "RD_tarih",
    yapi.m_date AS "surumBaslangicZamani",
    NULL::date AS "surumBitisZamani",
    yapi.tabanalani AS "toplamTabanAlani",
    NULL::text AS "yapiDurumDegeri",
    NULL::text AS "yapininOneCikanOzelligi",
    NULL::text AS "YO_depremYerHareketDuzeyiTipi",
    yapi.insaat_alani AS "YO_toplamInsaatAlani",
    NULL::numeric AS "YO_yapiMaliyeti",
    NULL::date AS "YO_yapiRuhsatiOnayTarihi",
    NULL::date AS "yapiTamamlanmaTarihi",
    NULL::date AS "yapiYenilemeTarihi",
    NULL::date AS "yapiYikimTarihi",
    NULL::text AS "YTO_cepheMalzemesiTuru",
    NULL::text AS "YTO_dosemeTipi",
    NULL::text AS "YTO_duvarDolguMalzemesiTipi",
    NULL::text AS "YTO_mevcutBetonarmeDonatiTipi",
    NULL::text AS "YTO_tasiyiciSistemTipi",
    NULL::text AS "YTO_temelTipi",
    NULL::numeric AS "YIY_deger",
    NULL::text AS "YIY_yukseklikReferansDegeriAlt",
    NULL::text AS "YIY_yukseklikReferansDegeriUst",
    st_transform(yapi.poly, 4326) AS geometri
   FROM yapi
     LEFT JOIN bbolum ON yapi.nc_id::text = bbolum.nc_numaratajid::text
  WHERE yapi.geo_durum IS TRUE;

CREATE VIEW tucbs."TUCBS_Buyuksehir_Belediye"  AS
SELECT objectid AS "tucbsNo", 
ad AS "adi",
'belediye'::text AS "idariHiyerarsiDuzeyKodu",
NULL::date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::text AS "IdariMerkez_adi",
st_transform(poly,4326) AS "geometri",
NULL::geometry AS "IdariMerkez_geometri"
FROM geobelediye where objectid = 15;

CREATE VIEW tucbs."TUCBS_CDP" AS
SELECT objectid AS "tucbsNo",
'ustYerel'::text AS "mekansalPlanDuzeyi",
plan_onay_tarihi AS "onayTarihi",
plan_adi  AS "planAdi",
pin AS "planIslemNumarasi",
'PlanSiniri'::text AS "planSiniri",
'CevreDuzeniPlani'::text AS "planTuru",
bsb_mec_kar_tar AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
NULL::text AS "yonetmelikAtfi",
NULL::text AS "yonetmelikTarihi",
NULL::text AS "kullanilanAltlikHaritaReferans",
NULL::text AS "kullanilanAltlikHaritaTarihi",
NULL::text AS "kullanilanAltlikHaritaURI",
'yururlukte'::text AS "planSureci",
m_date  AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::date AS "planliAraziKullanimKarariDeger",
NULL::date AS "hilucsAraziKullanimi",
NULL::date AS "hilucsDurumu",
NULL::date AS "gostergeReferansi",
NULL::date AS "yasalBaglayicilikDurumu",
NULL::date AS "avrupaSinirlayiciMevzuat",
NULL::date AS "sinirlayiciMevzuat",
plan_adi AS adi,
NULL::date AS "digerPlanlardanAlinmaDurumu",
NULL::date AS "sinirlayiciMevzuatSureci",
NULL::date AS "IDA_ad",
NULL::date AS "IDA_kisaAd",
NULL::date AS "IDA_ozelReferans",
NULL::date AS "IDA_tarih",
NULL::date AS "IDA_CI_Date",
NULL::date AS "IDA_url",
NULL::date AS "ilgiliKanunYonetmelikAtfi",
NULL::date AS "dokumanResmiSayisi",
NULL::date AS "cevrimiciSurumBaglantisi",
NULL::date AS "ResmiGazeteBilgisi_ISBN",
NULL::date AS "ResmiGazeteBilgisi_ISSN",
NULL::date AS "resmiGazeteKimligi",
pin AS "kimlikNumarasi",
NULL::date AS "seviye_HukumSeviyeDegeri",
bsb_mec_kar_tar  AS "yururlugeGirisTarihi",
NULL::date AS "yururluktenKaldirilisTarihi",
NULL::date AS "yonetmelikMetni",
st_transform(poly,4326) AS geometri
FROM geoplan_sinir_cdp where geo_durum is true;


create or replace VIEW tucbs."TUCBS_Ilce_Belediye"  AS
SELECT objectid AS "tucbsNo", 
ad AS "adi",
'belediye'::text AS "idariHiyerarsiDuzeyKodu",
NULL::date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::text AS "IdariMerkez_adi",
'buyuksehirIlceBelediyesi'::text AS "belediyeTipi",
st_transform(poly,4326) AS "geometri",
NULL::geometry AS "IdariMerkez_geometri"
FROM geobelediye  where objectid  != 15;


CREATE VIEW tucbs."TUCBS_JeoteknikEtud" AS
SELECT objectid AS "tucbsNo",
m_date AS " kayitTarihi",
NULL::integer AS "tasinmazKimlikNo",
NULL::numeric AS "alanDegeri",
NULL::integer AS "parselNumarasi",
NULL::text AS "ParselTuru",
NULL::text AS "ulusalKadastralReferans",
NULL::date AS " surumBaslangicZamani",
NULL::date AS " surumBitisZamani",
st_area(st_transform(poly,4326)::geography) AS "projeAlan",
NULL::date AS "basvuruTarihi",
yu_aciklama AS "projeAdi",
NULL::text AS "projeNo",
NULL::text AS "ProjeTipiDegeri",
NULL::text AS "ProjeOnaylayanKurumDegeri",
yu_aciklama AS "aciklama",
NULL::date AS "baslangicTarihi",
NULL::date AS "bitisTarihi",
NULL::text AS "ProjeyiYapanKurumDegeri",
NULL::date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
st_transform(poly,4326) AS "JeoteknikAlani_alan",
NULL::geometry AS "Parsel_alan"
FROM public.geojeoloji;


CREATE VIEW tucbs."TUCBS_KarayoluHatti" AS
SELECT objectid AS "tucbsNo",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
'false'::boolean AS "sanalMi",
yol_adi  AS " adi", 
NULL::date AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
maks_kod  AS "kontrolKesimNumarasi",
NULL::text AS "tahsisliSeritDegeri",
NULL::text AS "tanimi",
st_transform(poly,4326) AS "ortaHatGeometrisi"
FROM geoyol;


CREATE VIEW tucbs."TUCBS_Mahalle" AS
SELECT objectid AS tucbsNo, 
adi_numarasi  AS adi,
'mahalle'::text AS idariHiyerarsiDuzeyKodu,
m_date AS surumBaslangicZamani,
NULL::date AS surumBitisZamani,
NULL::text AS IdariMerkez_adi,
st_transform(poly,4326) AS geometri,
NULL::geometry AS IdariMerkez_geometri
FROM geomahalle;


CREATE VIEW tucbs."TUCBS_NIP" AS
SELECT objectid AS "tucbsNo",
'ustYerel'::text AS "mekansalPlanDuzeyi",
plan_onay_tarihi  AS "onayTarihi",
plan_adi  AS "planAdi",
pin  AS "planIslemNumarasi",
'PlanSiniri'::text AS "planSiniri",
'NazimImarPlani'::text AS "planTuru",
bsb_mec_kar_tar  AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
NULL::text AS "yonetmelikAtfi",
NULL::text AS "yonetmelikTarihi",
NULL::text AS "kullanilanAltlikHaritaReferans",
NULL::text AS "kullanilanAltlikHaritaTarihi",
NULL::text AS "kullanilanAltlikHaritaURI",
'yururlukte'::text AS "planSureci",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::text AS "planliAraziKullanimKarariDeger",
NULL::text AS "hilucsAraziKullanimi",
NULL::text AS "hilucsDurumu",
NULL::text AS "gostergeReferansi",
'evet' AS "yasalBaglayicilikDurumu",
NULL::text AS "avrupaSinirlayiciMevzuat",
NULL::text AS "sinirlayiciMevzuat",
plan_adi AS adi,
NULL::date AS "digerPlanlardanAlinmaDurumu",
NULL::date AS "sinirlayiciMevzuatSureci",
NULL::date AS "IDA_ad",
NULL::date AS "IDA_kisaAd",
NULL::date AS "IDA_ozelReferans",
NULL::date AS "IDA_tarih",
NULL::date AS "IDA_CI_Date",
NULL::date AS "IDA_url",
NULL::date AS "ilgiliKanunYonetmelikAtfi",
NULL::date AS "dokumanResmiSayisi",
NULL::date AS "cevrimiciSurumBaglantisi",
NULL::date AS "ResmiGazeteBilgisi_ISBN",
NULL::date AS "ResmiGazeteBilgisi_ISSN",
NULL::date AS "resmiGazeteKimligi",
pin AS "kimlikNumarasi",
NULL::date AS "seviye_HukumSeviyeDegeri",
bsb_mec_kar_tar  AS "yururlugeGirisTarihi",
NULL::date AS "yururluktenKaldirilisTarihi",
NULL::date AS "yonetmelikMetni",
st_transform(poly,4326)  AS geometri
FROM geoplan_sinir_5000 where geo_durum is true;


CREATE VIEW tucbs."TUCBS_UIP" AS
SELECT objectid AS "tucbsNo",
'ustYerel'::text AS "mekansalPlanDuzeyi",
plan_onay_tarihi  AS "onayTarihi",
plan_adi  AS "planAdi",
pin  AS "planIslemNumarasi",
'PlanSiniri'::text AS "planSiniri",
'uygulamaImarPlani'::text AS "planTuru",
bsb_mec_kar_tar  AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
NULL::text AS "yonetmelikAtfi",
NULL::text AS "yonetmelikTarihi",
NULL::text AS "kullanilanAltlikHaritaReferans",
NULL::text AS "kullanilanAltlikHaritaTarihi",
NULL::text AS "kullanilanAltlikHaritaURI",
'yururlukte'::text AS "planSureci",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::text AS "planliAraziKullanimKarariDeger",
NULL::text AS "hilucsAraziKullanimi",
NULL::text AS "hilucsDurumu",
NULL::text AS "gostergeReferansi",
'evet' AS "yasalBaglayicilikDurumu",
NULL::text AS "avrupaSinirlayiciMevzuat",
NULL::text AS "sinirlayiciMevzuat",
plan_adi AS adi,
NULL::date AS "digerPlanlardanAlinmaDurumu",
NULL::date AS "sinirlayiciMevzuatSureci",
NULL::date AS "IDA_ad",
NULL::date AS "IDA_kisaAd",
NULL::date AS "IDA_ozelReferans",
NULL::date AS "IDA_tarih",
NULL::date AS "IDA_CI_Date",
NULL::date AS "IDA_url",
NULL::date AS "ilgiliKanunYonetmelikAtfi",
NULL::date AS "dokumanResmiSayisi",
NULL::date AS "cevrimiciSurumBaglantisi",
NULL::date AS "ResmiGazeteBilgisi_ISBN",
NULL::date AS "ResmiGazeteBilgisi_ISSN",
NULL::date AS "resmiGazeteKimligi",
pin AS "kimlikNumarasi",
NULL::date AS "seviye_HukumSeviyeDegeri",
bsb_mec_kar_tar  AS "yururlugeGirisTarihi",
NULL::date AS "yururluktenKaldirilisTarihi",
NULL::date AS "yonetmelikMetni",
st_transform(poly,4326)  AS geometri
FROM geoplan_sinir_1000 where geo_durum is true;

CREATE VIEW tucbs."TUCBS_Numarataj" AS
SELECT objectid AS "tucbsNo",
'kapiBelirleyici'::text AS "AK_konumlayiciTipi",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
geokapi.adi AS "binaAdi",
nc_binakodu AS "binaKodu",
kapi_no  AS "kapiNumarasi",
yapi_id AS "numaratajKodu",
a.adi AS "numaratajTipi",
'buyuksehirBelediyesi'::text AS "yetkiliIdare",
st_transform(poly,4326) AS "konum"
FROM geokapi 
left join public.kod_kapi_cinsi a on a.maks_kod = geokapi.kapi_cinsi_id
where geo_durum is true;


CREATE VIEW tucbs."TUCBS_Otogar" AS
SELECT objectid AS "tucbsNo",
adi,
NULL::text AS "AgReferansi_AgElemani_tucbsNo",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::date AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
NULL::text AS "KarayoluServisTipDegeri",
NULL::text AS "sinyalizasyonLambaTipi",
NULL::text AS "YapiveTesisOlanaklari",
NULL::integer AS "kapasite",
'false'::boolean AS "sensorVarMi",
st_transform(poly,4326) AS "geometri"
FROM geopoi where upper(adi) like '%OTOBÜS%';



CREATE VIEW tucbs."TUCBS_Otopark" AS
SELECT objectid AS "tucbsNo",
adi,
NULL::text AS "AgReferansi_AgElemani_tucbsNo",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::date AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
'tumAraclar'::text AS "aracTipiDegeri",
NULL::boolean AS "kapasite",
NULL::boolean AS "sensor",
st_transform(poly,4326) AS "geometri"
FROM geopoi where upper(adi) like '%OTOPARK%';

CREATE VIEW tucbs."TUCBS_Park" AS
SELECT objectid AS "tucbsNo",
'Park'::text AS "planliAraziKullanimKarariDeger",
adi,
NULL::date AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
NULL::text AS "hilucsAraziKullanimi",
NULL::text AS "hilucsDurumu",
NULL::text AS "kullanilanAltlikHaritaReferans",
NULL::text AS "kullanilanAltlikHaritaTarihi",
NULL::text AS "kullanilanAltlikHaritaURI",
NULL::text AS "planliAraziKullanimKarariDurum",
'yururlukte'::text AS "planSureci",
NULL::text AS "gostergeReferansi",
'evet'::text AS "yasalBaglayicilikDurumu",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
st_transform(poly,4326) AS "geometri"
FROM geopoi where faaliyet_id in (358, 359, 362)

CREATE VIEW tucbs."TUCBS_POI" AS
SELECT objectid AS "tucbsNo",
NULL::text AS "HKT_adresIleHK",
NULL::text AS "HKT_binaIleHK",
NULL::text AS "HKT_DugumNoktasiIleHK",
geopoi.adi AS "HKT_faaliyetKompleksiIleHK",
st_transform(poly,4326)  AS "HKT_geometriIleHK",
case 
when a.ustkod in (20, 51) then 'egitim'
when a.ustkod in (18) then 'guvenlik'
when a.ustkod in (68) then 'cevreselKoruma'
when a.ustkod in (16, 11, 56, 43) then 'saglik'
when a.ustkod in (52, 14) then 'belediye'
when a.ustkod in (61) then 'yonetim'
when a.ustkod in (15, 3, 1, 4, 30) then 'ulasim'
when a.ustkod in (12) then 'konutVeKonaklama'
when a.ustkod in (21, 22, 32, 9, 34, 50, 66) then 'aileVeSosyal'
when a.ustkod in (17, 33) then 'dini'
when a.ustkod in (31, 59, 42, 13) then 'kulturel'
when a.ustkod in (25, 67) then 'turizmVeEglence'
when a.ustkod in (26, 29, 38, 5, 36, 39, 40, 35, 70, 6, 60, 44, 47) then 'ticaretVeMaliye'
when a.ustkod in (69) then 'endustriEnerjiGidaTarimHayvancilik'
when a.ustkod in (37) then 'yargiVeAdalet'
when a.ustkod in (8, 19, 62) then 'digerResmiKurum'
else 'diger' end AS "hizmetTipi",
NULL::text AS "Iletisim_adres",
NULL::text AS "Iletisim_calismaSaatleri",
NULL::text AS "Iletisim_eposta",
NULL::text AS "Iletisim_faks",
NULL::text AS "Iletisim_iletisimTalimatlari",
NULL::text AS "Iletisim_telefon",
NULL::text AS "Iletisim_webAdresi",
NULL::text AS "agIleSorumlulukAlani",
'Büyükşehir Belediyesi Sınırları'::text AS "SorumlulukAlanTipi_yazim",
'Diyarbakır Büyükşehir Belediyesi'::text AS "idariBirimIleSorumlulukAlani",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::geometry AS "poligonIleSorumlulukAlani"
FROM geopoi 
left join vga_kod_kullanim_amaci_kr_table a on a.kod = geopoi.faaliyet_id
where geo_durum is true;


CREATE VIEW tucbs."TUCBS_Durak" AS
SELECT objectid AS "tucbsNo", 
NULL::text AS "AgReferansi_AgElemani_tucbsNo",
m_date AS "surumBaslangicZamani",
NULL::date AS "surumBitisZamani",
NULL::date AS "gecerlilikBaslangici",
NULL::date AS "gecerlilikSonu",
'duraklamaVeParkEtmeIsaretleri'::text AS "envanterTuru",
'Diyarbakır Büyükşehir Belediyesi'::text AS "sorumluKurum",
st_transform(poly,4326) AS "geometri"
FROM geoulasim_durak;
