# RumahKu Check

Starter website MVP untuk semakan anggaran kemampuan pembelian rumah, padanan inventori dan prospek WhatsApp.

## Keperluan
- Node.js 20+
- Akaun Supabase
- Domain (pilihan untuk fasa deployment)
- Nombor WhatsApp dalam format antarabangsa tanpa `+`, contoh `60182970139`

## 1. Jalankan secara lokal
1. Ekstrak ZIP.
2. Buka terminal dalam folder projek.
3. Jalankan `npm install`.
4. Salin `.env.example` kepada `.env.local`.
5. Isi URL dan anon key Supabase.
6. Jalankan `npm run dev`.
7. Buka `http://localhost:3000`.

Jika Supabase belum disambungkan, halaman utama masih memaparkan inventori demo dan pengiraan tempatan. Admin dan simpanan prospek memerlukan Supabase.

## 2. Sediakan Supabase
1. Cipta projek di https://supabase.com.
2. Buka SQL Editor dan jalankan keseluruhan `supabase/schema.sql`.
3. Ambil Project URL dan anon/public key daripada Project Settings > API.
4. Isi ke `.env.local`.
5. Dalam Authentication, cipta seorang pengguna admin menggunakan email dan kata laluan yang kuat.
6. Dalam Supabase SQL Editor, tetapkan role admin untuk UUID pengguna anda:

```sql
update auth.users
set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb)
  || '{"role":"admin"}'::jsonb
where email = 'EMAIL-ADMIN-ANDA';
```

7. Log masuk melalui `/admin`.

Jangan sekali-kali masukkan `service_role` key ke dalam browser atau `NEXT_PUBLIC_` variable. Admin authorization menggunakan `app_metadata` dan RLS.

## 3. Masukkan inventori
Selepas log masuk ke `/admin/dashboard`, masukkan tajuk, harga, lokasi, jenis rumah, bilik, pegangan, URL gambar, penerangan dan status. Hanya status `available` dipaparkan kepada pengunjung.

## 4. Deploy
1. Push projek ke GitHub.
2. Import repository di https://vercel.com.
3. Masukkan pemboleh ubah `.env.local` dalam Vercel Project Settings > Environment Variables.
4. Deploy.
5. Sambungkan domain sendiri melalui Vercel Domains.

## 5. Penting tentang formula
Formula dalam `src/lib/calc.ts` ialah kalkulator anggaran berasaskan ansuran pinjaman beramortisasi. DSR, peratus elaun, kadar, tempoh dan margin ialah input simulasi, bukan polisi bank universal. Sebelum pelancaran awam, sahkan formula dengan pegawai pembiayaan/bank dan tetapkan kaedah berlainan jika perlu. Keputusan bukan pra-kelulusan atau jaminan kelulusan.

## 6. Privasi dan keselamatan
- Pengiraan dibuat dalam browser; data kewangan tidak dihantar secara automatik.
- Jika pengguna memilih borang prospek dan memberi persetujuan, nama, telefon dan ringkasan kewangan akan disimpan dalam `leads`.
- Paparkan notis privasi lengkap dan maklumat pengendali data sebelum pelancaran.
- Tambah polisi tempoh simpanan, permintaan akses/pembetulan/pemadaman data dan prosedur insiden.
- Jangan minta IC, penyata bank atau dokumen sensitif dalam MVP.
- Semak tetapan RLS dan ujian keselamatan sebelum menerima data pelanggan sebenar.

## Kandungan MVP
- Landing page Bahasa Melayu
- Kalkulator gaji, elaun dan komitmen
- Padanan rumah berdasarkan harga dan lokasi
- Pautan WhatsApp
- Admin login dan dashboard inventori
- Senarai prospek yang memberi persetujuan
- Supabase schema dengan Row Level Security
